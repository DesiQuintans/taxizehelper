#' Retrieve and parse full taxonomic information for a list of taxa.
#'
#' \code{search_gnr()} is a wrapper for \code{taxize::gnr_resolve()} that parses its
#' output and returns a neat dataframe of taxonomic information, with every rank in a
#' separate column. The ICN ranks (kingdom, phylum, class, order, family, genus) are
#' ordered so that they can be accessed with \code{kingdom:genus}. All other ranks
#' (super-, sub-, infra- versions of ICN ranks, plus tribe) are ordered to the right.
#' Finally, the raw \code{path} and \code{ranks} strings are retained so that you can
#' double-check them if you want.
#'
#' @param species_list (Char) A vector of taxa names.
#' @param excluded_sources (Char) A vector of sources to exclude (see
#'   \code{taxize::gnr_datasources()}. By default, excludes Open Tree of Life Reference
#'   Taxonomy, The Paleobiology Database, Union 4, and Wikispecies because rank output
#'   from these sources is poorly structured and hard to parse.
#'
#' @return A dataframe of taxonomic information, with every rank in a separate column.
#' @export
#'
#' @importFrom magrittr "%>%"
#'
#' @examples
#' my_species <- c("Coptodactyla meridionalis", "Torymus chrysochlorus", "Anaspis rufa")
#' search_gnr(my_species)
search_gnr <- function(species_list, excluded_sources = c("Open Tree of Life Reference Taxonomy", "The Paleobiology Database", "Union 4", "Wikispecies")) {
    raw_gnr <- taxize::gnr_resolve(unique(species_list), fields = "all")

    gnr_out <-
        raw_gnr %>%
        dplyr::filter(!(data_source_title %in% excluded_sources)) %>%
        dplyr::select(user_supplied_name, binomial = submitted_name, path = classification_path,
               ranks = classification_path_ranks) %>%
        dplyr::filter(!stringr::str_detect(ranks, "(no|above|unranked|(\\|\\|{8,})|^$)")) %>%  # Safety screening of ranks.
        # path and ranks are enclosed with pipes for downstream regex.
        dplyr::mutate_at(dplyr::vars(path, ranks), str_replace, "^\\|?(.*?)\\|?$", "|\\1|") %>%
        dplyr::arrange(binomial, dplyr::desc(stringr::str_count(ranks, "\\|"))) %>%  # More pipes = more information.
        dplyr::distinct(binomial, .keep_all = TRUE) %>%
        dplyr::mutate(superkingdom = get_level(ranks, path, "superkingdom"),
               kingdom = get_level(ranks, path, "kingdom"),
               phylum = get_level(ranks, path, "phylum"),
               superclass = get_level(ranks, path, "superclass"),
               class = get_level(ranks, path, "class"),
               subclass = get_level(ranks, path, "subclass"),
               infraclass = get_level(ranks, path, "infraclass"),
               cohort = get_level(ranks, path, "cohort"),
               order = get_level(ranks, path, "order"),
               suborder = get_level(ranks, path, "suborder"),
               infraorder = get_level(ranks, path, "infraorder"),
               superfamily = get_level(ranks, path, "superfamily"),
               family = get_level(ranks, path, "family"),
               subfamily = get_level(ranks, path, "subfamily"),
               tribe = get_level(ranks, path, "tribe"),
               subtribe = get_level(ranks, path, "subtribe"),
               genus = get_level(ranks, path, "genus"),
               subgenus = get_level(ranks, path, "subgenus")
        ) %>%
        dplyr::select(user_supplied_name, binomial, kingdom, phylum, class, order, family,
               genus, dplyr::everything(), -path, -ranks, path, ranks)

    return(gnr_out)
}



# Parse taxonomic levels to get names
#
# \code{taxize::gnr_resolve()} provides taxonomic info in two columns: a \code{classification_path_ranks} column
# (order|family|genus) and a \code{classification_path} column (Lepidoptera|Tortricidae|Capua). I can use the
# ranks as a guide for parsing the path.
#
# @param ranks (Char) Taxonomic ranks in the form \code{...order|family|genus...}
# @param path (Char) Taxonomic names in the form \code{...Lepidoptera|Tortricidae|Capua...}
# @param level (Char) Which rank to extract.
# @param fill (Char) What to return when \code{level} is not found in \code{ranks}.
#
# @return A character vector of names.
#
# @examples
# my_ranks <- "kingdom|phylum|class|order|family|genus|"
# my_path  <- "|Animalia|Arthropoda|Insecta|Coleoptera|Melandryidae|Abdera"
# get_level(my_ranks, my_path, level = "class")
get_level <- function(ranks, path, level, fill = "") {
    l_ranks <- stringr::str_to_lower(stringr::str_replace(ranks, "^\\|?(.*?)\\|?$", "|\\1|"))
    l_path <- stringr::str_replace(path, "^\\|?(.*?)\\|?$", "|\\1|")

    ranks_needle <- stringr::regex(paste0("\\|", level, ".*?$"), ignore_case = TRUE)
    truncated_ranks <- stringr::str_extract(l_ranks, ranks_needle)
    trailing_groups <- stringr::str_count(truncated_ranks, "[\\w\\s]*\\|") - 2
    # The number of groups that are to the right of `level`. -1 for the initial pipe
    # and -1 for the target group.
    trailing_groups <- ifelse(is.na(trailing_groups), 0, trailing_groups)
    # NAs stop the regex.

    results_needle <- paste0("([\\s\\w]*)(?:\\|([\\s\\w]*\\|){", trailing_groups, "})$")
    results <- stringr::str_match(l_path, results_needle)[,2]  # 2 is the column of interest.
    results <- ifelse(stringr::str_length(results) == 0, fill, results)

    level_absent <- !stringr::str_detect(l_ranks, paste0("\\|", level, "\\|"))
    results <- ifelse(level_absent == TRUE, fill, results)

    return(results)
}

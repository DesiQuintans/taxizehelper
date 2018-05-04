<!-- README.md is generated from README.Rmd. Please edit that file -->
taxizehelper: Convenience functions for the `taxize` package.
=============================================================

Project participants
--------------------

-   Desi Quintans \[@eco\_desi\](<https://twitter.com/eco_desi>)

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

What is `taxizehelper`?
-----------------------

`taxizehelper` is a personal package that helps me use rOpenSci's [`taxize`](https://ropensci.org/tutorials/taxize_tutorial/) package more succinctly. `taxize` helps you retrieve up-to-date taxonomic information, so you can easily do things like:

1.  Ensure that you're referring to species by their current names.
2.  Error-check and repair a list of misspelled names.
3.  Retrieve taxonomic ranks (order, class, family etc.) for names.
4.  Discover the authorities who named your species.

Installation
------------

``` r
install.packages("devtools")
devtools::install_github("DesiQuintans/taxizehelper")
library(taxizehelper)
```

`taxizehelper` currently has only one function:

1.  `search_gnr(species_list)` --- Get taxonomic info for a list of taxa in a tidy dataframe.

Ex. 1: Use `search_gnr()` to get a dataframe of taxonomic ranks
---------------------------------------------------------------

``` r
# A list of insect species recorded within 1 km of my university.
data("wsu_hwk_insects")
print(wsu_hwk_insects)
#>  [1] "Apis mellifera"          "Heteronympha merope"    
#>  [3] "Yoyetta celis"           "Vespula germanica"      
#>  [5] "Atrapsalta corticina"    "Aleeta curvicosta"      
#>  [7] "Psaltoda plaga"          "Galanga labeculata"     
#>  [9] "Hadrocolletes fulvus"    "Cyclochila australasiae"
#> [11] "Pieris rapae"            "Danaus chrysippus"      
#> [13] "Yoyetta repetens"        "Musgraveia sulciventris"
#> [15] "Tectocoris diophthalmus" "Cystosoma saundersii"   
#> [17] "Synemon plana"           "Papilio anactus"        
#> [19] "Gastrimargus musicus"    "Popplepsalta notialis"  
#> [21] "Laccotrephes tristis"    "Graphium macleayanum"   
#> [23] "Geitoneura minyas"       "Leptotes plinius"       
#> [25] "Diamesus osculans"       "Ptomaphila lacrymosa"   
#> [27] "Tenodera australasiae"   "Hippodamia variegata"

output <- 
    search_gnr(wsu_hwk_insects) %>% 
    head(5)
```

Below is the first few rows of `search_gnr()`'s output. The ICN ranks are ordered so that you can access them with `kingdom:genus`. I intentionally kept an old name in the case of *Hadrocolletes fulvus*, and `taxize` retrieved the current genus *Leioproctus*.

| user\_supplied\_name    | binomial                | kingdom  | phylum     | class   | order       | family    | genus      | superkingdom | superclass | subclass  | infraclass | cohort       | suborder        | infraorder   | superfamily | subfamily    | tribe        | subtribe | subgenus | path                                                                                                                                                                                                                                                                                                          | ranks                                                                                                                                                         |
|:------------------------|:------------------------|:---------|:-----------|:--------|:------------|:----------|:-----------|:-------------|:-----------|:----------|:-----------|:-------------|:----------------|:-------------|:------------|:-------------|:-------------|:---------|:---------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Aleeta curvicosta       | Aleeta curvicosta       | Metazoa  | Arthropoda | Insecta | Hemiptera   | Cicadidae | Aleeta     | Eukaryota    | Hexapoda   | Pterygota | Neoptera   | Paraneoptera | Auchenorrhyncha | Cicadomorpha | Cicadoidea  | Cicadettinae | Taphurini    |          |          | |Eukaryota|Opisthokonta|Metazoa|Eumetazoa|Bilateria|Protostomia|Ecdysozoa|Panarthropoda|Arthropoda|Mandibulata|Pancrustacea|Hexapoda|Insecta|Dicondylia|Pterygota|Neoptera|Paraneoptera|Hemiptera|Auchenorrhyncha|Cicadomorpha|Cicadoidea|Cicadidae|Cicadettinae|Taphurini|Aleeta|Aleeta curvicosta|          | |superkingdom||kingdom||||||phylum|||superclass|class||subclass|infraclass|cohort|order|suborder|infraorder|superfamily|family|subfamily|tribe|genus|species| |
| Apis mellifera          | Apis mellifera          | Metazoa  | Arthropoda | Insecta | Hymenoptera | Apidae    | Apis       | Eukaryota    | Hexapoda   | Pterygota | Neoptera   | Holometabola | Apocrita        | Aculeata     | Apoidea     | Apinae       | Apini        |          |          | |Eukaryota|Opisthokonta|Metazoa|Eumetazoa|Bilateria|Protostomia|Ecdysozoa|Panarthropoda|Arthropoda|Mandibulata|Pancrustacea|Hexapoda|Insecta|Dicondylia|Pterygota|Neoptera|Holometabola|Hymenoptera|Apocrita|Aculeata|Apoidea|Apidae|Apinae|Apini|Apis|Apis mellifera|                                        | |superkingdom||kingdom||||||phylum|||superclass|class||subclass|infraclass|cohort|order|suborder|infraorder|superfamily|family|subfamily|tribe|genus|species| |
| Atrapsalta corticina    | Atrapsalta corticina    | Metazoa  | Arthropoda | Insecta | Hemiptera   | Cicadidae | Atrapsalta | Eukaryota    | Hexapoda   | Pterygota | Neoptera   | Paraneoptera | Auchenorrhyncha | Cicadomorpha | Cicadoidea  | Cicadettinae | Cicadettini  |          |          | |Eukaryota|Opisthokonta|Metazoa|Eumetazoa|Bilateria|Protostomia|Ecdysozoa|Panarthropoda|Arthropoda|Mandibulata|Pancrustacea|Hexapoda|Insecta|Dicondylia|Pterygota|Neoptera|Paraneoptera|Hemiptera|Auchenorrhyncha|Cicadomorpha|Cicadoidea|Cicadidae|Cicadettinae|Cicadettini|Atrapsalta|Atrapsalta corticina| | |superkingdom||kingdom||||||phylum|||superclass|class||subclass|infraclass|cohort|order|suborder|infraorder|superfamily|family|subfamily|tribe|genus|species| |
| Cyclochila australasiae | Cyclochila australasiae | Animalia | Arthropoda | Insecta | Hemiptera   | Cicadidae | Cyclochila |              |            |           |            |              |                 |              | Cicadoidea  |              |              |          |          | |Animalia|Arthropoda|Insecta|Hemiptera|Cicadoidea|Cicadidae|Cyclochila|Cyclochila australasiae|                                                                                                                                                                                                               | |kingdom|phylum|class|order|superfamily|family|genus|species|                                                                                                 |
| Cystosoma saundersii    | Cystosoma saundersii    | Metazoa  | Arthropoda | Insecta | Hemiptera   | Cicadidae | Cystosoma  | Eukaryota    | Hexapoda   | Pterygota | Neoptera   | Paraneoptera | Auchenorrhyncha | Cicadomorpha | Cicadoidea  | Tibicininae  | Hemidictyini |          |          | |Eukaryota|Opisthokonta|Metazoa|Eumetazoa|Bilateria|Protostomia|Ecdysozoa|Panarthropoda|Arthropoda|Mandibulata|Pancrustacea|Hexapoda|Insecta|Dicondylia|Pterygota|Neoptera|Paraneoptera|Hemiptera|Auchenorrhyncha|Cicadomorpha|Cicadoidea|Cicadidae|Tibicininae|Hemidictyini|Cystosoma|Cystosoma saundersii|  | |superkingdom||kingdom||||||phylum|||superclass|class||subclass|infraclass|cohort|order|suborder|infraorder|superfamily|family|subfamily|tribe|genus|species| |

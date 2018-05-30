<!-- README.md is generated from README.Rmd. Please edit that file -->
taxizehelper: Convenience functions for the `taxize` package.
=============================================================

What is `taxizehelper`?
-----------------------

`taxizehelper` is a personal package that helps me use rOpenSci's [`taxize`](https://ropensci.org/tutorials/taxize_tutorial/) package more succinctly. `taxize` helps you retrieve up-to-date taxonomic information, so you can easily do things like:

1.  Ensure that you're referring to species by their current names.
2.  Error-check and repair a list of misspelled names.
3.  Retrieve taxonomic ranks (order, class, family etc.) for names.
4.  Discover the authorities who named your species.

Project participants
--------------------

-   Desi Quintans (<https://twitter.com/eco_desi>)

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

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

output <- search_gnr(wsu_hwk_insects) 
#> Warning: package 'bindrcpp' was built under R version 3.4.4

class(output) 
#> [1] "tbl_df"     "tbl"        "data.frame"

glimpse(output, width = 85)
#> Observations: 28
#> Variables: 22
#> $ user_supplied_name <chr> "Apis mellifera", "Heteronympha merope", "Yoyetta cel...
#> $ binomial           <chr> "Apis mellifera", "Heteronympha merope", "Yoyetta cel...
#> $ kingdom            <chr> "Metazoa", "Metazoa", "Metazoa", "Metazoa", "Metazoa"...
#> $ phylum             <chr> "Arthropoda", "Arthropoda", "Arthropoda", "Arthropoda...
#> $ class              <chr> "Insecta", "Insecta", "Insecta", "Insecta", "Insecta"...
#> $ order              <chr> "Hymenoptera", "Lepidoptera", "Hemiptera", "Hymenopte...
#> $ family             <chr> "Apidae", "Nymphalidae", "Cicadidae", "Vespidae", "Ci...
#> $ genus              <chr> "Apis", "Heteronympha", "Yoyetta", "Vespula", "Atraps...
#> $ superkingdom       <chr> "Eukaryota", "Eukaryota", "Eukaryota", "Eukaryota", "...
#> $ superclass         <chr> "Hexapoda", "Hexapoda", "Hexapoda", "Hexapoda", "Hexa...
#> $ subclass           <chr> "Pterygota", "Pterygota", "Pterygota", "Pterygota", "...
#> $ infraclass         <chr> "Neoptera", "Neoptera", "Neoptera", "Neoptera", "Neop...
#> $ cohort             <chr> "Holometabola", "Holometabola", "Paraneoptera", "Holo...
#> $ suborder           <chr> "Apocrita", "Glossata", "Auchenorrhyncha", "Apocrita"...
#> $ infraorder         <chr> "Aculeata", "Neolepidoptera", "Cicadomorpha", "Aculea...
#> $ superfamily        <chr> "Apoidea", "Papilionoidea", "Cicadoidea", "Vespoidea"...
#> $ subfamily          <chr> "Apinae", "Satyrinae", "Cicadettinae", "Vespinae", "C...
#> $ tribe              <chr> "Apini", "Satyrini", "Cicadettini", "", "Cicadettini"...
#> $ subtribe           <chr> "", "Hypocystina", "", "", "", "", "", "", "", "", ""...
#> $ subgenus           <chr> "", "", "", "", "", "", "", "", "", "", "", "Anosia",...
#> $ path               <chr> "|Eukaryota|Opisthokonta|Metazoa|Eumetazoa|Bilateria|...
#> $ ranks              <chr> "|superkingdom||kingdom||||||phylum|||superclass|clas...
```

The ICN ranks are ordered so that you can access them with `kingdom:genus`.

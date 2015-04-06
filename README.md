resteasy
========



`resteasy` gives you access to data from [GBIF](http://www.gbif.org/) via their REST API. GBIF versions their API - we are currently using `v1` of their API. You can no longer use their old API in this package - see `?resteasy-defunct`.

## Installation


```r
install.packages("devtools")
devtools::install_github("sckott/resteasy")
```


```r
library("resteasy")
```

## GET a README file


```r
easy_readme("sckott/testeasy")
#> # testeasy
#> 
#> hey there!
#> 
#> This is how we do it. 
#> 
#> ```r
#> print("hello world")
#> ```
#> 
#> ## things
#> 
#> adfadfafasdf
#> 
#> ## stuff
#> 
#> asdfadfsdfdsafasdf
#> 
#> asdfasdfasdf
```

## GET a csv file as a data.frame

Get the whole file


```r
easy_get("ropensci/datasets", "mammals/mammals.csv")
#> Source: local data frame [2,022 x 7]
#> 
#>                   Species Mass_ln_g First_appearance_mya
#> 1   Barylambda churchilli    12.718                 57.1
#> 2       Barylambda faberi    13.118                 57.4
#> 3  Barylambda jackwilsoni    11.870                 59.7
#> 4      Coryphodon armatus    13.070                 53.9
#> 5     Coryphodon eocaenus    12.881                 55.4
#> 6      Coryphodon lobatus    13.731                 53.8
#> 7     Coryphodon proterus    13.609                 55.7
#> 8      Coryphodon radians    13.385                 53.9
#> 9     Caenolambda jepseni    11.790                 59.3
#> 10    Caenolambda jepseni     1.461                 68.3
#> ..                    ...       ...                  ...
#> Variables not shown: Last_appearance_mya (dbl), Family (fctr),
#>   Order_or_higher (fctr), Limb_morphology (fctr)
```

Filter by a column, `Family = "Coryphodontidae"`


```r
easy_get("ropensci/datasets", "mammals/mammals.csv", Family = "Coryphodontidae")
#> Source: local data frame [5 x 7]
#> 
#>               Species Mass_ln_g First_appearance_mya Last_appearance_mya
#> 1  Coryphodon armatus     13.07                 53.9                  50
#> 2 Coryphodon eocaenus    12.881                 55.4                55.1
#> 3  Coryphodon lobatus    13.731                 53.8                51.2
#> 4 Coryphodon proterus    13.609                 55.7                55.6
#> 5  Coryphodon radians    13.385                 53.9                51.2
#> Variables not shown: Family (chr), Order_or_higher (chr), Limb_morphology
#>   (chr)
```

Filter by a column, `Last_appearance_mya = 50`


```r
easy_get("ropensci/datasets", "mammals/mammals.csv", Last_appearance_mya = 50)
#> Source: local data frame [8 x 7]
#> 
#>                Species Mass_ln_g First_appearance_mya Last_appearance_mya
#> 1   Coryphodon armatus     13.07                 53.9                  50
#> 2 Bunophorus sinclairi     9.054                   53                  50
#> 3     Uintacyon asodes     8.148                 53.3                  50
#> 4 Tritemnodon strenuus     8.457                 54.3                  50
#> 5   Absarokius nocerai     5.877                   50                  50
#> 6     Washakius izetti     5.435                   50                  50
#> 7 Thisbemys elachistos     4.847                   50                  50
#> 8   Esthonyx acutidens     9.195                 53.4                  50
#> Variables not shown: Family (chr), Order_or_higher (chr), Limb_morphology
#>   (chr)
```

## Create a file


```r
options(github_name = "Scott Chamberlain")
options(github_email = "myrmecocystus@gmail.com")
easy_create(iris, repo = "sckott/testeasy", path = "iris.csv", message = "hello world")
#> $content
#> $content$name
#> [1] "iris.csv"
#> 
#> $content$path
#> [1] "iris.csv"
#> 
#> $content$sha
#> [1] "a7055de6460e2598378a01a2158551fc14c16181"
#> 
...
```

## Update a file

...

## Delete a file

...

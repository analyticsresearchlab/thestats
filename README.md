<img align="right" width="220" height="240" src="https://github.com/analyticsresearchlab/thestats/blob/main/man/figures/logo.png" alt="thestats: An R package for exploring Turkish higher education statistics">

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/thestats?color=green)](https://cran.r-project.org/package=thestats)
[![](http://cranlogs.r-pkg.org/badges/grand-total/thestats?color=green)](https://cran.r-project.org/package=thestats)
[![](http://cranlogs.r-pkg.org/badges/thestats?color=green)](https://cran.r-project.org/package=thestats)
[![](http://cranlogs.r-pkg.org/badges/last-week/thestats?color=green)](https://cran.r-project.org/package=thestats)

# thestats: An R package for exploring Turkish higher education statistics 

thestats, a user-friendly R data package that is intended to make Turkish higher education statistics more accessible. The package provides researchers access to data scraped from the portal called [YOKATLAS](https://yokatlas.yok.gov.tr/) and by using it, researchers no longer have to spend additional time digging into the Turkish higher education statistics. It does not only help researchers to query the data but also provides ready-to-use aggregation possibilities. With this, the researchers can easily calculate some statistics on the level of cities and regions.

## Installation

To install the package from the CRAN by using following code:

```r
install.packages("thestats")
library(thestats)
```

To install the package from the github repo, `devtools` is required and the package can be installed by using following code:

```r
devtools::install_github("analyticsresearchlab/thestats")
```

## Usage

thestats provides three easy-to-use functions: `list_uni()`, `list_dept()`, and `list_score()`. In a nutshell, `list_uni()` function helps to query universities in cities or regions specified by the user. Moreover, the function allows calculating aggregations such as the number of universities per year in cities or regions specified by the user. The function has four arguments: `region_names`, `city_names`, `aggregation` and `lang`. 
- `region_names` argument is to pass names of the regions shown in [Table 2](https://github.com/analyticsresearchlab/thestats/blob/main/docs/Table2.md).
- `city_names` is for specifying city names, aggregation is to provide the universities in specific regions or cities. 
- `lang` argument is to select English or Turkish as a language of returned results by the function. Let's assume that the user would like to query universities in Izmir, which is a city in the west part of Turkey:

```r
list_uni(region_names = "all", city_names = "Izmir")
```

Following example can be used to get the number of universities per type (state or private) in Izmir and Mugla. 

```r
list_uni(region_names = "all", 
         city_names = c("Izmir", "Mugla"), 
         aggregation = "count_by_city")
```

list_dept() function helps to query universities, departments in cities or regions. Moreover, it allows calculating aggregations such as the number of universities or the number of universities having specific departments per year in cities or regions specified. The function also has same arguments like `list_uni()`. It allows users to query departments or universities per cities or regions. As shown in the following example, there is a possibility to get universities that have Statistics departments in Izmir and Mugla.

```r
list_dept(region_names = "all", 
          city_names = c("Izmir", "Mugla"), 
          department_names = "Statistics")
```

`list_score()` function is for querying detailed statistics about universities at the level of departments, cities, regions. The function has an additional argument is `var_ids` allows users to specify the type of statistics they would like to see as described in [Table 3](https://github.com/analyticsresearchlab/thestats/blob/main/docs/Table3.md). As shown in the following example, users can pass statistics they want to see to `var_ids` argument. In this example, `X190` refers the number of assistant professors and `X196` refers the number of incoming exchange students. Following the usage of the function, it will return these statistics for the universities which are located in Izmir and have the Statistics department.

```r
list_score(region_names = "all", 
           city_names = "Izmir",
           university_names = "all",
           department_names = "Statistics", 
           var_ids = c("X190", "X196"))
```


## Citation

If you use `thestats`, please cite it:

```
@article{,
    title = {thestats: An Open-Data R Package for Exploring Turkish Higher Education Statistics},
    author = {Mustafa Cavus and Olgun Aydin},
    year = {2023},
    journal = {Yükseköğretim Dergisi},
    volume = {13},
    number = {1},
    pages = {1--7},
    doi = {10.2399/yod.23.1167895},
    url = {https://dergipark.org.tr/en/pub/yuksekogretim/issue/77238/1167895}
  }
```


## Contact

For any questions and feedback, please dont hesitate to contact us via following e-mail adresses:
- olgun.aydin@pg.edu.pl
- mustafacavus@eskisehir.edu.tr 

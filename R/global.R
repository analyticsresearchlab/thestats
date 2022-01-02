# Global script for loading data from /data folder
data("regions_cities_en",envir = environment())
data("regions_cities", envir = environment())
data("depts_en",envir = environment())
data("depts", envir = environment())
data("scores", envir = environment())

globalVariables(c(names(regions_cities),
                  c(names(regions_cities_en)),
                  c(names(depts)),
                  c(names(depts_en)),
                  c(names(scores))))
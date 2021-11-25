#' List universities with aggregations
#'
#'
#' @description List universities and types of them based on city and region filter
#'
#' @param region_names The region names that you want to get university names for
#' @param city_names The city names that you want to get university names for
#'
#' @return A data frame
#'
#' @examples
#' uni_names <- list_uni(region_names = "all",city_names = c("IZMIR","MUGLA"),aggregation = "count_by_city")


list_uni <- function(region_names ="all", city_names="all", aggregation, lang = "en")
{

if(lang == "en")
{
  regions_cities<- regions_cities_en
}
else if(lang == "tr")
{
  regions_cities<- regions_cities
}

if(missing(aggregation))
  {
    if(region_names == "all" && city_names== "all" )
    {
      result <- regions_cities
    }
    else if(region_names != "all" && city_names== "all" )
    {
      result <- filter(regions_cities, region %in% region_names)
    }
    else if(region_names == "all" && city_names!= "all" )
    {
      result <- filter(regions_cities, city %in% city_names)
    }
    else if(region_names == "all" && city_names == "all" )
    {
      result <- regions_cities
    }
    else if(region_names != "all" && city_names!= "all" )
    {
      stop("Please set at least one of the arguments as 'all' ")
    }
    else if(region_names == "" || city_names!= "" )
    {
      stop("Please provide either region name or city name")
    }
  }
else
  {
    if(aggregation == "count_by_city" && region_names == "all" && city_names!= "all")
    {
    filtered_by_city <- filter(regions_cities, city %in% city_names)
    result <- as.data.frame(filtered_by_city %>% group_by(city, type) %>% tally())
    }
    else if(aggregation == "count_by_region" && region_names != "all" && city_names == "all")
    {
    filtered_by_region <- filter(regions_cities, region %in% region_names)
    result <- as.data.frame(filtered_by_region %>% group_by(region, type) %>% tally())
    }
    else
    {
    stop("Please check aggregation, city and region")
    }
  }

  return(result)
}

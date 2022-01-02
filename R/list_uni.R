#' List universities with aggregations
#'
#' @name list_uni
#'
#' @description List universities and types of them based on city and region filter
#'
#' @param region_names The region names that you want to get university names for
#' @param city_names The city names that you want to get university names for
#' @param aggregation "count_by_city" for group sum of universities per each city defined by user. "count_by_region": group sum of universities per each region defined by user.
#' @param lang  Language option. Default "en". "en" for English, "tr" for Turkish
#'
#' @return A data frame
#'
#' @examples
#' uni_names <- list_uni(region_names = "all",
#' city_names = c("IZMIR","MUGLA"),
#' aggregation = "count_by_city")


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
    if("all" %in% region_names && "all" %in% city_names )
    {
      result <- regions_cities
    }
    else if(!"all" %in% region_names && "all" %in% city_names )
    {
      result <- filter(regions_cities, region %in% region_names)
    }
    else if("all" %in% region_names && !"all" %in% city_names )
    {
      result <- filter(regions_cities, city %in% city_names)
    }
    else if(!"all" %in% region_names && !"all" %in% city_names )
    {
      stop("Please set at least one of the arguments as 'all' ")
    }
    else if(is.null(region_names) == T || is.null(city_names) == T )
    {
      stop("Please provide either region name or city name")
    }
  }
else
  {
    if(aggregation == "count_by_city" && "all" %in% region_names && !"all" %in% city_names)
    {
    filtered_by_city <- filter(regions_cities, city %in% city_names)
    result <- as.data.frame(filtered_by_city %>% group_by(city, type) %>% tally())
    }
    else if(aggregation == "count_by_region" && !"all" %in% region_names && "all" %in% city_names)
    {
    filtered_by_region <- filter(regions_cities, region %in% region_names)
    result <- as.data.frame(filtered_by_region %>% group_by(region, type) %>% tally())
    }
    else
    {
    stop("Please check aggregation, city and region")
    }
  }
  
  if(dim(result)[1]==0){
    warning("Function returned empty dataframe. Please check city, region and university_names, department_names parameters! ")
  }

  return(result)
}

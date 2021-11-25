#' List departments with aggregations
#'
#'
#' @description
#'
#' @param
#' @param
#'
#' @return A data frame
#'
#' @examples
#' dept_names <- list_dept()

list_dept <- function(region_names = "all", city_names = "all", university_names = "all", department_names,lang ="en",aggregation)
{
  if(lang == "en")
  {
    regions_cities<- regions_cities_en
    depts <- depts_en
  }
  else if(lang == "tr")
  {
    regions_cities<- regions_cities
    depts <- depts
  }
  if(missing(aggregation))
  {
    if(region_names == "all" && city_names== "all" && university_names == "all" && department_names == "all")
    {
      result <- depts
    }
    else if(region_names != "all" && city_names== "all" && university_names == "all" && department_names == "all")
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(depts, id %in% regions_unis$id)
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names!= "all" && university_names == "all" && department_names == "all")
    {
      cities_unis <- filter(regions_cities, city %in% city_names)
      filtered_depts <- filter(depts, id %in% cities_unis$id)
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names == "all" && university_names != "all" && department_names == "all")
    {
      filtered_depts <- filter(depts, university %in% university_names)
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names == "all" && university_names == "all" && department_names != "all")
    {
      filtered_depts <- filter(depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if(region_names != "all" && city_names== "all" && university_names == "all" && department_names != "all")
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(depts, id %in% regions_unis$id)
      filtered_depts <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names != "all" && university_names == "all" && department_names != "all")
    {
      cities_unis <- filter(regions_cities, city %in% city_names)
      filtered_depts <- filter(depts, id %in% cities_unis$id)
      filtered_depts <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else
    {
    stop("Please check city, region and university_names, department_names parameters! ")
    }
  }
  else
  {
    if(aggregation == "count_by_region" && region_names != "all" && city_names == "all" && university_names == "all" && department_names == "all")
    {
      filtered_by_region <- filter(regions_cities, region %in% region_names)
      result <- as.data.frame(filtered_by_region %>% group_by(city, type) %>% tally())
    }
  }
  if(dim(result)[1]==0){
    warning("Function returned empty dataframe. Please check city, region and university_names, department_names parameters! ")
  }
  return(result)
}

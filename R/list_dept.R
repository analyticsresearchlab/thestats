#' List departments with aggregations
#' 
#' @name list_dept
#'
#' @description List universities, departments and faculties based on city, university and region filter.
#'
#' @param region_names The region names that you want to get university,department and faculty names for.
#' @param city_names The city names that you want to get university,department and faculty names for.
#' @param university_names The university names that you want to get department and faculty names for.
#' @param department_names The department names that.
#' @param lang  Language option. Default "en", "en" for English, "tr" for Turkish
#' @param aggregation "count_by_region" for group sum of universities per each region defined by user.
#'
#' @return A data frame
#'
#' @examples
#' dept_names <- list_dept(region_names = "all", 
#' city_names = c("Izmir", "Mugla"), 
#' department_names = "Statistics")


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
    if("all" %in% region_names && "all" %in% city_names && "all" %in% university_names && "all" %in% department_names)
    {
      result <- depts
    }
    else if(!"all" %in%  region_names &&  "all" %in% city_names  && "all" %in% university_names  &&  "all" %in% department_names)
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(depts, id %in% regions_unis$id)
      result <- filtered_depts
    }
    else if( "all" %in%  region_names && !"all" %in% city_names && "all" %in% university_names && "all" %in% department_names)
    {
      cities_unis <- filter(regions_cities, city %in% city_names)
      filtered_depts <- filter(depts, id %in% cities_unis$id)
      result <- filtered_depts
    }
    else if("all" %in%  region_names && "all" %in% city_names && !"all"  %in% university_names  && "all" %in%  department_names)
    {
      filtered_depts <- filter(depts, university %in% university_names)
      result <- filtered_depts
    }
    else if("all" %in% region_names && "all" %in% city_names && "all" %in% university_names && !"all" %in% department_names)
    {
      filtered_depts <- filter(depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if(!"all" %in%region_names  && "all" %in% city_names && "all" %in% university_names && !"all" %in% department_names)
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(depts, id %in% regions_unis$id)
      filtered_depts_final <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts_final
    }
    else if("all" %in% region_names && !"all" %in% city_names &&  "all" %in% university_names && !"all" %in% department_names )
    {
      cities_unis <- filter(regions_cities,  city %in% city_names  )
      filtered_depts <- filter(depts, id %in% cities_unis$id  )
      filtered_depts_final <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts_final
    }
    else
    {
    stop("Please check city, region and university_names, department_names parameters! ")
    }
  }
  else
  {
    if(aggregation == "count_by_region" && !"all" %in% region_names  && "all" %in% city_names && "all" %in% university_names && "all" %in% department_names)
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

#' List scores for universities, departments
#'
#' @name list_score
#'
#' @description List statistics universities, departments and faculties based on city, university and region filter.
#'
#' @param region_names The region names that you want to get university,department and faculty names for
#' @param city_names The city names that you want to get university,department and faculty names for
#' @param university_names The university names that you want to get university get university,department and faculty names for
#' @param department_names The department names that.
#' @param lang  Language option. Default ="en" "en" for English, "tr" for Turkish
#' @param var_ids Statistics defined in Table 3.
#'
#' @return A data frame
#'
#' @examples
#' list_score(region_names = "all", city_names = "all", 
#' university_names = "all", department_names="all", 
#' lang = "en", var_ids=c("X10","X11"))


list_score <- function(region_names = "all", city_names = "all", university_names = "all", department_names, lang = "en", var_ids)
{

  if(lang == "en")
  {
    regions_cities<- regions_cities_en
    scores_en <- data.frame(depts_en,scores[,8:198])
    scores_selected_en <- subset(scores_en,select = var_ids)
    scores <- data.frame(depts_en,scores_selected_en)
  }
  else if(lang == "tr")
  {
    regions_cities<- regions_cities
    scores_selected_tr <- subset(scores,select = var_ids)
    scores <- data.frame(depts,scores_selected_tr)
  }
    if("all" %in% region_names && "all" %in% city_names && "all" %in% university_names && "all" %in% department_names)
    {
      result <- scores
    }
    else if(!"all" %in% region_names && "all" %in% city_names && "all" %in% university_names && "all" %in% department_names)
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(scores, id %in% regions_unis$id)
      filtered_dept_cols <- colnames(filtered_depts)
      result <- filtered_depts
    }
    else if("all" %in% region_names && !"all" %in% city_names && "all" %in% university_names && "all" %in% department_names)
    {
      cities_unis <- filter(regions_cities, city %in% city_names)
      filtered_depts <- filter(scores, id %in% cities_unis$id)
      result <- filtered_depts
    }
    else if("all" %in% region_names && "all" %in% city_names && !"all" %in% university_names && "all" %in% department_names)
    {
      filtered_depts <- filter(scores, university %in% university_names)
      result <- filtered_depts
    }
    else if("all" %in% region_names && "all" %in% city_names && "all" %in% university_names && !"all" %in% department_names)
    {
      filtered_depts <- filter(scores, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if(!"all" %in% region_names && "all" %in% city_names && "all" %in% university_names && !"all" %in% department_names)
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(scores, id %in% regions_unis$id)
      filtered_depts <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if("all" %in% region_names && !"all" %in% city_names && "all" %in% university_names && !"all" %in% department_names)
    {
      cities_unis <- filter(regions_cities, city %in% city_names)
      filtered_depts <- filter(scores, id %in% cities_unis$id)
      filtered_depts <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if("all" %in% region_names && !"all" %in% city_names && "all" %in% university_names && !"all" %in% department_names)
    {
      filtered_depts <- filter(scores, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else
    {
      stop("Please check city, region and university_names, department_names parameters! ")
    }
if(dim(result)[1]==0){
    warning("Function returned empty dataframe. Please check city, region and university_names, department_names parameters! ")
  }

  return(result)
}

#' List scores for universities, departments
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
#' list_score(region_names = "all", city_names = "all", university_names = "all", department_names="all", lang = "en", var_ids=c("X10","X11"))

list_score <- function(region_names = "all", city_names = "all", university_names = "all", department_names, lang = "en", var_ids)
{

  if(lang == "en")
  {
    regions_cities<- regions_cities_en
    scores_selected_en <- subset(scores_en,select = var_ids)
    scores <- data.frame(depts_en,scores_selected_en)
  }
  else if(lang == "tr")
  {
    regions_cities<- regions_cities
    scores_selected_tr <- subset(scores,select = var_ids)
    scores <- data.frame(depts,scores_selected_tr)
  }
    if(region_names == "all" && city_names== "all" && university_names == "all" && department_names == "all")
    {
      result <- scores
    }
    else if(region_names != "all" && city_names== "all" && university_names == "all" && department_names == "all")
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(scores, id %in% regions_unis$id)
      filtered_dept_cols <- colnames(filtered_depts)
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names!= "all" && university_names == "all" && department_names == "all")
    {
      cities_unis <- filter(regions_cities, city %in% city_names)
      filtered_depts <- filter(scores, id %in% cities_unis$id)
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names == "all" && university_names != "all" && department_names == "all")
    {
      filtered_depts <- filter(scores, university %in% university_names)
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names == "all" && university_names == "all" && department_names != "all")
    {
      filtered_depts <- filter(scores, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if(region_names != "all" && city_names== "all" && university_names == "all" && department_names != "all")
    {
      regions_unis <- filter(regions_cities, region %in% region_names)
      filtered_depts <- filter(scores, id %in% regions_unis$id)
      filtered_depts <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names != "all" && university_names == "all" && department_names != "all")
    {
      cities_unis <- filter(regions_cities, city %in% city_names)
      filtered_depts <- filter(scores, id %in% cities_unis$id)
      filtered_depts <- filter(filtered_depts, grepl(department_names, department, fixed = TRUE))
      result <- filtered_depts
    }
    else if(region_names == "all" && city_names != "all" && university_names == "all" && department_names != "all")
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

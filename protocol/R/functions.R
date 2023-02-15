# protocol/R/functions.R

update_data_from_google <- function(google_sheet_fn = 'C-ORR Survey 2022 Fall (Responses)', 
                                    csv_fn = "protocol/csv/open-science-survey-2022-fall.csv", vb = FALSE) {
  googledrive::drive_auth(Sys.getenv("GMAIL_ROG"))
  
  stopifnot(is.character(google_sheet_fn))
  stopifnot(is.character(csv_fn))
  stopifnot(file.exists(csv_fn))
  
  googledrive::drive_download(
    file = google_sheet_fn,
    path = csv_fn,
    type = 'csv',
    overwrite = TRUE
  )
}

open_survey <- function(csv_fn = 'protocol/csv/open-science-survey-2022-fall.csv', vb = TRUE) {
  stopifnot(is.character(csv_fn))
  stopifnot(file.exists(csv_fn))
  
  df <- readr::read_csv(csv_fn, show_col_types = FALSE)
  if (vb) message("There are n=", dim(df)[1], " responses.")
  df
}

clean_names <- function(df) {
  stopifnot(is.data.frame(df))
  
  full_questions <- names(df)
  
  short_names <- c(
    "timestamp",
    "campus",
    "department",
    "position",
    "years_since_degree",
    "data_types",
    "restricted_data",
    "storage_active_projects",
    "importance_sharing_collab",
    "convenience_sharing_collab",
    "barriers_sharing_collab",
    "importance_share_community",
    "barriers_share_community",
    "funders_require_data_sharing",
    "journals_require_data_sharing",
    "where_shared_community",
    "equipped_data_mgmt_sharing",
    "create_analysis_code",
    "share_analysis_code_collab",
    "create_other_code",
    "use_code_sharing_tools",
    "funders_require_code_sharing",
    "journals_require_code_sharing",
    "share_materials_community",
    "knowledge_open_science",
    "awareness_FAIR",
    "apply_FAIR",
    "heardof_reproducibility_crisis",
    "my_area_reproducibility_crisis",
    "benefit_psu_center",
    "service_psu_center",
    "comments",
    "contact_info",
    "highest_degree_earned",
    "share_analysis_code_community"
  )
  
  if (length(short_names) == length(names(df))) {
    names(df) <- short_names
  } else {
    if (vb) message("Name vector lengths differ; no change made.")
  }
  df
}

show_unique_units <- function(df) {
  stopifnot(is.data.frame(df))
  sort(unique(df$department)) 
}

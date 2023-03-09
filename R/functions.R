# functions.R

###############################################################################
render_protocol_bootstrap4 <- function(input_dir = 'src') {
  stopifnot(is.character(input_dir))
  stopifnot(dir.exists(input_dir))
  
  bookdown::render_book(input_dir,
                        output_format = bookdown::bs4_book())
}

###############################################################################
render_protocol_gitbook <- function(input_dir = 'src') {
  stopifnot(is.character(input_dir))
  stopifnot(dir.exists(input_dir))
  
  bookdown::render_book(input_dir,
                        output_format = bookdown::gitbook())
}

###############################################################################
update_data <-
  function(csv_fn = "src/csv/open-science-survey-2022-fall.csv",
           google_sheet_fn = "C-ORR Survey 2022 Fall (Responses)",
           force_update = FALSE,
           google_credentials) {
    stopifnot(is.character(csv_fn))
    stopifnot(is.character(google_sheet_fn))
    stopifnot(is.logical(force_update))
    stopifnot(is.character(google_credentials))
    
    if (!file.exists(csv_fn)) {
      no_current_csv <- TRUE
      csv_fn <- "src/csv/open-science-survey-2022-fall.csv"
    } else {
      no_current_csv <- FALSE
      message("File '", csv_fn, "' exists. No changes made.")
    }
    
    if (no_current_csv || force_update) {
      message("Forcing update. Downloading data from Google.")
      if (!dir.exists('src/csv')) {
        message("No `src/csv` directory found; creating.")
        dir.create('protocol/csv')
      }
      
      googledrive::drive_auth(google_credentials)
      
      googledrive::drive_download(
        file = google_sheet_fn,
        path = csv_fn,
        type = 'csv',
        overwrite = TRUE
      )
    }
  }

###############################################################################
open_survey <-
  function(csv_fn = 'src/csv/open-science-survey-2022-fall.csv',
           vb = TRUE) {
    stopifnot(is.character(csv_fn))
    stopifnot(file.exists(csv_fn))
    
    df <- readr::read_csv(csv_fn, show_col_types = FALSE)
    if (vb)
      message("There are n=", dim(df)[1], " responses.")
    df
  }

###############################################################################
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
    if (vb)
      message("Name vector lengths differ; no change made.")
  }
  df
}

###############################################################################
show_unique_depts <- function(df) {
  stopifnot(is.data.frame(df))
  sort(unique(df$department))
}

###############################################################################
clean_depts <- function(df) {
  df <- df |>
    dplyr::mutate(
      department = dplyr::recode(
        department,
        `CAS` = "Communication Arts & Sciences",
        `Curriculum and Instruction (College of Education)` = "curriculum & instruction",
        `CLA Economics` = "Economics",
        `Department of Curriculum and Instruction` = "curriculum & instruction",
        `Department of Educational Psychology, Counseling, and Special Education` = "educational psychology, counseling, and special education",
        `Education Policy Studies (College of Education)` = "education policy studies",
        `EPCSE` = "educational psychology, counseling, and special education",
        `Educational Psychology` = "educational psychology, counseling, and special education",
        `Education` = "college of education",
        `EE` = "Electrical Engineering",
        `GSLL` = "Germanic and Slavic Languages",
        `HDFS` = "Human Development and Family Studies",
        `HDFS/CMSN` = "Human Development and Family Studies",
        `Human Develoment & Family Studies` = "Human Development and Family Studies",
        `IST` = "College of Information Sciences and Technology",
        `Liberal Arts` = "College of the Liberal Arts",
        `Libraries` = "University Libraries",
        `Office of Learning Design, IST` = "College of Information Sciences and Technology",
        `PLSC` = "Political Science",
        `Political Science / Liberal Arts` = "Political Science",
        `pscyhology` = "Psychology",
        `Psych` = "Psychology",
        `School of Labor and Employment Relations` = "Labor and Employment Relations",
        `School of Public Affairs/Public Administration` = "School of Public Affairs",
        `SOCIOLOGY` = "Sociology",
        `Soc/Crim` = "Sociology",
        `Spanish, Italian & Portuguese` = "Spanish, Italian, and Portuguese",
        `You’ve said we can choose to omit items. What` = "College of the Liberal Arts",
        `Telecommunications & Women's, Gender, and Sexuality Studies` = "Women's, Gender, and Sexuality Studies",
        `the department of energy and mineral engineering` = "Energy and Mineral Engineering",
        `Underwater basket-weaving` = "None"
      )
    ) |>
    dplyr::mutate(department = tolower(department))
  df
}

###############################################################################
update_data_check_unique_depts <- function() {
  message("Updating data file")
  update_data(force_update = TRUE,
              google_credentials = Sys.getenv("GMAIL_ROG"))
  
  open_show_unique_depts()
}

###############################################################################
open_clean_depts_show_unique <- function() {
  require(tidyverse)
  open_survey() |>
    clean_names() |>
    clean_depts() |>
    show_unique_depts()
}

###############################################################################
open_show_unique_depts <- function() {
  open_survey() |>
    clean_names() |>
    show_unique_depts()
}

###############################################################################
update_report <- function(rpt_url = "docs/index.html",
                          open_rpt = TRUE) {
  message("Updating data file")
  update_data(force_update = TRUE,
              google_credentials = Sys.getenv("GMAIL_ROG"))
  
  message("Rendering full report.")
  render_protocol_bootstrap4()
  
  if (open_rpt)
    browseURL(rpt_url)
}
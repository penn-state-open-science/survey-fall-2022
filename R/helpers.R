update_data <- function(csv_fn="csv/open-science-survey-2022-fall.csv",
                        google_sheet_fn = "C-ORR Survey 2022 Fall (Responses)",
                        force_update = FALSE) {
  
  stopifnot(is.character(csv_fn))
  stopifnot(is.character(google_sheet_fn))
  stopifnot(is.logical(force_update))
  
  if (!file.exists(csv_fn)) {
    no_current_csv <- TRUE
    csv_fn <- "csv/open-science-survey-2022-fall.csv"
  } else {
    no_current_csv <- FALSE
    message("File '", csv_fn, "' exists. No changes made.")
  }
  
  if (no_current_csv || force_update) {
    message("Downloading data from Google.")
    if (!dir.exists('csv')) {
      message("No csv/ found; creating.")
      dir.create('csv')
    }
    
    googledrive::drive_auth()
    
    googledrive::drive_download(
      file = google_sheet_fn,
      path = csv_fn,
      type = 'csv',
      overwrite = TRUE
    )  
  }
}
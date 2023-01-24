# functions.R

###############################################################################
render_protocol_bootstrap4 <- function(output_dir = 'docs') {
  if (!dir.exists(output_dir)) {
    stop("Output directory doesn't exist: ", output_dir)
  }
  
  bookdown::render_book('protocol', 
                        output_format = bookdown::bs4_book())
}

###############################################################################
render_protocol_gitbook <- function(output_dir = 'docs') {
  if (!dir.exists(output_dir)) {
    stop("Output directory doesn't exist: ", output_dir)
  }
  
  bookdown::render_book('protocol')
  
}

###############################################################################
update_data <- function(csv_fn="protocol/csv/open-science-survey-2022-fall.csv",
                        google_sheet_fn = "C-ORR Survey 2022 Fall (Responses)",
                        force_update = FALSE) {
  
  stopifnot(is.character(csv_fn))
  stopifnot(is.character(google_sheet_fn))
  stopifnot(is.logical(force_update))
  
  if (!file.exists(csv_fn)) {
    no_current_csv <- TRUE
    csv_fn <- "protocol/csv/open-science-survey-2022-fall.csv"
  } else {
    no_current_csv <- FALSE
    message("File '", csv_fn, "' exists. No changes made.")
  }
  
  if (no_current_csv || force_update) {
    message("Downloading data from Google.")
    if (!dir.exists('protocol/csv')) {
      message("No `protocol/csv` directory found; creating.")
      dir.create('protocol/csv')
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

###############################################################################
update_report <- function() {
  message("Updating data file")
  update_data(force_update = TRUE)
  
  message("Rendering full report.")
  render_protocol_bootstrap4()
}
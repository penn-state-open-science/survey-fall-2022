render_protocol_bootstrap4 <- function(output_dir = 'docs') {
  if (!dir.exists(output_dir)) {
    stop("Output directory doesn't exist: ", output_dir)
  }
  
  bookdown::render_book('protocol', 
                        output_format = bookdown::bs4_book())
}

render_protocol_gitbook <- function(output_dir = 'docs') {
  if (!dir.exists(output_dir)) {
    stop("Output directory doesn't exist: ", output_dir)
  }
    
  bookdown::render_book('protocol')
  
}

render_book_open <- function() {
  render_protocol_bootstrap4()
  browseURL("docs/data-visualization.html")
}

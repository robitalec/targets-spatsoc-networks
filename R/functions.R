#' Prepare datetime column
#'
#' @param DT data.table
#' @param datetime character; datetime column name
#' @param tz character; time zone.
#'
#' @return
#' data.table with datetime columns added
#' @export
#'
#' @examples
#' path <- system.file('extdata', 'DT.csv', package = 'spatsoc')
#' DT <- read_data(path = path)
#' prep_dates(DT, 'datetime', 'Canada/Newfoundland')
prep_dates <- function(DT, datetime, tz) {
  check_truelength(DT)
  check_col(DT, datetime, 'datetime')

  if (missing(tz)) {
    stop('must provide a tz argument')
  }

  DT[, datetime := anytime::anytime(.SD[[1]], tz = tz, asUTC = TRUE), .SDcols = datetime]

  DT[, doy := data.table::yday(datetime)]
  DT[, yr := data.table::year(datetime)]
  DT[, mnth := data.table::month(datetime)]
}




# Graph metrics -----------------------------------------------------------

#' Calculate network metrics
#'
#' @param graph igraph network
#'
#' @return
#' @export
#'
#' @examples
calc_metrics <- function(graph) {
  data.table::data.table(
    centrality = igraph::evcent(graph)$vector,
    strength = igraph::graph.strength(graph),
    degree = igraph::degree(graph),
    ID = names(igraph::degree(graph))
  )
}







# Etc ---------------------------------------------------------------------
#' check col
#' @param DT data.table
#' @param col column name
#' @param arg argument name
#' @param extra extras
check_col <- function(DT = NULL, col = NULL, arg = NULL, extra = NULL) {

  if (is.null(arg)) {
    it <- col
  } else {
    it <- paste0(arg, " ('", col, "')")
  }

  if (!(col %in% colnames(DT))) {
    stop(paste0(it, ' column not found in DT', extra))
  }
}

#' check type
#' @param DT data.table.
#' @param col column name.
#' @param type typeof type type typeof type.
check_type <- function(DT = NULL, col = NULL, type = NULL) {
  if (!(typeof(DT[[col]]) %in% type)) {
    stop(paste0(col, ' does not match required type: ', type))
  }
}


#' overwite_col
#' @param DT data.table
#' @param col column name
overwrite_col <- function(DT = NULL, col = NULL) {

  if (col %in% colnames(DT)) {
    warning(paste0('overwriting ', col, ' column'))
    set(DT, j = eval(col), value = NULL)
  }
}

#' check_truelength
#' @param DT data.table
check_truelength <- function(DT) {
  if (truelength(DT) == 0) {
    stop('please run data.table::alloc.col on your DT to allocate columns')
  }
}



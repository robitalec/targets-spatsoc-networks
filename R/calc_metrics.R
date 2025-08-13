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
    centrality = igraph::eigen_centrality(graph)$vector,
    strength = igraph::strength(graph),
    degree = igraph::degree(graph),
    ID = names(igraph::degree(graph))
  )
}

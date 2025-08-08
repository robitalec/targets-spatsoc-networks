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

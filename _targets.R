# === Spatsoc networks - targets workflow ---------------------------------
# Alec L. Robitaille


# Packages ----------------------------------------------------------------
library(targets)
library(tarchetypes)

library(data.table)
library(spatsoc)
library(asnipe)
library(igraph)

library(anytime)

# Functions ---------------------------------------------------------------
source('R/functions.R')



# Targets options ---------------------------------------------------------
tar_option_set(format = 'qs')


# Variables ---------------------------------------------------------------
tempthresh <- '10 minutes'
spatthresh <- 50
input <- 'input'

datetime <- 'datetime'
id <- 'ID'
coords <- c('X', 'Y')

group <- 'group'

# asnipe::get_network
associationindex <- 'SRI'

# igraph::graph.adjacency
mode <- 'undirected'
diag <- FALSE
weighted <- TRUE

# group_pts/general branching
splitBy <- c('yr', 'mnth')


# Targets -----------------------------------------------------------------
tar <- c(
  tar_target(
    locs,
    fread(path)
  ),

  tar_target(
    prep,
    prep_dates(locs, datetime)
  ),

  tar_target(
    splits,
    prep[, tar_group := .GRP, by = splitBy],
    iteration = 'group'
  ),

  tar_target(
    splitsnames,
    unique(prep[, .(path = path), by = splitBy])
  ),

  tar_target(
    timegroups,
    group_times(splits, datetime, tempthresh),
    map(splits)
  ),

  tar_target(
    spatgroups,
    group_pts(timegroups, spatthresh, id, coords, 'timegroup'),
    map(timegroups)
  ),

  tar_target(
    gbi,
    get_gbi(DT = spatgroups, group = group, id = id),
    map(spatgroups),
    iteration = 'list'
  ),

  tar_target(
    networks,
    get_network(gbi, data_format = 'GBI', association_index = associationindex),
    map(gbi),
    iteration = 'list'
  ),

  tar_target(
    graphs,
    graph.adjacency(networks, mode = mode, diag = diag, weighted = weighted),
    map(networks),
    iteration = 'list'
  ),

  tar_target(
    metrics,
    calc_metrics(graphs),
    map(graphs)
  ),

  tar_target(
    merged,
    cbind(metrics, splitsnames, spatthresh = spatthresh, tempthresh = tempthresh),
    map(metrics, splitsnames)
  )
)




# Output ------------------------------------------------------------------

# Note, to choose which option to run, simply comment out the other options
# targets will run the last one left uncommented


# Option 1 ----------------------------------------------------------------
# Run for a single path
path <- 'input/locs-a.csv'
tar

#
# # Option 2 ----------------------------------------------------------------
# # Or branch over multiple paths
# paths <- dir(input, '.csv', full.names = TRUE)
# values <- list(path = paths)
#
# map <- tar_map(
#   values = values,
#   tar
# )
#
# c(map,
#   tar_combine(out, map['merged'])
# )
#
#
# # Option 3 ----------------------------------------------------------------
# # Or for a data set specific thresholds
# paths <- dir(input, '.csv', full.names = TRUE)
# values <- list(
#   path = paths,
#   tempthresh = c('10 minutes', '20 minutes'),
#   spatthresh = c(50, 100)
# )
#
# map <- tar_map(
#   values = values,
#   tar
# )
#
# c(map,
#   tar_combine(out, map['merged'])
# )
#
#
# # Option 4 ----------------------------------------------------------------
# # Or for a sensitivity analysis, run across datasets and multiple thresholds (for example)
# # Note, we use data.table::CJ to make all to combinations of data and thresholds
# paths <- dir(input, '.csv', full.names = TRUE)
# values <- CJ(
#   path = paths,
#   tempthresh = c('10 minutes', '20 minutes'),
#   spatthresh = c(50, 100)
# )
#
#
# map <- tar_map(
#   values = values,
#   tar
# )
#
# c(map,
#   tar_combine(out, map['merged'])
# )

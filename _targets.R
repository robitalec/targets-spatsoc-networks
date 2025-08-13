# === {spatsoc} networks - {targets} workflow -----------------------------
# Alec L. Robitaille


# Packages ----------------------------------------------------------------
library(targets)
library(tarchetypes)
library(fst)

library(data.table)
library(spatsoc)
library(asnipe)
library(igraph, warn.conflicts = FALSE)



# Functions ---------------------------------------------------------------
tar_source('R')



# Targets options ---------------------------------------------------------
tar_option_set(format = 'fst_dt')


# Variables ---------------------------------------------------------------
temporal_threshold <- '10 minutes'
spatial_threshold <- 50

datetime <- 'datetime'
id <- 'ID'
coords <- c('X', 'Y')

group <- 'group'

# asnipe::get_network
associationindex <- 'SRI'

# igraph::graph.adjacency
mode <- 'undirected'
weighted <- TRUE

# group_pts/general branching
splitBy <- c('yr', 'mnth')



# Targets -----------------------------------------------------------------
tar <- c(
  tar_target(
    locs,
    fread(filepath),
    description = 'fread(filepath)'
  ),

  tar_target(
    prep,
    prep_dates(locs, datetime),
    description = 'prep_dates(locs, datetime)'
  ),

  tar_target(
    splits,
    prep[, tar_group := .GRP, by = splitBy],
    iteration = 'group',
    description = 'tar_group by splitBy'
  ),

  tar_target(
    splitsnames,
    unique(prep[, .(filepath = filepath), by = splitBy]),
    description = 'unique(filepath) by splitBY'
  ),

  tar_target(
    timegroups,
    group_times(
      DT = splits,
      datetime = datetime,
      threshold = temporal_threshold
    ),
    map(splits),
    description = '`group_times()`'
  ),

  tar_target(
    spatgroups,
    group_pts(
      DT = timegroups,
      threshold = spatial_threshold,
      id = id,
      coords = coords,
      timegroup = 'timegroup'
    ),
    map(timegroups),
    description = 'group_pts()'
  ),

  tar_target(
    gbi,
    get_gbi(
      DT = spatgroups,
      group = group,
      id = id
    ),
    map(spatgroups),
    iteration = 'list',
    description = 'get_gbi()'
  ),

  tar_target(
    networks,
    get_network(
      association_data = gbi,
      data_format = 'GBI',
      association_index = associationindex
    ),
    map(gbi),
    iteration = 'list',
    format = 'rds',
    description = 'asnipe::get_network()'
  ),

  tar_target(
    graphs,
    graph_from_adjacency_matrix(
      adjmatrix = networks,
      mode = mode,
      diag = FALSE,
      weighted = weighted
    ),
    map(networks),
    iteration = 'list',
    format = 'rds',
    description = 'igraph::graph_from_adjacency_matrix()'
  ),

  tar_target(
    metrics,
    calc_metrics(graphs),
    map(graphs),
    description = 'calc_metrics()'
  ),

  tar_target(
    merged,
    cbind(metrics,
          splitsnames,
          spatial_threshold = spatial_threshold,
          temporal_threshold = temporal_threshold),
    map(metrics, splitsnames),
    description = 'output'
  )
)




# Output ------------------------------------------------------------------

# Note, to choose which option to run, simply comment out the other options
# targets will run the last one left uncommented


# Option 1 ----------------------------------------------------------------
# Run for a single filepath
filepath <- 'input/locs-a.csv'
tar

#
# # Option 2 ----------------------------------------------------------------
# # Or branch over multiple filepaths
# filepaths <- dir('input', '.csv', full.names = TRUE)
# values <- list(filepath = filepaths)
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
# filepaths <- dir('input', '.csv', full.names = TRUE)
# values <- list(
#   filepath = filepaths,
#   temporal_threshold = c('10 minutes', '20 minutes'),
#   spatial_threshold = c(50, 100)
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
# filepaths <- dir('input', '.csv', full.names = TRUE)
# values <- CJ(
#   filepath = filepaths,
#   temporal_threshold = c('10 minutes', '20 minutes'),
#   spatial_threshold = c(50, 100)
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

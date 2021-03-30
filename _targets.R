# === Spatsoc networks - targets workflow ---------------------------------
# Alec L. Robitaille


# Packages ----------------------------------------------------------------
library(targets)
library(tarchetypes)

library(data.table)
library(spatsoc)
library(asnipe)
library(igraph)

# Functions ---------------------------------------------------------------
source('R/functions.R')



# Targets options ---------------------------------------------------------
tar_option_set(format = "qs",
               error = 'workspace')



# Variables ---------------------------------------------------------------
tempthresh <- '10 minutes'
spatthresh <- 50
input <- 'input'

datetime <- 'datetime'
tz <- 'Canada/Newfoundland'
id <- 'ID'
coords <- c('X', 'Y')

group <- 'group'

# asnipe::get_network
associationindex <- 'SRI'

# igraph::graph.adjacency
mode <- 'undirected'
diag <- FALSE
weighted <- TRUE

# values <- list(path = dir(input, '.csv', full.names = TRUE))


# Targets -----------------------------------------------------------------
tar_map(
  values = values,
  c(
    tar_target(
      locs,
      fread(path)
    ),

    tar_target(
      prep,
      prep_dates(locs, datetime, tz)
    ),

    tar_target(
      timegroups,
      group_times(prep, datetime, tempthresh)
    ),

    tar_target(
      spatgroups,
      group_pts(timegroups, spatthresh, id, coords, 'timegroup', splitBy = splitBy)
    ),

    tar_target(
      splits,
      split(spatgroups, by = splitBy),
      iteration = 'list'
    ),

    tar_target(
      splitNames,
      names(splits)
    ),

    tar_target(
      gbi,
      get_gbi(DT = splits, group = group, id = id),
      map(splits)
    ),

    tar_target(
      networks,
      get_network(gbi, data_format = 'GBI', association_index = associationindex),
      map(gbi)
    ),

    tar_target(
      graphs,
      graph.adjacency(networks, mode = mode, diag = diag, weighted = weighted),
      map(networks)
    ),

    tar_target(
      metrics,
      calc_metrics(graphs),
      map(graphs)
    ),

    tar_target(
      comb,
      metrics[, splitBy := splitNames],
      map(splitNames)
    )
  )
)

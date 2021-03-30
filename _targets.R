# === Spatsoc networks - targets workflow ---------------------------------
# Alec L. Robitaille


# Packages ----------------------------------------------------------------
library(targets)
library(tarchetypes)

library(data.table)
library(spatsoc)



# Functions ---------------------------------------------------------------
source('R/functions.R')



# Targets options ---------------------------------------------------------
tar_option_set(format = "qs")



# Variables ---------------------------------------------------------------
tempthresh <- '10 minutes'
spatthresh <- 50
input <- 'input'

datetime <- 'datetime'
tz <- 'Canada/Newfoundland'
id <- 'ID'
coords <- c('X', 'Y')



# Targets -----------------------------------------------------------------
c(
  tar_files(
    paths,
    dir(input, '.csv', full.names = TRUE)
    ),

  tar_target(
    locs,
    fread(paths),
    map(paths)
  ),

  tar_target(
    prep,
    prep_dates(locs, datetime, tz),
    map(locs)
  ),

  tar_target(
    timegroups,
    group_times(prep, datetime, tempthresh),
    map(prep)
  ),

  tar_target(
    spatgroups,
    group_pts(timegroups, spatthresh, id, coords, 'timegroup'),
    map(timegroups)
  )
)

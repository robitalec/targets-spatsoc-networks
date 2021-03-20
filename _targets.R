library(targets)
library(tarchetypes)

library(data.table)

# Load functions
source('R/functions.R')

# Set target-specific options.
tar_option_set(format = "qs")

# Set variables
tempthresh <- '10 minutes'
spatthresh <- 50
input <- 'input'

datetime <- 'datetime'
tz <- 'Canada/Newfoundland'

# Targets
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
    dates,
    prep_dates(locs, datetime, tz),
    map(locs)
  ),

  tar_target(
    timegroups,
    spatsoc::group_times(dates, datetime, tempthresh),
    map(dates)
  )

)

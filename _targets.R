library(targets)
library(tarchetypes)

# Load functions
source('R/functions.R')

# Set target-specific options.
tar_option_set(format = "qs")

# Set variables
tempthresh <- '10 minutes'
spatthresh <- 50
input <- 'input'

# Targets
c(
  tar_files(
    paths,
    dir(input, '.csv', full.names = TRUE)
    )
)

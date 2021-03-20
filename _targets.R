library(targets)

# Load functions
source('R/functions.R')

# Set target-specific options.
tar_option_set(format = "qs")

# Set variables
tempthresh <- '10 minutes'
spatthresh <- 50

# Targets
list(
  tar_target(data, data.frame(x = sample.int(100), y = sample.int(100))),
  tar_target(summary, summ(data)) # Call your custom functions as needed.
)

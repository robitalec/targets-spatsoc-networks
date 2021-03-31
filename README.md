
[![DOI](https://zenodo.org/badge/353198467.svg)](https://zenodo.org/badge/latestdoi/353198467)

# targets-spatsoc-networks

Example [`targets`](https://github.com/ropensci/targets) workflow for
generating networks using
[`spatsoc`](https://github.com/ropensci/spatsoc/).

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

## Usage

1.  Clone/fork/download/etc make your own copy somewhere!
2.  Add your data to the input folder (and remove the example data)
3.  Open `_targets.R`
4.  Change the global variables in the Variables section

As for output, right now it’s set up with four different options after
the Targets section

1.  One data set, simply set the path
2.  Multiple data sets, provide the list or wildcard of paths
3.  Multiple data sets, and matching thresholds or other variables. Eg.
    one data set with 50m spatial threshold and another with 100m.
4.  Multiple data sets, crossed with multiple thresholds (or other
    variables). This could be used for a sensitivity analysis.

To select your output format, comment out or delete the other options.
Targets looks for the last declared target in the `_targets.R` file.

## Resources

[`spatsoc` vignette: Using `spatsoc` in social network
analysis](https://docs.ropensci.org/spatsoc/articles/using-in-sna.html)

[`targets` manual](https://books.ropensci.org/targets/)

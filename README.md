
[![DOI](https://zenodo.org/badge/353198467.svg)](https://zenodo.org/badge/latestdoi/353198467)

# targets-spatsoc-networks

A template [`targets`](https://github.com/ropensci/targets) workflow for
generating social networks from GPS data with
[`spatsoc`](https://github.com/ropensci/spatsoc/).

``` mermaid
graph LR
  style Legend fill:#FFFFFF00,stroke:#000000;
  style Graph fill:#FFFFFF00,stroke:#000000;
  subgraph Legend
    xf1522833a4d242c5(["Up to date"]):::uptodate
    xd03d7c7dd2ddda2b(["Regular target"]):::none
    x6f7e04ea3427f824["Dynamic branches"]:::none
  end
  subgraph Graph
    direction LR
    xdf10c21b92224150["spatgroups"]:::uptodate --> x8b0c676d7240242a["gbi"]:::uptodate
    xc389638817199bf0["networks"]:::uptodate --> x2db02d438e6d5e6f["graphs"]:::uptodate
    x544e14c8fac2c5b0["metrics"]:::uptodate --> x0babe2584c9010e0["merged"]:::uptodate
    xe5f9f129783c9289(["splitsnames"]):::uptodate --> x0babe2584c9010e0["merged"]:::uptodate
    x2db02d438e6d5e6f["graphs"]:::uptodate --> x544e14c8fac2c5b0["metrics"]:::uptodate
    x8b0c676d7240242a["gbi"]:::uptodate --> xc389638817199bf0["networks"]:::uptodate
    x5d49490da5202c91(["locs"]):::uptodate --> x3906e3b7b61cde90(["prep"]):::uptodate
    xc119b121c4bf638e["timegroups"]:::uptodate --> xdf10c21b92224150["spatgroups"]:::uptodate
    x3906e3b7b61cde90(["prep"]):::uptodate --> xf94084fe2fb21595(["splits"]):::uptodate
    x3906e3b7b61cde90(["prep"]):::uptodate --> xe5f9f129783c9289(["splitsnames"]):::uptodate
    xf94084fe2fb21595(["splits"]):::uptodate --> xc119b121c4bf638e["timegroups"]:::uptodate
    
  end
  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;
  classDef none stroke:#000000,color:#000000,fill:#94a4ac;
```

## Usage

1.  Clone/fork/download/etc make your own copy somewhere!
2.  Add your data to the input folder (and remove the example data)
3.  Open `_targets.R`
4.  Change the global variables in the Variables section
5.  Set your output (see below)
6.  Run `targets::tar_make()`

As for output, right now it’s set up with four different options after
the Targets section

1.  One data set, simply set the path
2.  Multiple data sets, provide the list or wildcard of paths
3.  Multiple data sets, and matching thresholds or other variables( eg.
    one data set with 50m spatial threshold and another with 100m).
4.  Multiple data sets, crossed with multiple thresholds (or other
    variables). This could be used for a sensitivity analysis.

To select your output format, comment out or delete the other options.
{targets} looks for the last declared target in the `_targets.R` file.

## Resources

- {spatsoc}
  - <https://docs.ropensci.org/spatsoc/>
  - <https://docs.ropensci.org/spatsoc/articles/using-in-sna.html>
- {targets}
  - <https://docs.ropensci.org/targets>
  - <https://books.ropensci.org/targets>

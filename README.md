
[![DOI](https://zenodo.org/badge/353198467.svg)](https://zenodo.org/badge/latestdoi/353198467)

# targets-spatsoc-networks

A template [`targets`](https://github.com/ropensci/targets) workflow for
generating social networks from GPS data with
[`spatsoc`](https://github.com/ropensci/spatsoc/).

- timegroups declared \[2 branches\]
- spatgroups declared \[2 branches\]
- gbi declared \[2 branches\]
- networks declared \[2 branches\]
- graphs declared \[2 branches\]
- metrics declared \[2 branches\]
- merged declared \[2 branches\]
  `{mermaid} graph LR   style Legend fill:#FFFFFF00,stroke:#000000;   style Graph fill:#FFFFFF00,stroke:#000000;   subgraph Legend     xf1522833a4d242c5(["Up to date"]):::uptodate     x2db1ec7a48f65a9b(["Outdated"]):::outdated     xb3df25f36846e314(["Errored"]):::errored     xbecb13963f49e50b{{"Object"}}:::none     xeb2d7cac8a1ce544>"Function"]:::none     xd03d7c7dd2ddda2b(["Regular target"]):::none     x6f7e04ea3427f824["Dynamic branches"]:::none   end   subgraph Graph     direction LR     xfeaff7c1bc5fe2e5{{"group"}}:::uptodate --> x8b0c676d7240242a["gbi"]:::outdated     xdf10c21b92224150["spatgroups"]:::outdated --> x8b0c676d7240242a["gbi"]:::outdated     xc25194a2e4c760d5{{"id"}}:::uptodate --> x8b0c676d7240242a["gbi"]:::outdated     xc389638817199bf0["networks"]:::outdated --> x2db02d438e6d5e6f["graphs"]:::outdated     x7ceaaf778822044f{{"weighted"}}:::uptodate --> x2db02d438e6d5e6f["graphs"]:::outdated     x46c09bf5c2e742c0{{"diag"}}:::uptodate --> x2db02d438e6d5e6f["graphs"]:::outdated     x8568773019f89f54{{"mode"}}:::uptodate --> x2db02d438e6d5e6f["graphs"]:::outdated     x3a8cafda074e65bb{{"path"}}:::uptodate --> x5d49490da5202c91(["locs"]):::outdated     x7691bca923fa768d{{"temporal_threshold"}}:::outdated --> x0babe2584c9010e0["merged"]:::outdated     x544e14c8fac2c5b0["metrics"]:::outdated --> x0babe2584c9010e0["merged"]:::outdated     x86be964788bf0a62{{"spatial_threshold"}}:::outdated --> x0babe2584c9010e0["merged"]:::outdated     xe5f9f129783c9289(["splitsnames"]):::outdated --> x0babe2584c9010e0["merged"]:::outdated     x6f3a445de245bc35>"calc_metrics"]:::uptodate --> x544e14c8fac2c5b0["metrics"]:::outdated     x2db02d438e6d5e6f["graphs"]:::outdated --> x544e14c8fac2c5b0["metrics"]:::outdated     xc46e1ab6af5c8492{{"associationindex"}}:::uptodate --> xc389638817199bf0["networks"]:::outdated     x8b0c676d7240242a["gbi"]:::outdated --> xc389638817199bf0["networks"]:::outdated     xe1070fbd6d46a47b{{"datetime"}}:::uptodate --> x3906e3b7b61cde90(["prep"]):::errored     x5d49490da5202c91(["locs"]):::outdated --> x3906e3b7b61cde90(["prep"]):::errored     xd135a9eb46727432>"prep_dates"]:::outdated --> x3906e3b7b61cde90(["prep"]):::errored     x83d114b3a3c10259>"check_col"]:::uptodate --> xd135a9eb46727432>"prep_dates"]:::outdated     xdc96f2f8f81b25ad>"check_truelength"]:::uptodate --> xd135a9eb46727432>"prep_dates"]:::outdated     xc25194a2e4c760d5{{"id"}}:::uptodate --> xdf10c21b92224150["spatgroups"]:::outdated     xbd740468b493bf05{{"coords"}}:::uptodate --> xdf10c21b92224150["spatgroups"]:::outdated     x86be964788bf0a62{{"spatial_threshold"}}:::outdated --> xdf10c21b92224150["spatgroups"]:::outdated     xc119b121c4bf638e["timegroups"]:::outdated --> xdf10c21b92224150["spatgroups"]:::outdated     x6fa178f2283ab5b1{{"splitBy"}}:::uptodate --> xf94084fe2fb21595(["splits"]):::outdated     x3906e3b7b61cde90(["prep"]):::errored --> xf94084fe2fb21595(["splits"]):::outdated     x3a8cafda074e65bb{{"path"}}:::uptodate --> xe5f9f129783c9289(["splitsnames"]):::outdated     x6fa178f2283ab5b1{{"splitBy"}}:::uptodate --> xe5f9f129783c9289(["splitsnames"]):::outdated     x3906e3b7b61cde90(["prep"]):::errored --> xe5f9f129783c9289(["splitsnames"]):::outdated     x7691bca923fa768d{{"temporal_threshold"}}:::outdated --> xc119b121c4bf638e["timegroups"]:::outdated     xe1070fbd6d46a47b{{"datetime"}}:::uptodate --> xc119b121c4bf638e["timegroups"]:::outdated     xf94084fe2fb21595(["splits"]):::outdated --> xc119b121c4bf638e["timegroups"]:::outdated     xec6515aea887f2e6>"check_type"]:::uptodate     x2ee4157c3daee3b7{{"input"}}:::uptodate     x3e158351e917890c>"overwrite_col"]:::uptodate   end   classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;   classDef outdated stroke:#000000,color:#000000,fill:#78B7C5;   classDef errored stroke:#000000,color:#ffffff,fill:#C93312;   classDef none stroke:#000000,color:#000000,fill:#94a4ac;`

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

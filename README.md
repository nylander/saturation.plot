# Saturation plots

- Last modified: ons feb 21, 2024  11:27
- Sign: JN

![Saturation plots](img/plots.png)

## Description

Code for generating saturation plots used in [Klopfstein et al.,
2013](https://doi.org/10.1371/journal.pone.0069344) for displaying the
relationship between the uncorrected (P-) distance and the distance on a
phylogenetic tree.

## Requirements

[R](https://www.r-project.org/) with R-package
[ape](https://cloud.r-project.org/web/packages/ape/index.html).
Recently tested with R v4.3.2 and ape v5.7.1.

## Input

1. Multiple sequence alignment in fasta format ([example](data/data.fas))
2. Tree with tip labels corresponding to sequence labels
   ([example](data/tree.phy))

## Examples

```R
library("ape")
source("src/saturation.plot.R")
tree <- read.tree("data/tree.phy")
ultrametric_tree <- read.tree("data/ultrametric.phy")
dna <- read.dna("data/data.fas", format="fasta")
third_pos <- dna[, seq(3, ncol(dna), by=3)]
firstsecond_pos <- dna[, -seq(3, ncol(dna), by=3)]
par(mfrow=c(2, 3))
saturation.plot(tree, dna, main="Default")
saturation.plot(tree, dna, main="Background, no regression line",
    bg=TRUE, regr=FALSE)
saturation.plot(tree, dna, main="Change some settings",
    bg=FALSE, col="red", ylim=c(0, 0.08), cex=0.5)
saturation.plot(tree, dna, main="Other colors and symbols",
    bg=TRUE, col="yellow", bg.col="darkgray", reg.col="red",
    pch=24, cex=1.5, lwd=2)
saturation.plot(ultrametric_tree, dna, main="Use ultrametric tree")
saturation.plot(tree, firstsecond_pos, main="Codon pos 1st+2nd vs. 3rd",
    regr=FALSE, col="red", ylim=c(0, 0.15))
saturation.plot(tree, third_pos,
    bg=FALSE, regr=FALSE, col="blue", ylim=c(0, 0.15), add=TRUE)
legend(x="topright", legend=c("3rd", "1st+2nd"),
    col=c("blue", "red"), pch=20, bty="n")
```


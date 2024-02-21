"saturation.plot" <- function(phy, dna, regression=TRUE, bg=FALSE, pch=NULL,
                              bg.col="black", col=NULL, reg.col=NULL,
                              xlab="Distance on tree", ylab="p-distance",
                              add=FALSE, ...) {

  ## Saturation plot: Uncorrected P-distance vs distance on tree.
  ## By: Seraina Klopstein, 2012 (modified by Johan Nylander, 2013)
  ## Last modified: ons feb 21, 2024  09:06

  require("ape")

  if (!inherits(phy, "phylo")) {
    stop("object 'phy' is not of class 'phylo'")
  }
  if (!inherits(dna, "DNAbin")) {
    stop("object 'dna' is not of class 'DNAbin'")
  }
  if (!is.matrix(dna)) {
    dna <- as.matrix(dna)
  }
  ## Sort sequences according to taxon names in tree file
  sortingSeq <- match(phy$tip.label, dimnames(dna)[[1]])
  dna <- dna[sortingSeq, ]
  pDist <- dist.dna(dna, model="raw", as.matrix=FALSE, pairwise.deletion=TRUE)
  MBDist <- cophenetic(phy)
  taxonList <- attr(pDist, "Labels")
  nbPairs <- (length(taxonList)^2 - length(taxonList)) / 2
  distTable <- matrix(ncol=2, nrow=nbPairs)
  helpMatrix <- matrix(ncol=length(taxonList), nrow=length(taxonList))
  counter1 <- 1
  counter2 <- 1
  for (j in 1:length(taxonList)) {
    for (k in 1:length(taxonList)) {
      if (k <= counter2) {
        helpMatrix[j, k] <- NA
      } else {
        helpMatrix[j, k] <- counter1
        counter1 <- counter1 + 1
      }
    }
    counter2 <- counter2 + 1
  }
  ## Fill matrix with pairs, divide distance by two
  for (i in 1:nbPairs) {
    distTable[i, 1] <- pDist[i] / 2
    distTable[i, 2] <- MBDist[which(helpMatrix[] == i)] / 2
  }
  ## Linear regression
  fit <- lm(distTable[, 1] ~ distTable[, 2])
  ## Plotting, black background or not, regression or not
  if (is.null(pch)) {
    pch <- 20
  }
  if (bg == TRUE) {
    if(is.null(col)) {
      col <- "white"
    }
    if(is.null(reg.col)) {
      reg.col <- col
    }
    if( add == TRUE) {
      lines(distTable[, 2], distTable[, 1], type="n", xlab=xlab, ylab=ylab, ...)
    } else {
      plot(distTable[, 2], distTable[, 1], type="n", xlab=xlab, ylab=ylab, ...)
    }
    rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4], col=bg.col)
    points(distTable[, 2], distTable[, 1], type="p", col=col, pch=pch)
    if (regression == TRUE) {
      abline(fit, col=reg.col, ...)
    }
  } else {
    if(is.null(col)) {
      col <- "black"
    }
    if(is.null(reg.col)) {
      reg.col <- col
    }
    if(add == TRUE) {
      lines(distTable[, 2], distTable[, 1], type="p", xlab=xlab, ylab=ylab, col=col, pch=pch, ...)
    } else {
      plot(distTable[, 2], distTable[, 1], type="p", xlab=xlab, ylab=ylab, col=col, pch=pch, ...)
    }
    if (regression == TRUE) {
      abline(fit, col=reg.col, ...)
    }
  }
  invisible(distTable)
}


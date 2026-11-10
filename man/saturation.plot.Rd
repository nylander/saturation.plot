\name{saturation.plot}
\alias{saturation.plot}
\title{Plot Sequence Divergence Against Phylogenetic Distance}
\description{
Creates a saturation plot comparing uncorrected sequence distances
with patristic distances from a phylogenetic tree.
Optionally adds a fitted linear regression line.
}
\usage{
saturation.plot(
  phy, dna, regression = TRUE, bg = FALSE, pch = NULL,
  bg.col = "black", col = NULL, reg.col = NULL,
  xlab = "Distance on tree", ylab = "p-distance",
  brlen = NULL, add = FALSE, ...
)
}
\arguments{
  \item{phy}{
    A tree of class \code{phylo}, with branch lengths.
    Tip labels must match sequence names in \code{dna}.
  }
  \item{dna}{
    An aligned set of DNA sequences of class \code{DNAbin}.
    Sequences are reordered to match the tree's tip labels.
  }
  \item{regression}{
    Logical; whether to draw the fitted linear regression line.
  }
  \item{bg}{
    Logical; whether to draw a background rectangle behind the points.
  }
  \item{pch}{
    Plotting symbol. If \code{NULL}, uses \code{20}.
  }
  \item{bg.col}{
    Colour of the background rectangle when \code{bg = TRUE}.
  }
  \item{col}{
    Point colour. If \code{NULL}, uses white when \code{bg = TRUE}
    and black otherwise.
  }
  \item{reg.col}{
    Regression line colour. If \code{NULL}, uses the point colour.
  }
  \item{xlab, ylab}{
    Labels for the horizontal and vertical axes.
  }
  \item{brlen}{
    Replacement value for branch lengths that are \code{NaN}.
    If \code{NULL}, encountering such lengths causes an error.
  }
  \item{add}{
    Logical; whether to add to an existing plot.
    Existing axis limits are retained.
  }
  \item{...}{
    Additional arguments passed to the initial plotting call and,
    when \code{regression = TRUE}, to \code{\link[graphics]{abline}}.
    Arguments must be suitable for the receiving functions and must
    not duplicate arguments supplied internally.
  }
}
\details{
Uncorrected sequence distances are calculated using
\code{ape::dist.dna} with \code{model = "raw"} and
\code{pairwise.deletion = TRUE}.
Patristic distances are calculated using \code{stats::cophenetic}.

Both sequence distances and patristic distances are divided by two
before plotting. The horizontal axis shows half the patristic
distance; the vertical axis shows half the uncorrected sequence
distance.

A linear model with an intercept is fitted to these values.
The \code{regression} argument controls whether its line is drawn,
not whether the model is fitted.

When \code{bg = TRUE}, the background rectangle covers the entire
plotting region, including when \code{add = TRUE}.
}
\value{
Invisibly returns a numeric matrix with one row per unordered
pair of taxa and two columns:
\item{Column 1}{Half the uncorrected sequence distance.}
\item{Column 2}{Half the patristic distance.}
}
\references{
Klopfstein, S. et al. (2013).
The Hymenopteran Tree of Life: Evidence from Protein-Coding Genes
and Objectively Aligned Ribosomal Data.
PLoS ONE, 8(8), e69344.
\doi{10.1371/journal.pone.0069344}
}
\examples{
tree <- ape::read.tree(
  system.file("extdata", "tree.phy", package = "saturation.plot")
)
dna <- ape::read.dna(
  system.file("extdata", "data.fas", package = "saturation.plot"),
  format = "fasta"
)

distances <- saturation.plot(tree, dna)
head(distances)

saturation.plot(tree, dna, regression = FALSE, col = "red")
}
\keyword{hplot}

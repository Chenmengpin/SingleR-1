% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotScoreHeatmap.R
\name{plotScoreHeatmap}
\alias{plotScoreHeatmap}
\title{Plot a score heatmap}
\usage{
plotScoreHeatmap(
  results,
  cells.use = NULL,
  labels.use = NULL,
  clusters = NULL,
  show.labels = TRUE,
  show.pruned = FALSE,
  max.labels = 40,
  normalize = TRUE,
  cells.order = NULL,
  order.by.clusters = FALSE,
  annotation_col = NULL,
  show_colnames = FALSE,
  ...
)
}
\arguments{
\item{results}{A \linkS4class{DataFrame} containing the output from \code{\link{SingleR}} or \code{\link{classifySingleR}}.}

\item{cells.use}{Integer or string vector specifying the single cells to show.
If \code{NULL}, all cells are presented.}

\item{labels.use}{String vector indicating what labels to show.
If \code{NULL}, all labels available in \code{results} are presented.}

\item{clusters}{String vector or factor containing cell cluster assignments, to be shown as an annotation bar in the heatmap.}

\item{show.labels}{Logical indicating whether the final labels of cells should be shown as an annotation bar.}

\item{show.pruned}{Logical indicating whether the pruning status of the labels should be shown as an annotation bar, as defined by \code{\link{pruneScores}}.}

\item{max.labels}{Integer scalar specifying the maximum number of labels to show.}

\item{normalize}{Logical specifying whether correlations should be normalized to lie in [0, 1].}

\item{cells.order}{Integer vector specifying the ordering of cells/columns of the heatmap.
Regardless of \code{cells.use}, this input should be the the same length as the total number of cells.
If set, turns off clustering of columns based on scoring.}

\item{order.by.clusters}{Logical scalar specifying if cells should be ordered by \code{clusters} and not by scores.
If set, this takes precedence over \code{cells.order} input.}

\item{annotation_col, show_colnames, ...}{Additional parameters for heatmap control passed to \code{\link[pheatmap]{pheatmap}}.}
}
\value{
A heatmap of assignment scores is generated on the current graphics device using \pkg{pheatmap}.
}
\description{
Create a heatmap of the \code{\link{SingleR}} assignment scores across all cell-label combinations.
}
\details{
This function creates a heatmap containing the \code{\link{SingleR}} initial assignment scores for each cell (columns) to each reference label (rows).
Users can then easily identify the high-scoring labels associated with each cell and/or cluster of cells.

If \code{show.labels=TRUE}, an annotation bar will be added to the heatmap indicating final labels assigned to the cells.
Note that scores shown in the heatmap are initial scores prior to the fine-tuning step, so the reported labels may not match up to the visual maximum for each cell in the heatmap.

If \code{max.labels} is less than the total number of unique labels, only the labels with the largest maximum scores in \code{results} are shown in the plot.
Specifically, the set of scores for each cell is centred and scaled, and the maximum transformed score for each label is used to choose the labels to retain.

Additional arguments can be passed to \code{\link[pheatmap]{pheatmap}} for further tweaking of the heatmap.
Particularly useful parameters are \code{show_colnames}, which can be used to display cell/cluster names;
and \code{annotation_col}, which can be used to add extra annotation layers.
Clustering, pruning and label annotations are automatically generated and appended to \code{annotation_col} when available.
}
\section{Normalization of colors}{

If \code{normalize=TRUE}, scores will be linearly adjusted for each cell so that the smallest score is 0 and the largest score is 1.
This is followed by cubing of the adjusted scores to improve dynamic range near 1.
Visually, the color scheme is changed to a blue-green-yellow scale.

The adjustment is intended to inflate differences between scores within a given cell for easier visualization.
This is because the scores are often systematically shifted between cells, making the raw values difficult to directly compare.
However, it may be somewhat misleading;
fine-tuning may appear to assign a cell to a label with much lower score whereas the actual scores are much closer.
It is for this reason that the color bar values are not shown as the absolute values of the score have little meaning.

Also note that this transformation is done \emph{after} the choice of the top \code{max.labels} labels.
}

\examples{
# Running the SingleR() example.
example(SingleR, echo=FALSE)
# Grab the original identities of the cells as mock clusters
clusts <- g

# Creating a heatmap with just the labels.
plotScoreHeatmap(pred)

# Creating a heatmap with clusters also displayed.
plotScoreHeatmap(pred, clusters=clusts)

# Creating a heatmap with whether cells were pruned displayed.
plotScoreHeatmap(pred, show.pruned = TRUE)

# We can also turn off the normalization with Normalize = FALSE
plotScoreHeatmap(pred, clusters=clusts, normalize = FALSE)

# To only show certain labels, you can use labels.use or max.labels
plotScoreHeatmap(pred, clusters=clusts, labels.use = c("A","B","D"))
plotScoreHeatmap(pred, clusters=clusts, max.labels = 4)

# We can pass extra tweaks the heatmap as well
plotScoreHeatmap(pred, clusters=clusts, fontsize.row = 9)
plotScoreHeatmap(pred, clusters=clusts, cutree_col = 3)

}
\seealso{
\code{\link{SingleR}}, to generate \code{scores}.

\code{\link{pruneScores}}, to remove low-quality labels based on the scores.

\code{\link[pheatmap]{pheatmap}}, for additional tweaks to the heatmap.
}
\author{
Daniel Bunis, based on code by Dvir Aran.
}

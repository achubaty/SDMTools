#' Spatial Join of Points with Raster Grids
#'
#' `extract.data` extracts data from raster object of class 'asc' (this
#' and the `adehabitatMA` package), `RasterLayer` (`raster` package) or
#' `SpatialGridDataFrame` (`sp` package) at specified locations. This represents
#' a faster version of `join.asc` of the `adehabitatMA` package that assumes all
#' locations are within the map extents. \cr \cr **Note:** there is no
#' interpolation done here. The values reported are simply the values of the
#' raster cell the point falls into.
#'
#' Implements a faster version of `join.asc` from the `adehabitatMA` package. \cr
#' \cr **NOTE:** this assumes all locations are within the extent of the
#' raster map. Values outside the extent will be given a value of NA.
#'
#' @param pts a two-column data frame or matrix with the x and y coordinates of
#' the locations of interest.
#' @param x a raster matrix of class 'asc' (this and the `adehabitatMA` package),
#' `RasterLayer` (`raster` package) or `SpatialGridDataFrame` (`sp` package)
#' @return Returns a vector equal in length to the number of locations in `pts`.
#' @author Jeremy VanDerWal \email{jjvanderwal@@gmail.com}
#' @examples
#'
#'
#' # create a simple object of class 'asc'
#' tasc <- as.asc(matrix(1:50, nr = 50, nc = 50))
#' print(tasc)
#'
#' # define some point locations
#' points <- data.frame(x = runif(25, 1, 50), y = runif(25, 1, 50))
#'
#' # extract the data
#' points$values <- extract.data(points, tasc)
#'
#' # show the data
#' print(points)
#'
#' @export extract.data
#' @usage extract.data(pts, x)
extract.data <- function(pts, x) {
  # check if raster from sp or raster package and convert if necessary
  if (inherits(x, "RasterLayer")) x <- asc.from.raster(x)
  if (inherits(x, "SpatialGridDataFrame")) x <- asc.from.sp(x)
  if (!inherits(x, "asc")) stop('matrix must be of class "asc"') # check to ensure x is of class asc
  xy <- getXYcoords(x)
  xy$x <- xy$x + attr(x, "cellsize") / 2
  xy$x <- c(xy$x[1] - attr(x, "cellsize"), xy$x)
  xy$y <- xy$y + attr(x, "cellsize") / 2
  xy$y <- c(xy$y[1] - attr(x, "cellsize"), xy$y)
  xf <- as.numeric(cut(pts[, 1], xy$x))
  yf <- as.numeric(cut(pts[, 2], xy$y))
  return(x[cbind(xf, yf)])
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{aoi_geom_save_tif_matches}
\alias{aoi_geom_save_tif_matches}
\title{Download the elevation .tif files that intersect either with an input sf (simple features) object or with a .geojson file}
\usage{
aoi_geom_save_tif_matches(
  sf_or_file,
  dir_save_tifs,
  resolution = 90,
  crs_value = 4326,
  threads = parallel::detectCores(),
  verbose = FALSE
)
}
\arguments{
\item{sf_or_file}{either an 'sf'(simple features) object or a .geojson file specifying the AOI (Area of Interest) for which the Digital Elevation Models (DEM) files should be downloaded}

\item{dir_save_tifs}{a valid path to a directory where the .tif files should be saved}

\item{resolution}{an integer value specifying the elevation resolution. The Copernicus Digital ELevation Models (DEM) currently include 90 and 30 meter resolution data}

\item{crs_value}{an integer value specifying the Coordinates Reference System (CRS) value of the Digital ELevation Models (DEM) which is by default 4326}

\item{threads}{an integer that specifies the number of threads to use in parallel when downloading the .tif files}

\item{verbose}{a boolean. If TRUE then information will be printed out in the console}
}
\value{
a list object of length 2
}
\description{
Download the elevation .tif files that intersect either with an input sf (simple features) object or with a .geojson file
}
\details{
Download Computation time: Based on a sample of 90 meter resolution images that I downloaded each file was approximately 5 MB which means in total I had to download 130 GB of
data (in case I intended to download all 20.000 files of the land areas worldwide). Therefore it is wise to download data based on the intersection of the input Area of Interest (AOI)
and an existing tile-grid of the Digital Elevation Model (DEM)

The 30 meter resolution .tif images are bigger in size but visually better (approximate image size of 1.7 MB compared to 13 MB). The time to download 90 meter resolution data is approximately
20 seconds compared to 1 minute and 10 seconds of the 30 meter resolution data (for a sample use case)
}
\examples{

\dontrun{

#.......................................
# create a directory to save the .tif
# files based on a Well Known Text (WKT)
# of a sample Area of Interest (AOI)
#.......................................

DIR_SAVE = file.path(Sys.getenv('HOME'), 'DIR_SAVE_DEM')
if (!dir.exists(DIR_SAVE)) dir.create(DIR_SAVE)

WKT='POLYGON((61.5234 27.0591, 63.6328 27.0591, 63.6328 28.1495, 61.5234 28.1495, 61.5234 27.0591))'

sf_obj = sf::st_as_sfc(WKT, crs = 4326)
sf_obj = sf::st_make_valid(sf_obj)

#.............
# 90 meter DEM
#.............

save_matches = CopernicusDEM::aoi_geom_save_tif_matches(sf_or_file = sf_obj,
                                                        dir_save_tifs = DIR_SAVE,
                                                        resolution = 90,
                                                        crs_value = 4326,
                                                        threads = parallel::detectCores(),
                                                        verbose = TRUE)

#.............
# 30 meter DEM
#.............

save_matches = CopernicusDEM::aoi_geom_save_tif_matches(sf_or_file = sf_obj,
                                                        dir_save_tifs = DIR_SAVE,
                                                        resolution = 30,
                                                        crs_value = 4326,
                                                        threads = parallel::detectCores(),
                                                        verbose = TRUE)
}
}
\references{
https://registry.opendata.aws/copernicus-dem/

https://copernicus-dem-30m.s3.amazonaws.com/readme.html

https://spacedata.copernicus.eu/en/web/guest/collections/copernicus-digital-elevation-model/
}

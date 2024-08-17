## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(fig.width = 6,
                      fig.height = 6, 
                      fig.align = "center",
                      warning = FALSE, 
                      message = FALSE,
                      echo = TRUE,
                      eval = FALSE)

## -----------------------------------------------------------------------------
#  
#  # We disable s2
#  sf::sf_use_s2(use_s2 = FALSE)
#  
#  # We load the .csv files
#  files = c(system.file('vignette_data/Alberta_Wolves.csv', package = "CopernicusDEM"),
#            system.file('vignette_data/Mountain_caribou.csv', package = "CopernicusDEM"))
#  
#  
#  leafgl_data = tmap_data = list()
#  
#  
#  for (FILE in files) {
#  
#    cat(glue::glue("Processing of the '{basename(FILE)}' file ..."), '\n')
#  
#    dtbl = data.table::fread(FILE, header = TRUE, stringsAsFactors = FALSE)
#    cols = c('location-long', 'location-lat', 'timestamp', 'individual-local-identifier',
#             'individual-taxon-canonical-name')
#  
#    dtbl_subs = dtbl[, ..cols]
#    colnames(dtbl_subs) = c('longitude', 'latitude', 'timestamp', 'individual_local_identifier',
#                            'individual-taxon-canonical-name')
#  
#    leafgl_data[[unique(dtbl_subs$`individual-taxon-canonical-name`)]] = dtbl_subs
#  
#    dtbl_subs_sf = sf::st_as_sf(dtbl_subs, coords = c("longitude", "latitude"), crs = 4326)
#  
#    sf_rst_ext = fitbitViz::extend_AOI_buffer(dat_gps_tcx = dtbl_subs_sf,
#                                              buffer_in_meters = 250,
#                                              CRS = 4326,
#                                              verbose = TRUE)
#  
#    #................................................................
#    # Download the Copernicus DEM 30m elevation data because it has
#    # a better resolution, it takes a bit longer to download because
#    # the .tif file size is bigger
#    #...............................................................
#  
#    dem_dir = tempdir()
#  
#    sfc_obj = sf_rst_ext$sfc_obj |>
#      sf::st_make_valid()
#  
#    dem30 = CopernicusDEM::aoi_geom_save_tif_matches(sf_or_file = sfc_obj,
#                                                     dir_save_tifs = dem_dir,
#                                                     resolution = 30,
#                                                     crs_value = 4326,
#                                                     threads = parallel::detectCores(),
#                                                     verbose = TRUE)
#  
#    TIF = list.files(dem_dir, pattern = '.tif', full.names = TRUE)
#  
#    if (length(TIF) > 1) {
#  
#      #....................................................
#      # create a .VRT file if I have more than 1 .tif files
#      #....................................................
#  
#      file_out = file.path(dem_dir, 'VRT_mosaic_FILE.vrt')
#  
#      vrt_dem30 = CopernicusDEM::create_VRT_from_dir(dir_tifs = dem_dir,
#                                                     output_path_VRT = file_out,
#                                                     verbose = TRUE)
#    }
#  
#    if (length(TIF) == 1) {
#  
#      #..................................................
#      # if I have a single .tif file keep the first index
#      #..................................................
#  
#      file_out = TIF[1]
#    }
#  
#    raysh_rst = fitbitViz::crop_DEM(tif_or_vrt_dem_file = file_out,
#                                    sf_buffer_obj = sfc_obj,
#                                    verbose = TRUE)
#  
#    # convert to character to receive the correct labels in the 'tmap' object
#    dtbl_subs_sf$individual_local_identifier = as.character(dtbl_subs_sf$individual_local_identifier)
#  
#    # use the latest version of the "tmap" R package (greater than version "3.99")
#    # open with interactive viewer
#    tmap::tmap_mode("view")
#  
#    map_coords = tmap::tm_shape(shp = dtbl_subs_sf) +
#      tmap::tm_dots(col = 'individual_local_identifier')
#  
#    map_coords = map_coords + tmap::tm_shape(shp = raysh_rst, is.master = FALSE, name = 'Elevation') +
#      tmap::tm_raster(col_alpha = 0.65, reverse = TRUE)
#  
#    tmap_data[[unique(dtbl_subs$`individual-taxon-canonical-name`)]] = map_coords
#  }
#  

## ----echo = FALSE-------------------------------------------------------------
#  
#    #..........................................................................................
#    # options to save the 'tmap' object:
#    #
#    #  1st. As an .html file which is approx. 9 MB
#    #  2nd. As an .RDS object which saves the raster data too and it's approx. 98 MB
#    #  3rd. Open in browser and take a screenshot and save the .png image
#    #
#    # Regarding the 1st. option an .html file can be loaded in an Rmarkdown file and
#    # viewed on a web browser using 'iframe' in the following way:
#    #
#    # <iframe width='1000px' height='1000px' src='/home/lampros/Downloads/delete_vig.html' >
#    # <p>Your browser does not support iframes</p>
#    #  </iframe>
#    #
#    # see: https://stackoverflow.com/a/54637781/8302386
#    #      https://stackoverflow.com/a/36525111/8302386
#    #..........................................................................................
#  

## -----------------------------------------------------------------------------
#  
#  #.....................................
#  # create the 'leafGl' of both datasets
#  #.....................................
#  
#  dtbl_all = rbind(leafgl_data$`Canis lupus`, leafgl_data$`Rangifer tarandus`)
#  
#  # see the number of observations for each animal
#  table(dtbl_all$`individual-taxon-canonical-name`)
#  
#  # create an 'sf' object of both data.tables
#  dat_gps_tcx = sf::st_as_sf(dtbl_all, coords = c("longitude", "latitude"), crs = 4326)
#  
#  lft = leaflet::leaflet()
#  lft = leaflet::addProviderTiles(map = lft, provider = leaflet::providers$OpenTopoMap)
#  
#  lft = leafgl::addGlPoints(map = lft,
#                            data = dat_gps_tcx,
#                            opacity = 1.0,
#                            fillColor = 'individual-taxon-canonical-name',
#                            popup = 'individual-taxon-canonical-name')
#  lft
#  

## -----------------------------------------------------------------------------
#  
#  tmap_data$`Rangifer tarandus`                            # caribou
#  

## -----------------------------------------------------------------------------
#  
#  tmap_data$`Canis lupus`                                  # wolves
#  


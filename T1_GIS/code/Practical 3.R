install.packages('ncf')
install.packages('raster')
install.packages('sf')
install.packages('SpatialPack') # For clifford test
install.packages('spdep') # Spatial dependence
install.packages('nlme') # GLS
install.packages('spgwr')
install.packages('rgdal')

library(ncf)
library(raster)
library(sf)
library(spdep)
library(SpatialPack)
library(nlme)
library(spgwr)



#get TIFs
rich <- raster('data/avian_richness.tif')
aet <- raster('data/mean_aet.tif')
temp <- raster('data/mean_temp.tif')
elev <- raster('data/elev.tif')


#plot tifs
par(mfrow=c(2,2))
plot(rich, main='Avian species richness')
plot(aet, main='Mean AET')
plot(temp, main='Mean annual temperature')
plot(elev, main='Elevation')

# split the figure area into a two by two layout
par(mfrow=c(2,2))
# plot a histogram of the values in each raster, setting nice 'main' titles
hist(rich, main='Avian species richness')
hist(aet, main='Mean AET')
hist(temp, main='Mean annual temperature')
hist(elev, main='Elevation')


# Stack the data
data_stack <- stack(rich, aet, elev, temp)
print(data_stack)

data_spdf <- as(data_stack, 'SpatialPixelsDataFrame')
summary(data_spdf)

data_sf <- st_as_sf(data_spdf)
print(data_sf)

cellsize <- res(rich)[[1]]
template <- st_polygon(list(matrix(c(-1,-1,1,1,-1,-1,1,1,-1,-1), ncol=2) * cellsize / 2))

polygon_data <- lapply(data_sf$geometry, function(pt) template + pt)
data_poly <- st_sf(avian_richness = data_sf$avian_richness, 
                   geometry=polygon_data)

layout(matrix(1:3, ncol=3), widths=c(5,5,1))

plot(data_spdf['avian_richness'], col=hcl.colors(20), what='image')
plot(data_sf['avian_richness'], key.pos=NULL, reset=FALSE, main='', 
     pal=hcl.colors, cex=0.7, pch=20)
plot(data_spdf['avian_richness'], col=hcl.colors(20), what='scale')


# Create three figures in a single panel
par(mfrow=c(1,3))
# Now plot richness as a function of each environmental variable
plot(avian_richness ~ mean_aet, data=data_sf)
plot(avian_richness ~ mean_temp, data=data_sf)
plot(avian_richness ~ elev, data=data_sf)


temp_corr <- modified.ttest(x=data_sf$avian_richness, y=data_sf$mean_temp, 
                            coords=st_coordinates(data_sf))

temp_corr <- modified.ttest(x=data_sf$avian_richness, y=data_sf$mean_temp, 
                            coords=st_coordinates(data_sf))
print(temp_corr)


# Give dnearneigh the coordinates of the points and the distances to use
rook <- dnearneigh(data_sf, d1=0, d2=cellsize)
queen <- dnearneigh(data_sf, d1=0, d2=sqrt(2) * cellsize)

print(rook)
head(rook, n=3)
print(queen)
head(queen, n=3)

knn <- knearneigh(data_sf, k=8)
# We have to look at the `nn` values in `knn` to see the matrix of neighbours
head(knn$nn, n=3)


plot(data_sf[c('card_rook', 'card_queen')], key.pos=4)



# Recreate the neighbour adding 1km to the distance
rook <- dnearneigh(data_sf, d1=0, d2=cellsize + 1)
queen <- dnearneigh(data_sf, d1=0, d2=sqrt(2) * cellsize + 1)
data_sf$card_rook <- card(rook)
data_sf$card_queen <- card(queen)
plot(data_sf[c('card_rook', 'card_queen')], key.pos=4)

knn <- knearneigh(data_sf, k=8)
# We have to look at the `nn` values in `knn` to see the matrix of neighbours
head(knn$nn, n=3)
queen <- nb2listw(queen)


# Polygon covering Mauritius
mauritius <- st_polygon(list(matrix(c(5000, 6000, 6000, 5000, 5000,
                                      0, 0, -4000, -4000, 0), 
                                    ncol=2)))
mauritius <- st_sfc(mauritius, crs=crs(data_sf, asText=TRUE))
# Remove the island cells with zero neighbours
data_sf <- subset(data_sf, card_rook > 0)
# Remove Mauritius
data_sf <- st_difference(data_sf, mauritius)



rook <- dnearneigh(data_sf, d1=0, d2=cellsize + 1)
queen <- dnearneigh(data_sf, d1=0, d2=sqrt(2) * cellsize + 1)
data_sf$card_rook <- card(rook)
data_sf$card_queen <- card(queen)
knn <- knearneigh(data_sf, k=8)

rook <- nb2listw(rook, style='W')
queen <- nb2listw(queen, style='W')
knn <- nb2listw(knn2nb(knn), style='W')


moran_avian_richness <- moran.test(data_sf$avian_richness, rook)
print(moran_avian_richness)

geary_avian_richness <- geary.test(data_sf$avian_richness, rook)
print(geary_avian_richness)



simple_model <- lm(avian_richness ~ mean_aet + elev + mean_temp, data=data_sf)
summary(simple_model)

sar_model <- errorsarlm(avian_richness ~ mean_aet + elev + mean_temp, 
                        data=data_sf, listw=queen)
summary(sar_model)

# extract the predictions from the model into the spatial data frame
data_sf$simple_fit <- predict(simple_model)
data_sf$sar_fit <- predict(sar_model)
# Compare those two predictions with the data
plot(data_sf[c('avian_richness','simple_fit','sar_fit')], 
     pal=function(n) hcl.colors(n, pal='Blue-Red'))


# extract the residuals from the model into the spatial data frame
data_sf$simple_resid <- residuals(simple_model)
data_sf$sar_resid <- residuals(sar_model)
# Create a 21 colour ramp from blue to red, centred on zero
colPal <- colorRampPalette(c('cornflowerblue', 'grey','firebrick'))
colours <- colPal(21)
breaks <- seq(-600, 600, length=21)
# plot the residuals side by side
plot(data_sf[c('avian_richness','simple_fit','sar_fit')], 
     col=colours, at=breaks)

# add the X and Y coordinates to the data frame
data_xy <- data.frame(st_coordinates(data_sf))
data_sf$x <- data_xy$X
data_sf$y <- data_xy$Y


# calculate a correlogram for avian richness: a slow process!
rich.correlog <- with(data_sf, correlog(x, y, avian_richness, increment=cellsize, resamp=0))
plot(rich.correlog)



# Calculate correlograms for the residuals in the two models
simple.correlog <- with(data_sf, correlog(x, y, simple_resid, increment=cellsize, resamp=0))
sar.correlog <- with(data_sf, correlog(x, y, sar_resid, increment=cellsize, resamp=0))

# Convert those to make them easier to plot
simple.correlog <- data.frame(simple.correlog[1:3])
sar.correlog <- data.frame(sar.correlog[1:3])

# plot a correlogram for shorter distances
plot(correlation ~ mean.of.class, data=simple.correlog, type='o', subset=mean.of.class < 5000)
# add the data for the SAR model to compare them
lines(correlation ~ mean.of.class, data=sar.correlog, type='o', subset=mean.of.class < 5000, col='red')

# add a horizontal  zero correlation line
abline(h=0)








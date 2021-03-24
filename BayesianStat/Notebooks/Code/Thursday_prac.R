

rm(list = ls())
graphics.off()

# load functions
source("../Data/functions.R")
load("../Data/polar.brown.sfs.Rdata")
library(abc)

# Inspect the objects
ls()

# plot the spectrum (error)
# plot2DSFS(sfs = polar.brown.sfs, xlab = 'Polar', ylab = 'Brown', main = '2D-SFS')

# 1. observed summary statistics
obsSummaryStats <- calcSummaryStats(polar.brown.sfs)
obsSummaryStats

# 2.simulation
nChroms.polar <- nrow(polar.brown.sfs)-1
nChroms.brown <- ncol(polar.brown.sfs)-1
# calculate the total site
nrSites <- sum(polar.brown.sfs, na.rm = TRUE)
# set the simulation times you want to run
nrSimul <- 50

# define the prior distribution of parameters to be estimated
t <- runif(n = nrSimul, min = 2e5, max = 7e5)
M <- runif(nrSimul, 0, 20)


# first, set the path to the "ms" software you installed
msDir <- "../Software/msdir/ms" # this is my specific case, yours could be different
# second, set the name for the output text file
fout <- "../Software/msdir/ms.txt" # leave it like here

# then we can simulate data:
sim_df <- data.frame()
summar <- data.frame()
for (i in 1:nrSimul) {
  sim <- simulate(T = t[i],M = M[i],nrSites, msDir, fout)
  sim_df <- rbind(sim_df, sim)
  
  # calculate the summary statistics for simulations
  #(note that you need to specify the number of chromosomes for the two species)
  simulatedSFS <- fromMStoSFS(fout, nrSites, nChroms.polar, nChroms.brown)
  summar <- rbind(summar, calcSummaryStats(simulatedSFS))
  
  # you can even plot the simulated site frequency spectrum
  plot2DSFS(simulatedSFS, xlab="Polar", ylab="Brown", main="simulated 2D-SFS")
}

# 3. use abc function to calculate the posterior distribution
result <- abc(obsSummaryStats, cbind(t, M), summar, method = 'rejection', tol = 0.1)
hist(result)

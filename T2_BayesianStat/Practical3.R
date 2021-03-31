setwd("~/Desktop/Linux/Documents/Spring_Semester/Bayesian_Statistics/statistical_inference/Practicals/")

source("data/functions.R")
load("data/polar.brown.sfs.Rdata")

# plot spectrum
plot2DSFS(polar.brown.sfs, xlab = "Polar", ylab = "Brown", main = "2D-SFS")

# number of chromosomes for each species
nChroms.polar = nrow(polar.brown.sfs)-1
nChroms.brown = ncol(polar.brown.sfs)-1

# number of analysed sites
nrSites = sum(polar.brown.sfs, na.rm = T)

# calculating summary statistics
obsSummaryStats = calcSummaryStats(polar.brown.sfs)

# SIMULATIONS

# number of simulations
nrSimul = 1e5

# define a uniform prior distribution to our parameter of interest (T - divergence time)
T = runif(nrSimul, 2e5, 7e5)

# preallocate dataframe to store summary statistics values
simulatedSummaryStats = matrix(NA, nrow = nrSimul, ncol = length(obsSummaryStats))
colnames(simulatedSummaryStats) = c("fst", "pivar1", "pivar2", "sing1", "sing2", "doub1", "doub2", "pef", "puf")

# set path to the "ms" software
msDir = "../Notebooks/Bayesian/Software/msdir/ms"

# set the name of the output text file
fout = "ms.txt"

for(i in 1:nrSimul){
  
  # simulate data
  simulate(T = T[i], M = 0, nr_snps = nrSites, ms_dir = msDir, fout = fout)
  
  # calculate summary statistics
  simulatedSFS = fromMStoSFS(fout, nrSites, nChroms.polar, nChroms.brown)
  simulatedSummaryStats[i, 1:length(obsSummaryStats)] = calcSummaryStats(simulatedSFS)
}

# CHOOSING IMPORTANT SUMMARY STATISTICS
pdf("Figure4.pdf")
pairs(scratch)
dev.off()

cor(scratch)

pdf("Figure5.pdf")
par(mfrow=c(3,3))
for(i in 1:length(colnames(scratch))){
  plot(T, scratch[,i], cex = 0.5, ylab = colnames(scratch)[i])
}
dev.off()

# POSTERIOR PROBABILITY DISTRIBUTION

sumStats = rbind(obsSummaryStats, simulatedSummaryStats)
scaledStats = scale(sumStats)

library(abc)
post = abc(target = scaledStats[1,1], param = T, 
           sumstat = scaledStats[2:(nrow(scaledStats)-1),1], 
           tol = 0.01, method = "rejection")

pdf("Figure6.pdf")
hist(post)
dev.off()


mu <- 1e-8
## Practical on coalescence theory

## first thing, read genomic data for each population
## since the alleles are encoded as 0 and 1 in this case, it's better to store the data as a matrix

# set the length of the region
len <- 50000

# read data
data_N <- as.matrix(read.csv("../Data/killer_whale_North.csv", stringsAsFactors=F, header=F, colClasses=rep("numeric", len)))
dim(data_N)

data_S <- as.matrix(read.csv("../Data/killer_whale_South.csv", stringsAsFactors=F, header=F, colClasses=rep("numeric", len)))
dim(data_S)


## 1) We wish to estimate of effective population size

### I suggest to use the Tajima's estimator for theta as seen in class (equation 15): this is a relationship between theta (see equation 14, an estimator of genetic diversity) and Ne (population size) and mu (mutation rate)

# therefore you need to write a script that calculates the average number of pairwise differences (or Pi, equation 15).

# start from one population (e.g. North)
n <- nrow(data_N) # nr of samples (chromosomes)
pi_N <- 0 # # initialise pi
# the easiet thing will be to loop over all pairs of sequences (you need two nested for loops)
# for instance, if you have 4 sequences, how can you loop over these unique pairs:
# 1 vs 2
# 1 vs 3
# 1 vs 4
# 2 vs 3
# 2 vs 4
# 3 vs 4.
# You have two indexes for the loop. The first index (let's call it i) goes from 1 to 3 (while you have 4 sequences), and the second index (let's call it j) starts from 2 when i=1, starts from 3 when i=2, etc etc, and finished at 4. 
# How can you create these two nested loops?
for (i in 1:(n-1)) { # loop of i
  for (j in (i+1):n) {
    pi_N <- pi_N +sum(abs(data_N[i,]-data_N[j,]))
  }
}
# divide by the nr of comparisons done
pi_N <- pi_N / ((n*(n-1))/2)
# you obtained a Tajima's estimator of theta for the Northern population

# repeat the same procedure to calculate pi_S (Tajima's estimator of theta for the Northern population)
n <- nrow(data_S)
pi_S <- 0
for (i in 1:(n-1)) { # loop of i
  for (j in (i+1):n) {
    pi_S <- pi_S +sum(abs(data_S[i,]-data_S[j,]))
  }
}
# divide by the nr of comparisons done
pi_S <- pi_S / ((n*(n-1))/2)

## now that you have theta you can estimate Ne using equation 14 on the slides
# remember to multiple the mutation rate 1e-8 with the length your sequence before plugging it into the quation
Ne_N_pi <- pi_N / (4*mu*len) # 4634.211
Ne_S_pi <- pi_S / (4*mu*len) # 768.4211

### you can also calculate theta using Watterson's estimator (equation 20)

# first we need to calculate the nr of SNPs
# try to use apply function
# type ?apply to understand how it works
# for instance the following code (when completed) will calculate the allele frequencies
freqs <- apply(X=data_N, MAR=2, FUN=sum)/nrow(data_N)
S_N <- length(which(freqs>0 & freqs<1))
# why am I using the function "sum"?

# then SNPs are simply sites where the allele frequency freqs is different from 0 or 1

# use equation 20 calculate watterson estimator
watt_N <- S_N / sum(1/seq(1,(n-1)))

# repeat the same procedure for S population
freqs_S <- apply(data_S, 2, sum) / nrow(data_S)
S_S <- length(which(freqs_S>0 & freqs_S<1))
watt_S <- S_S / sum(1/seq(1:(n-1)))

### estimates of Ne from Wattersons' estimator
Ne_N_watt <- watt_N/(4*mu*len)
Ne_S_watt <- watt_S/(4*mu*len)

cat("\nThe North population has estimates of effective population size of", Ne_N_pi, "and", Ne_N_watt)
cat("\nThe South population has estimates of effective population size of", Ne_S_pi, "and", Ne_S_watt)
# 4634.211 and 4650.849
# 768.4211 and 845.6088




## 2) Site Frequency Spectra

### North population
f_N <- rep(0, n-1) # initialise a vector from 0 to n-1
### calculate allele frequencies using the apply functions as previously shown
derived_freqs <- apply(data_N, 2, sum)
### the easiest (but slowest) thing to do would be to loop over all possible allele frequencies and count the occurrences of each possible allele frequency
for (i in 1:(n-1)) f_N[i] <- length(which(derived_freqs == i))

### South population
# repeat as above
f_S <- rep(0, n-1)
derived_freqs <- apply(data_S, 2, sum)
for (i in 1:(n-1)) f_S[i] <- length(which(derived_freqs == i))

### plot
barplot(f_N)
barplot(f_S)
barplot(t(cbind(f_N, f_S)), beside=T)# or use any other plotting functions

f_S <- f_S/sum(f_S)
f_N <- f_N/sum(f_N)
barplot(t(cbind(f_N, f_S)), beside=T)















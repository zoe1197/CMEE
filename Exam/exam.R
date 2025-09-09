

Qa <- function(fA1, fA2){
  HS <- (2*fA1*(1-fA1)+2*fA2*(1-fA2))/2
  D <- (fA1-fA2)
  HT <- HS + (D^2/2)
  FST <- (HT-HS)/HT
  return(c(HS,D,HT,FST))
}

Qa(fA1 = 0.2, fA2 = 0.1)
Qa(fA1 = 0.3, fA2 = 0.3)
Qa(fA1 = 0, fA2 = 1)

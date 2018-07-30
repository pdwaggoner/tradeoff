# This measure is in a paper currently Under Review. Please be sure to let me know if you want to use or work with this.

# Here is a *very* preliminary, pre-cleaned version of the measure (more categorization and cleaning to come).

# Need to upload data set (here, "dta") with units as items selected by actors (e.g., individual bills sponsored by MCs), 
# Then with "topic" as the category of interest, where 1= the value pursued, and 0= the value not pursued, the standardized difference of which is the tradeoff.

# Load for standardization later (depends)
library(arm)

# Consider loading data externally: read.csv(file.choose()), depending where wd set

# Working function for single step: Basic intuition is to loop over actors and total things up for actor, i, acting within congress, j, given smaller units of analysis as individual choices by actors
tradeoff <- function(dta){ # df to manipulate and creat objects within function; likely work with roxygen "usage" at a later point (i.e., consider each vector as a parameter)
      dta <- dta # old df
      Tot.P.Topics <- sum(dta$Topic==1) # P
      Tot.NP.Topics <- sum(dta$Topic==0) # NP
      MCs <- sort(unique(dta$icpsr)) # can be any unique identifier ("icpsr" here as an example using members of congress (MCs) as actors)
      Ind.P <- numeric(length(MCs))
      Ind.NP <- numeric(length(MCs))
      cong <- sort(unique(dta$congress)) # Unique congress in which legislator/MC is acting

      for (j in 1:length(cong){
            for(i in 1:length(MCs)){
                  xdta <- dta[which(dta$icpsr==MCs[i,j]),]
                  Ind.P[i,j] <- sum(xdta$Topic==1)/Tot.P.Topics
                  Ind.NP[i,j] <- sum(xdta$Topic==0)/Tot.NP.Topics 
                  }
            }
            #New.dta <- data.frame(MCs, Ind.P, Ind.NP)
            tradeoff[i,j] <- (Ind.P[i,j] - Ind.NP[i,j])
      return(tradeoff)
}



# Combine new indicators into single data frame
New.dta <- data.frame(MCs, tradeoff)
hist(New.dta$tradeoff) # Check distribution of tradeoff scores

# Standardize tradeoff scores by centering on 0, then dividing by 2 standard deviations (Gelman 2008) - from "arm" package
New.dta$tradeoff.std <- rescale(New.dta$tradeoff) # Rescales to put points on a -x to +x scale
hist(New.dta$tradeoff.std) # Should be centered over 0 now
summary(New.dta$tradeoff.std) # Check for min and max, and other descriptives

           
## OR proceed by individual steps (old method)
#Step 1: Total up the number of Priority (P) topics and Non-Priority (NP) topics; this determines the tradeoff being made by the actor (e.g., district vs. non-district; owned vs. trespassed; black vs. red)
Tot.P.Topics <- sum(dta$Topic==1) # P
Tot.NP.Topics <- sum(dta$Topic==0) # NP

#Step 2: Create a list of individual actors and a few places to store things
MCs <- sort(unique(dta$icpsr)) # can be any unique identifier ("icpsr" here as an example using members of congress (MCs) as actors)
Ind.P <- numeric(length(MCs))
Ind.NP <- numeric(length(MCs))
#cong <- sort(unique(dta$congress)) # Unique congress in which legislator/MC is acting

#Step 3: Loop over actors and total things up for actor, i, acting within congress, j, given smaller units of analysis as individual choices by actors
for(i in 1:length(MCs)){
      xdta <- dta[which(dta$icpsr==MCs[i]),]
      Ind.P[i] <- sum(xdta$Topic==1)/Tot.P.Topics
      Ind.NP[i] <- sum(xdta$Topic==0)/Tot.NP.Topics 
}

#Step 4: Combine new indicators into single data frame
New.dta <- data.frame(MCs, Ind.P, Ind.NP)

#Step 5: Calculate "tradeoff" Score
New.dta$tradeoff <- (New.dta$Ind.P - New.dta$Ind.NP)

hist(New.dta$tradeoff) # Check distribution of tradeoff scores

#Step 6: Standardize tradeoff scores by centering on 0, then dividing by 2 standard deviations (Gelman 2008) - from "arm" package
New.dta$tradeoff.std <- rescale(New.dta$tradeoff) # Rescales to put points on a -x to +x scale

# Basic diagnostics
#hist(New.dta$tradeoff.std) # Should be centered over 0 now
#summary(New.dta$tradeoff.std) # Check for min and max, and other descriptives

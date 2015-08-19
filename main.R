source("functions.R")

# process raw data
process_data()

# average technical replicates
tech_reps()

# Now one needs to complile (knit) the following reports:
# 1. bio-reps-summary.Rmd
# 2. bio-reps-averaging.Rmd
# 3. preparation-for-modeling.Rmd

# make a copasi experiment file
clean_for_copasi()

# calculate activities of PTEN and SHIP2 based on inhibitor data
inhibitor_regressions()

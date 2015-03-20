source("functions.R")

# first bunch of data
process_data()
tech_reps()



plot_gold_ratios("pip2")
plot_gold_ratios("pip3")
average_tech_reps("pip2")
average_tech_reps("pip3")
plot_species()

plot_species1("pip2")
plot_species1("pip3")

# data with inhibitors
process_data_inhibitors()
plot_gold_ratios("inhibitors")
average_tech_reps("inhibitors")
plot_species_inhibitors()

# test
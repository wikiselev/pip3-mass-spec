source("functions.R")

process_data()
tech_reps()

rep1 <- get_bio_rep("2014_12_12B_c18_wt_ab_pten_tc", "SA_P2_aldehyde_34")
rep2 <- get_bio_rep("2015_02_14A_c18_pten_ab_pab_tcN2_pabVSpabsN2", "SA_P2_aldehyde_34")
rep3 <- get_bio_rep("2015_03_06B_c18_pi34p2Trans_n3", "SA_P2_aldehyde_34")







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
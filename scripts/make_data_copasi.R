library(data.table)
library(ggplot2)

cell.radius <- 10e-6 # [m]; Malek: average diameter of MCF10a cells: 18.7 um
cell.volume <- 4/3*3.14*cell.radius^3*1e3 # [l]
nucleus.volume <- 0.1*cell.volume # [l]; 10% of cell volume - from Wikipedia
cytoplasm.volume <- cell.volume - nucleus.volume # [l]

##### 
# membrane.adjacent.distance <- 15e-9 # [m] layer of reactions happening on the 
#                                     # membrane
# membrane.adjacent.volume <- 4*3.14*cell.radius^2*membrane.adjacent.distance*1e3 
#                 # [l]
# alpha <- cytoplasm.volume/membrane.adjacent.volume # coefficient that is 
# # described in: Kiyatkin, A. Scaffolding Protein Grb2-associated Binder 1 
# # Sustains Epidermal Growth Factor-induced Mitogenic and Survival Signaling by 
# # Multiple Positive Feedback Loops. Journal of Biological Chemistry 281, 
# # 19925–19938 (2006).

ms.cell.number <- 250000 # number of cells involved in each mass spec experiment

get_data_f3 <- function(f){
	d <- readRDS(paste0("../pip3/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.036718508
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "P3_4"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pip3/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

get_data_f2 <- function(f){
	d <- readRDS(paste0("../pip3/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.016267146
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "P2_4"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pip2/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

get_data_f34 <- function(f){
	d <- readRDS(paste0("../pip2/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.033106953
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "SA_P2_aldehyde_34"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pi34p2/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

get_data_f45 <- function(f){
	d <- readRDS(paste0("../pip2/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.1328752
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "SA_P2_aldehyde_45"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pi45p2/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

get_data_inhibitors_f3 <- function(f){
	d <- readRDS(paste0("../inhibitors/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.036718508
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "P3_4"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pip3_inhibitors/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

get_data_inhibitors_f2 <- function(f){
	d <- readRDS(paste0("../inhibitors/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.016267146
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "P2_4"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pip2_inhibitors/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

get_data_inhibitors_f34 <- function(f){
	d <- readRDS(paste0("../inhibitors/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.033106953
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "SA_P2_aldehyde_34"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pi34p2_inhibitors/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

get_data_inhibitors_f45 <- function(f){
	d <- readRDS(paste0("../inhibitors/data-processed/", f))
	# convert to nmols - see Malek's email (he made a mistake - should be nmol)
	d$Golden.Ratio <- d$Golden.Ratio*0.1328752
	d <- d[,list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)),
		by = c("Component.Name", "Genotype", "Condition", "Antagonist", "Time")]
	d <- d[Component.Name == "SA_P2_aldehyde_45"]
	# convert to pmols
	d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech*1e3
	# converting pmol units of mass spec experiments into uM concentration
	d$uM <- d$Golden.Ratio.Av.Tech/
	        ms.cell.number*   # per 1 cell
	        1e-12/            # pmol --> mol
	        cytoplasm.volume/ # divide by the cell volume and get 
	                          # concentration in M
	        1e-6              # M --> uM
	d$file <- strsplit(f, "\\.")[[1]][1]
	# write.csv(d, file = paste0("../copasi/pi45p2_inhibitors/", strsplit(f, "\\.")[[1]][1], ".csv"),
	# 	row.names = F)
	return(d)
}

###### PIP3, PIP2
files <- list.files("../pip3/data-processed/")
d.tot <- data.table()
for(f in files) {
	d <- get_data_f3(f)
	d.tot <- rbind(d.tot, d)
	d <- get_data_f2(f)
	d.tot <- rbind(d.tot, d)
}

###### PI34P2, PI45P2
files <- list.files("../pip2/data-processed/")
for(f in files) {
	d <- get_data_f34(f)
	d.tot <- rbind(d.tot, d)
	d <- get_data_f45(f)
	d.tot <- rbind(d.tot, d)
}

###### INHIBITORS
files <- list.files("../inhibitors/data-processed/")

f <- files[1]
d <- get_data_inhibitors_f3(f)
d.tot <- rbind(d.tot, d)
d <- get_data_inhibitors_f2(f)
d.tot <- rbind(d.tot, d)

f <- files[2]
d <- get_data_inhibitors_f34(f)
d.tot <- rbind(d.tot, d)
d <- get_data_inhibitors_f45(f)
d.tot <- rbind(d.tot, d)

f <- files[3]
d <- get_data_inhibitors_f3(f)
d.tot <- rbind(d.tot, d)
d <- get_data_inhibitors_f2(f)
d.tot <- rbind(d.tot, d)

write.csv(d.tot, file = paste0("../copasi/all-data-uM.csv"),
	row.names = F)

##### then I've selected the data that will be used in COPASI, here I plot it:
d <- read.csv("../copasi/all-data-uM-for-copasi-R.csv")
d$Condition1 <- factor(d$Condition1, levels = 
	c("WT", "siINPP4(A+B)", "siSHIP2", "PTEN", "PTEN&siINPP4(A+B)",
		"PTEN&siINPP4(A+B)&siSHIP2", "PTEN&siSHIP2"))
p <- ggplot(d[d$Lipid == "PIP3",], aes(x = Time, y = uM, color = Antagonist, group = Antagonist)) +
	geom_point(aes(shape = Antagonist)) +
	geom_line() +
	facet_grid(Lipid ~ Condition1, scale = "free") +
	labs(x = "Time, s", y = "Concentration, uM") +
	theme_bw()
ggsave(p, file = "../copasi/all-data-uM-for-copasi-R-PIP3.pdf", w = 18, h = 3)

p <- ggplot(d[d$Lipid == "PI(3,4)P2",], aes(x = Time, y = uM, color = Antagonist, group = Antagonist)) +
	geom_point(aes(shape = Antagonist)) +
	geom_line() +
	facet_grid(Lipid ~ Condition1, scale = "free") +
	labs(x = "Time, s", y = "Concentration, uM") +
	theme_bw()
ggsave(p, file = "../copasi/all-data-uM-for-copasi-R-PI34P2.pdf", w = 18, h = 3)

p <- ggplot(d[d$Lipid == "PI(4,5)P2",], aes(x = Time, y = uM, color = Antagonist, group = Antagonist)) +
	geom_point(aes(shape = Antagonist)) +
	geom_line() +
	facet_grid(Lipid ~ Condition1, scale = "free") +
	labs(x = "Time, s", y = "Concentration, uM") +
	theme_bw()
ggsave(p, file = "../copasi/all-data-uM-for-copasi-R-PI45P2.pdf", w = 18, h = 3)

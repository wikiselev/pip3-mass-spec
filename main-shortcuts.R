process_data <- function() {
        files <- list.files("all-data/raw/")
        files <- files[grepl("*.csv", files)]
        files1 <- files[grepl("_c4_", files)]
        files2 <- files[grepl("_c18_", files)]
        
        for(f in files1) {
                print(f)
                # import the raw data table in a text format. Here it is delimited by "," --
                # can be change if the text file format is different
                data <- read.csv(paste0("all-data/raw/", f))
                # leave only columns that are of interest. Here "Sample.ID", "Component.Name"
                # and "Area" columns are left
                data <- data[ , colnames(data) %in% c("Sample.ID", "Component.Name", "Area")]
                # there is one experiment with some weird values
                # here I get rid of them - checked with Anna
                data <- data[data$Sample.ID != "blank", ]
                if (dim(data[data$Area == "N/A", ])[1] != 0) {
                  data[data$Area == "N/A", ]$Area <- 0
                }
                
                data1 <- data.frame()

                data1 <- rbind(data1,
                               merge(data[grep("P3_", data$Component.Name), ],
                                     data[data$Component.Name == "ISD_PIP3", ],
                                     by = "Sample.ID"))
                data1 <- rbind(data1,
                               merge(data[grep("P2_", data$Component.Name), ],
                                     data[data$Component.Name == "d7_SA_P2", ],
                                     by = "Sample.ID"))
                data1 <- rbind(data1,
                               merge(data[grep("PI_", data$Component.Name), ],
                                     data[data$Component.Name == "ISD_PI", ],
                                     by = "Sample.ID"))
                data1 <- rbind(data1,
                               merge(data[grep("PIP_", data$Component.Name), ],
                                     data[data$Component.Name == "ISD_PI", ],
                                     by = "Sample.ID"))
                
                data1$ng <- as.numeric(data1$Area.x)/as.numeric(data1$Area.y)
                
                data1$PI.ng <- rep(data1[grep("PI_", data1$Component.Name.x), ]$ng, 4)
                data1$Golden.Ratio <- data1$ng/data1$PI.ng
                
                # import the sample information table in a text format. Please modify the sample
                # iformation file in advance so that it looks like (this is an example):
                
                # 1,100000,WT sictrl 1 a
                # 2,100000,WT sictrl 0 b
                # 3,100000,WT siINPP4A+B 1 a
                # 4,100000,WT siINPP4A+B 0 b
                # 5,100000,PTEN sictrl 1 a
                # 6,100000,PTEN sictrl 0 b
                # 7,100000,PTEN siship2 1 a
                # 8,100000,PTEN siship2 1 b
                
                # most importantly - the last column should have strings separated by " " --
                # this separation will create table columns with these strings.
                samples <- read.table(paste0("all-data/sample-lists/", f), sep = ",")
                samples.split <- t(as.data.frame(strsplit(samples[,3], " ")))[ , c(1, 2, 3, 4, 6)]
                samples <- as.data.frame(cbind(samples[, 1], samples.split))
                rownames(samples) <- NULL
                colnames(samples) <- c("Sample.ID", "Genotype", "Condition", "Antagonist", "Time", "Tech.Rep")
                # merge data and samples by Sample ID
                res <- merge(data1, samples, by = "Sample.ID")
                res$Time <- as.numeric(res$Time)
                # res <- res[,c(1, 2, 5:11)]
                res <- as.data.table(res)
                # filter only _4 species
                res <- res[grepl("_4", Component.Name.x)]
                # save the new data table to a file
                saveRDS(res, paste0("all-data/processed/", strsplit(f, "\\.")[[1]][1], ".rds"))
        }

        for(f in files2) {
                print(f)
                # import the raw data table in a text format. Here it is delimited by "," --
                # can be change if the text file format is different
                data <- read.csv(paste0("all-data/raw/", f))
                # leave only columns that are of interest. Here "Sample.ID", "Component.Name"
                # and "Area" columns are left
                data <- data[ , colnames(data) %in% c("Sample.ID", "Component.Name", "Area")]
                # there is one experiment with some weird values
                # here I get rid of them - checked with Anna
                data <- data[data$Sample.ID != "blank", ]
                if (dim(data[data$Area == "N/A", ])[1] != 0) {
                  data[data$Area == "N/A", ]$Area <- 0
                }
                
                data1 <- data.frame()
                
                data1 <- rbind(data1,
                               merge(data[data$Component.Name == "SA_P2_aldehyde_45", ],
                                     data[data$Component.Name == "d6_SA_P2_aldehyde_45", ],
                                     by = "Sample.ID"))
                data1 <- rbind(data1,
                               merge(data[data$Component.Name == "SA_P2_aldehyde_34", ],
                                     data[data$Component.Name == "d6_SA_P2_aldehyde_34", ],
                                     by = "Sample.ID"))
                data1 <- rbind(data1,
                               merge(data[data$Component.Name == "SA_PI_aldehyde", ],
                                     data[data$Component.Name == "17:0-20:4_PI_aldehyde", ],
                                     by = "Sample.ID"))
                data1 <- rbind(data1,
                               merge(data[data$Component.Name == "SA_PIP_aldehyde", ],
                                     data[data$Component.Name == "17:0-20:4_PI_aldehyde", ],
                                     by = "Sample.ID"))
                
                data1$ng <- as.numeric(data1$Area.x)/as.numeric(data1$Area.y)
                
                data1$PI.ng <- rep(data1[grep("PI_", data1$Component.Name.x), ]$ng, 4)
                data1$Golden.Ratio <- data1$ng/data1$PI.ng
                
                # import the sample information table in a text format. Please modify the sample
                # iformation file in advance so that it looks like (this is an example):
                
                # 1,100000,WT sictrl 1 a
                # 2,100000,WT sictrl 0 b
                # 3,100000,WT siINPP4A+B 1 a
                # 4,100000,WT siINPP4A+B 0 b
                # 5,100000,PTEN sictrl 1 a
                # 6,100000,PTEN sictrl 0 b
                # 7,100000,PTEN siship2 1 a
                # 8,100000,PTEN siship2 1 b
                
                # most importantly - the last column should have strings separated by " " --
                # this separation will create table columns with these strings.
                samples <- read.table(paste0("all-data/sample-lists/", f), sep = ",")
                samples.split <- t(as.data.frame(strsplit(samples[,3], " ")))[ , c(1, 2, 3, 4, 6)]
                samples <- as.data.frame(cbind(samples[, 1], samples.split))
                rownames(samples) <- NULL
                colnames(samples) <- c("Sample.ID", "Genotype", "Condition", "Antagonist", "Time", "Tech.Rep")
                # merge data and samples by Sample ID
                res <- merge(data1, samples, by = "Sample.ID")
                res$Time <- as.numeric(res$Time)
                # res <- res[,c(1, 2, 5:10)]
                res <- as.data.table(res)
                # save the new data table to a file
                saveRDS(res, paste0("all-data/processed/", strsplit(f, "\\.")[[1]][1], ".rds"))
        }
}

# analyse and plot tech replicates
tech_reps <- function() {
	files <- list.files("all-data/processed/")
  system("rm -r plot-tech-rep/*")
	for(f in files) {
    system(paste0("mkdir plot-tech-rep/", strsplit(f, "\\.")[[1]][1]))
    d <- readRDS(paste0("all-data/processed/", f))
    t <- d[,list(Mean.GR = mean(Golden.Ratio), sd.GR = sd(Golden.Ratio)), by = c("Component.Name.x", "Genotype", "Condition", "Antagonist", "Time")]
    saveRDS(t, paste0("all-data/tech-rep-av/", f))
    for(comp in unique(t$Component.Name)) {
  		p <- ggplot(t[Component.Name.x == comp], aes(x = Time, y = Mean.GR, color = Antagonist, group = Antagonist)) +
  			geom_point() +
        geom_line() +
  			facet_grid(Genotype ~ Condition) +
  		  geom_errorbar(aes(ymax = Mean.GR + sd.GR, ymin = Mean.GR - sd.GR), size = 0.5, width = 0.2) +
  			theme_bw()
  		ggsave(p, file = paste0("plot-tech-rep/", strsplit(f, "\\.")[[1]][1], "/", comp, ".pdf"), w = 6, h = 4)
    }
	}
}

get_bio_rep <- function(file.name, component) {
  rep <- readRDS(paste0("all-data/tech-rep-av/", file.name, ".rds"))
  if (component %in% unique(rep[,Component.Name.x])) {
    rep <- rep[Component.Name.x == component, list(Component.Name.x, Genotype, Condition, Antagonist, Time, Mean.GR)]
    rep[Antagonist == "dmso", Antagonist:="-"]
  } else {
    print(paste0("There is no ", component, " component in ", file.name, " file!!!"))
  }
}

clean_for_copasi <- function() {
  p3 <- read.csv("all-data/bio-rep-av/p3_4-uM.csv")
  p2 <- read.csv("all-data/bio-rep-av/pi34p2-uM.csv")
  
  p3 <- as.data.table(p3)
  p2 <- as.data.table(p2)
  
  p3 <- p3[ , list(Genotype, Condition, Antagonist, Time = Time*60 + 300, uM)]
  p2 <- p2[ , list(Genotype, Condition, Antagonist, Time = Time*60 + 300, uM)]
  
  setkeyv(p3, c("Genotype", "Condition", "Antagonist", "Time"))
  setkeyv(p2, c("Genotype", "Condition", "Antagonist", "Time"))
  
  dat <- p2[p3]
  
  setnames(dat, colnames(dat), c("Genotype", "Condition", "Antagonist", "Time", "pi34p2", "pip3"))
  
  dat[Genotype == "PTEN", pten_percentage := 0]
  dat[Genotype != "PTEN", pten_percentage := 1]
  
  dat[Condition == "siSHIP2", ship2_percentage := 0]
  dat[Condition != "siSHIP2", ship2_percentage := 1]
  
  dat[Condition == "siINPP4(A+B)", pi34p2_degradation_via_inpp4ab := 0]
  dat[Condition != "siINPP4(A+B)", pi34p2_degradation_via_inpp4ab := 1]
  
  dat[Condition == "siINPP4(A+B)&siSHIP2", ship2_percentage := 0]
  dat[Condition == "siINPP4(A+B)&siSHIP2", pi34p2_degradation_via_inpp4ab := 0]
  
  dat[Antagonist == "1uMPI-103", pi3k_act := 0]
  dat[Antagonist != "1uMPI-103", pi3k_act := 1]
  
  write.csv(dat[ , list(Time, pi34p2, pip3, pten_percentage, ship2_percentage,
                        pi34p2_degradation_via_inpp4ab, pi3k_act)],
            file = "copasi/experiment.csv", row.names = F, quote = F)
}

bio_reps <- function() {
        files <- list.files("all-data/tech-rep-av/")
        files1 <- files[grepl("B_c4_FULL", files)]
        files2 <- files[grepl("A_c18_FULL", files)]
        
        d1 <- NULL
        i <- 1
        for(f in files1) {
                tmp <- readRDS(paste0("all-data/tech-rep-av/", f))
                tmp$bio.rep <- i
                d1 <- rbind(d1, tmp)
                i <- i + 1
        }
        
        d2 <- NULL
        i <- 1
        for(f in files2) {
                tmp <- readRDS(paste0("all-data/tech-rep-av/", f))
                tmp$bio.rep <- i
                d2 <- rbind(d2, tmp)
                i <- i + 1
        }

        for(c in unique(d1$Component.Name)) {
                p <- ggplot(d1[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = as.factor(bio.rep))) +
                        geom_bar(position = "dodge", stat="identity") +
                        facet_grid(Genotype ~ Condition, scale="free") +
                        theme_bw()
                ggsave(p, file = paste0("plot-bio-rep/", c, ".pdf"), w = 8, h = 6)
        }
        
        for(c in unique(d2$Component.Name)) {
                p <- ggplot(d2[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = as.factor(bio.rep))) +
                        geom_bar(position = "dodge", stat="identity") +
                        facet_grid(Genotype ~ Condition, scale="free") +
                        theme_bw()
                ggsave(p, file = paste0("plot-bio-rep/", c, ".pdf"), w = 8, h = 6)
        }

        d1 <- d1[,list(Golden.Ratio.Av.Tech.by.ctrl = Golden.Ratio.Av.Tech/Golden.Ratio.Av.Tech[Time == 1 & grepl("ctrl", Condition)]*100, Condition, Time),
                by = c("Component.Name", "Genotype", "Antagonist", "bio.rep")]
        d2 <- d2[,list(Golden.Ratio.Av.Tech.by.ctrl = Golden.Ratio.Av.Tech/Golden.Ratio.Av.Tech[Time == 1 & grepl("ctrl", Condition)]*100, Condition, Time),
                  by = c("Component.Name", "Genotype", "Antagonist", "bio.rep")]
        
        for(c in unique(d1$Component.Name)) {
                p <- ggplot(d1[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech.by.ctrl, fill = as.factor(bio.rep))) +
                        geom_bar(position = "dodge", stat="identity") +
                        facet_grid(Genotype ~ Condition, scale="free") +
                        theme_bw()
                ggsave(p, file = paste0("plot-bio-rep/", c, "-norm.pdf"), w = 8, h = 6)
        }
        
        for(c in unique(d2$Component.Name)) {
                p <- ggplot(d2[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech.by.ctrl, fill = as.factor(bio.rep))) +
                        geom_bar(position = "dodge", stat="identity") +
                        facet_grid(Genotype ~ Condition, scale="free") +
                        theme_bw()
                ggsave(p, file = paste0("plot-bio-rep/", c, "-norm.pdf"), w = 8, h = 6)
        }
}


plot_species <- function() {
	d1 <- readRDS("../pip3/data-processed/2014_09_05B_c4_FULLn1.rds")
	d1$Bio.Rep <-"1"
	d2 <- readRDS("../pip3/data-processed/2014_09_19B_c4_FULLn2.rds")
	d2$Bio.Rep <- "2"

	d <- rbind(d1, d2)

	for(c in unique(d$Component.Name)) {
		p <- ggplot(d[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio, fill = Bio.Rep, color = Antagonist)) +
			geom_boxplot() +
			# geom_hline(yintercept = 1) +
			facet_grid(Genotype ~ Condition, scale="free") +
			theme_bw()
		ggsave(p, file = paste0("../pip3/pip3-plot-species/", c, ".pdf"), w = 8, h = 8)
	}



	d1 <- readRDS("../pip3/data-av-tech-rep/2014_09_05B_c4_FULLn1.rds")
	d1$Bio.Rep <- "1"
	d2 <- readRDS("../pip3/data-av-tech-rep/2014_09_19B_c4_FULLn2.rds")
	d2$Bio.Rep <- "2"
	d3 <- readRDS("../pip3/data-av-tech-rep/2014_11_12A_c4_cIIa&cIIb_FULLn1.rds")

	d <- rbind(d1, d2)

	d <- d[,list(Golden.Ratio.Av.Tech.by.ctrl = Golden.Ratio.Av.Tech/Golden.Ratio.Av.Tech[Time == 1 & grepl("ctrl", Condition)]*100, Condition, Time),
		by = c("Component.Name", "Genotype", "Antagonist", "Bio.Rep")]

	for(c in unique(d$Component.Name)) {
		p <- ggplot(d[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech.by.ctrl, fill = Bio.Rep, color = Antagonist)) +
			geom_bar(position = "dodge", stat="identity") +
			geom_hline(yintercept = 100) +
			facet_grid(Genotype ~ Condition, scale="free") +
			theme_bw()
		ggsave(p, file = paste0("../pip3/pip3-plot-species-norm/", c, ".pdf"), w = 8, h = 8)
	}
}

plot_species1 <- function(name) {
	files <- list.files(paste0("../", name, "/data-av-tech-rep/"))
	system(paste0("rm -r ../", name, "/", name, "-plot-species/*"))
	system(paste0("rm -r ../", name, "/", name, "-plot-species-norm/*"))
	for(f in files) {
		dir.create(paste0("../", name, "/", name, "-plot-species/", strsplit(f, "\\.")[[1]][1]))
		dir.create(paste0("../", name, "/", name, "-plot-species-norm/", strsplit(f, "\\.")[[1]][1]))
		d <- readRDS(paste0("../", name, "/data-av-tech-rep/", f))
		for(c in unique(d$Component.Name)) {
			p <- ggplot(d[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) +
				geom_bar(position = "dodge", stat="identity") +
				# geom_hline(yintercept = 1) +
				facet_grid(Genotype ~ Condition) +
				theme_bw()
			ggsave(p, file = paste0("../", name, "/", name, "-plot-species/", strsplit(f, "\\.")[[1]][1], "/", c, ".pdf"), w = 8, h = 8)
		}
		# d <- d[,list(Golden.Ratio.Av.Tech.by.ctrl = Golden.Ratio.Av.Tech/Golden.Ratio.Av.Tech[Time == 1 & grepl("ctrl", Condition)]*100, Condition, Time),
		# 	by = c("Component.Name", "Genotype", "Antagonist")]
		# for(c in unique(d$Component.Name)) {
		# 	p <- ggplot(d[Component.Name == c], aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech.by.ctrl, fill = Antagonist)) +
		# 		geom_bar(position = "dodge", stat="identity") +
		# 		geom_hline(yintercept = 100) +
		# 		facet_grid(Genotype ~ Condition) +
		# 		theme_bw()
		# 	ggsave(p, file = paste0("../", name, "/", name, "-plot-species-norm/", strsplit(f, "\\.")[[1]][1], "/", c, ".pdf"), w = 8, h = 8)
		# }
	}
}

process_data_inhibitors <- function(name) {
	f <- "2014_12_12A_c4_wt_ab_pten_tc.csv"

	print(f)
	# import the raw data table in a text format. Here it is delimited by "," --
	# can be change if the text file format is different
	data <- read.csv(paste0("../inhibitors/data-raw/", f))
	# leave only columns that are of interest. Here "Sample.ID", "Component.Name"
	# and "Area" columns are left
	data <- data[ , c(3, 7, 11)]
	data$ISD <- 0
	data[grep("P3_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "ISD_PIP3", ]$Area, 5)
	data[grep("P2_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "d7_SA_P2", ]$Area, 5)
	data[grep("PI_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "ISD_PI", ]$Area, 5)
	data[grep("PIP_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "ISD_PI", ]$Area, 5)
	data <- data[data$ISD != 0, ]
	data$ng <- data$Area/data$ISD

	data$Golden.Ratio <- 0
	data[grep("P3_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data[grep("P2_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data[grep("PI_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data[grep("PIP_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data$Golden.Ratio <- data$ng/data$Golden.Ratio
	# import the sample information table in a text format. Please modify the sample
	# iformation file in advance so that it looks like (this is an example):

	# 1,100000,WT sictrl 1 a
	# 2,100000,WT sictrl 0 b
	# 3,100000,WT siINPP4A+B 1 a
	# 4,100000,WT siINPP4A+B 0 b
	# 5,100000,PTEN sictrl 1 a
	# 6,100000,PTEN sictrl 0 b
	# 7,100000,PTEN siship2 1 a
	# 8,100000,PTEN siship2 1 b

	# most importantly - the last column should have strings separated by " " --
	# this separation will create table columns with these strings.
	samples <- read.table("../inhibitors/sample-lists/wt_ab_pten_tc.csv", sep = ",")
	samples.split <- t(as.data.frame(strsplit(samples[,3], " ")))[ , c(1, 2, 3, 4, 6)]
	samples <- as.data.frame(cbind(samples[, 1], samples.split))
	rownames(samples) <- NULL
	colnames(samples) <- c("Sample.ID", "Genotype", "Condition", "Antagonist", "Time", "Tech.Rep")
	# merge data and samples by Sample ID
	res <- merge(data, samples, by = "Sample.ID")
	res$Time <- as.numeric(res$Time)
	res <- res[,c(1, 2, 5:11)]
	res <- as.data.table(res)
	# save the new data table to a file
	saveRDS(res, paste0("../inhibitors/data-processed/", strsplit(f, "\\.")[[1]][1], ".rds"))

	f <- "2014_12_12B_c18_wt_ab_pten_tc.csv"

	print(f)
	# import the raw data table in a text format. Here it is delimited by "," --
	# can be change if the text file format is different
	data <- read.csv(paste0("../inhibitors/data-raw/", f))
	# leave only columns that are of interest. Here "Sample.ID", "Component.Name"
	# and "Area" columns are left
	data <- data[ , c(3, 7, 11)]
	data$ISD <- 0
	data[data$Component.Name == "SA_P2_aldehyde_45", ]$ISD <- rep(data[data$Component.Name == "d6_SA_P2_aldehyde_45", ]$Area, 1)
	data[data$Component.Name == "SA_P2_aldehyde_34", ]$ISD <- rep(data[data$Component.Name == "d6_SA_P2_aldehyde_34", ]$Area, 1)
	data[data$Component.Name == "SA_PI_aldehyde", ]$ISD <- rep(data[data$Component.Name == "17:0-20:4_PI_aldehyde", ]$Area, 1)
	data[data$Component.Name == "SA_PIP_aldehyde", ]$ISD <- rep(data[data$Component.Name == "17:0-20:4_PI_aldehyde", ]$Area, 1)
	data <- data[data$ISD != 0, ]
	data$ng <- data$Area/data$ISD

	data$Golden.Ratio <- 0
	data[data$Component.Name == "SA_P2_aldehyde_45", ]$Golden.Ratio <- data[data$Component.Name == "SA_PI_aldehyde", ]$ng
	data[data$Component.Name == "SA_P2_aldehyde_34", ]$Golden.Ratio <- data[data$Component.Name == "SA_PI_aldehyde", ]$ng
	data[data$Component.Name == "SA_PI_aldehyde", ]$Golden.Ratio <- data[data$Component.Name == "SA_PI_aldehyde", ]$ng
	data[data$Component.Name == "SA_PIP_aldehyde", ]$Golden.Ratio <- data[data$Component.Name == "SA_PI_aldehyde", ]$ng
	data$Golden.Ratio <- data$ng/data$Golden.Ratio
	# import the sample information table in a text format. Please modify the sample
	# iformation file in advance so that it looks like (this is an example):

	# 1,100000,WT sictrl 1 a
	# 2,100000,WT sictrl 0 b
	# 3,100000,WT siINPP4A+B 1 a
	# 4,100000,WT siINPP4A+B 0 b
	# 5,100000,PTEN sictrl 1 a
	# 6,100000,PTEN sictrl 0 b
	# 7,100000,PTEN siship2 1 a
	# 8,100000,PTEN siship2 1 b

	# most importantly - the last column should have strings separated by " " --
	# this separation will create table columns with these strings.
	samples <- read.table("../inhibitors/sample-lists/wt_ab_pten_tc.csv", sep = ",")
	samples.split <- t(as.data.frame(strsplit(samples[,3], " ")))[ , c(1, 2, 3, 4, 6)]
	samples <- as.data.frame(cbind(samples[, 1], samples.split))
	rownames(samples) <- NULL
	colnames(samples) <- c("Sample.ID", "Genotype", "Condition", "Antagonist", "Time", "Tech.Rep")
	# merge data and samples by Sample ID
	res <- merge(data, samples, by = "Sample.ID")
	res$Time <- as.numeric(res$Time)
	res <- res[,c(1, 2, 5:11)]
	res <- as.data.table(res)
	# save the new data table to a file
	saveRDS(res, paste0("../inhibitors/data-processed/", strsplit(f, "\\.")[[1]][1], ".rds"))

	f <- "2014_12_18A_full.csv"

	print(f)
	# import the raw data table in a text format. Here it is delimited by "," --
	# can be change if the text file format is different
	data <- read.csv(paste0("../inhibitors/data-raw/", f))
	# leave only columns that are of interest. Here "Sample.ID", "Component.Name"
	# and "Area" columns are left
	data <- data[ , c(3, 7, 11)]
	data$ISD <- 0
	data[grep("P3_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "ISD_PIP3", ]$Area, 5)
	data[grep("P2_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "d7_SA_P2", ]$Area, 5)
	data[grep("PI_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "ISD_PI", ]$Area, 5)
	data[grep("PIP_", data$Component.Name), ]$ISD <- rep(data[data$Component.Name == "ISD_PI", ]$Area, 5)
	data <- data[data$ISD != 0, ]
	data$ng <- data$Area/data$ISD

	data$Golden.Ratio <- 0
	data[grep("P3_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data[grep("P2_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data[grep("PI_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data[grep("PIP_", data$Component.Name), ]$Golden.Ratio <- data[grep("PI_", data$Component.Name), ]$ng
	data$Golden.Ratio <- data$ng/data$Golden.Ratio
	# import the sample information table in a text format. Please modify the sample
	# iformation file in advance so that it looks like (this is an example):

	# 1,100000,WT sictrl 1 a
	# 2,100000,WT sictrl 0 b
	# 3,100000,WT siINPP4A+B 1 a
	# 4,100000,WT siINPP4A+B 0 b
	# 5,100000,PTEN sictrl 1 a
	# 6,100000,PTEN sictrl 0 b
	# 7,100000,PTEN siship2 1 a
	# 8,100000,PTEN siship2 1 b

	# most importantly - the last column should have strings separated by " " --
	# this separation will create table columns with these strings.
	samples <- read.table("../inhibitors/sample-lists/2014_12_18A_full.csv", sep = ",")
	samples.split <- t(as.data.frame(strsplit(samples[,3], " ")))[ , c(1, 2, 3, 4, 6)]
	samples <- as.data.frame(cbind(samples[, 1], samples.split))
	rownames(samples) <- NULL
	colnames(samples) <- c("Sample.ID", "Genotype", "Condition", "Antagonist", "Time", "Tech.Rep")
	# merge data and samples by Sample ID
	res <- merge(data, samples, by = "Sample.ID")
	res$Time <- as.numeric(res$Time)
	res <- res[,c(1, 2, 5:10)]
	res <- as.data.table(res)
	# save the new data table to a file
	saveRDS(res, paste0("../inhibitors/data-processed/", strsplit(f, "\\.")[[1]][1], ".rds"))
}

plot_species_inhibitors <- function() {
	d1 <- readRDS("../inhibitors/data-av-tech-rep/2014_12_12A_c4_wt_ab_pten_tc.rds")
	# d1$Bio.Rep <-"1"
	d2 <- readRDS("../inhibitors/data-av-tech-rep/2014_12_12B_c18_wt_ab_pten_tc.rds")
	# d2$Bio.Rep <- "2"
	d3 <- readRDS("../inhibitors/data-av-tech-rep/2014_12_18A_full.rds")

	d <- rbind(d1, d3)
	for(c in unique(d$Component.Name)) {
		p <- ggplot(d[Component.Name == c], aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) +
			geom_point() +
			geom_line() +
			# geom_hline(yintercept = 100) +
			facet_grid(Genotype ~ Condition) +
			theme_bw()
		ggsave(p, file = paste0("../inhibitors/inhibitors-plot-species/", c, ".pdf"), w = 15, h = 7)
	}
	d <- d2
	for(c in unique(d$Component.Name)) {
		p <- ggplot(d[Component.Name == c], aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) +
			geom_point() +
			geom_line() +
			# geom_hline(yintercept = 100) +
			facet_grid(Genotype ~ Condition) +
			theme_bw()
		ggsave(p, file = paste0("../inhibitors/inhibitors-plot-species/", c, ".pdf"), w = 12, h = 7)
	}
}



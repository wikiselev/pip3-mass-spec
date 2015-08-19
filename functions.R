library(data.table)
library(pracma)
library(ggplot2)

options(stringsAsFactors = FALSE, digits = 15)

process_data <- function() {
  files <- list.files("all-data/raw/")
  files <- files[grepl("*.csv", files)]
  files1 <- files[grepl("_c4_", files)]
  files2 <- files[grepl("_c18_", files)]
  
  for (f in files1) {
    print(f)
    # import the raw data table in a text format. Here it is delimited by ',' -- can be change if the text
    # file format is different
    data <- read.csv(paste0("all-data/raw/", f))
    # leave only columns that are of interest. Here 'Sample.ID', 'Component.Name' and 'Area' columns are left
    data <- data[, colnames(data) %in% c("Sample.ID", "Component.Name", "Area")]
    # there is one experiment with some weird values here I get rid of them - checked with Anna
    # 2015_03_06A_c4_pi34p2Trans_n3
    data <- data[data$Sample.ID != "blank", ]
    if (dim(data[data$Area == "N/A", ])[1] != 0) {
      data[data$Area == "N/A", ]$Area <- 0
    }
    
    data1 <- data.frame()
    
    data1 <- rbind(data1, merge(data[grep("P3_", data$Component.Name), ], data[data$Component.Name == 
                                                                                 "ISD_PIP3", ], by = "Sample.ID"))
    data1 <- rbind(data1, merge(data[grep("P2_", data$Component.Name), ], data[data$Component.Name == 
                                                                                 "d7_SA_P2", ], by = "Sample.ID"))
    data1 <- rbind(data1, merge(data[grep("PI_", data$Component.Name), ], data[data$Component.Name == 
                                                                                 "ISD_PI", ], by = "Sample.ID"))
    data1 <- rbind(data1, merge(data[grep("PIP_", data$Component.Name), ], data[data$Component.Name == 
                                                                                  "ISD_PI", ], by = "Sample.ID"))
    
    data1$ng <- as.numeric(data1$Area.x)/as.numeric(data1$Area.y)
    
    data1$PI.ng <- rep(data1[grep("PI_", data1$Component.Name.x), ]$ng, 4)
    data1$Golden.Ratio <- data1$ng/data1$PI.ng
    
    # import the sample information table in a text format. Please modify the sample iformation file in
    # advance so that it looks like (this is an example):
    
    # 1,100000,WT sictrl 1 a 2,100000,WT sictrl 0 b 3,100000,WT siINPP4A+B 1 a 4,100000,WT siINPP4A+B 0 b
    # 5,100000,PTEN sictrl 1 a 6,100000,PTEN sictrl 0 b 7,100000,PTEN siship2 1 a 8,100000,PTEN siship2 1 b
    
    # most importantly - the last column should have strings separated by ' ' -- this separation will create
    # table columns with these strings.
    samples <- read.table(paste0("all-data/sample-lists/", f), sep = ",")
    samples.split <- t(as.data.frame(strsplit(samples[, 3], " ")))[, c(1, 2, 3, 4, 6)]
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
  
  for (f in files2) {
    print(f)
    # import the raw data table in a text format. Here it is delimited by ',' -- can be change if the text
    # file format is different
    data <- read.csv(paste0("all-data/raw/", f))
    # leave only columns that are of interest. Here 'Sample.ID', 'Component.Name' and 'Area' columns are left
    data <- data[, colnames(data) %in% c("Sample.ID", "Component.Name", "Area")]
    # there is one experiment with some weird values here I get rid of them - checked with Anna
    data <- data[data$Sample.ID != "blank", ]
    if (dim(data[data$Area == "N/A", ])[1] != 0) {
      data[data$Area == "N/A", ]$Area <- 0
    }
    
    data1 <- data.frame()
    
    data1 <- rbind(data1, merge(data[data$Component.Name == "SA_P2_aldehyde_45", ], data[data$Component.Name == 
                                                                                           "d6_SA_P2_aldehyde_45", ], by = "Sample.ID"))
    data1 <- rbind(data1, merge(data[data$Component.Name == "SA_P2_aldehyde_34", ], data[data$Component.Name == 
                                                                                           "d6_SA_P2_aldehyde_34", ], by = "Sample.ID"))
    data1 <- rbind(data1, merge(data[data$Component.Name == "SA_PI_aldehyde", ], data[data$Component.Name == 
                                                                                        "17:0-20:4_PI_aldehyde", ], by = "Sample.ID"))
    data1 <- rbind(data1, merge(data[data$Component.Name == "SA_PIP_aldehyde", ], data[data$Component.Name == 
                                                                                         "17:0-20:4_PI_aldehyde", ], by = "Sample.ID"))
    
    data1$ng <- as.numeric(data1$Area.x)/as.numeric(data1$Area.y)
    
    data1$PI.ng <- rep(data1[grep("PI_", data1$Component.Name.x), ]$ng, 4)
    data1$Golden.Ratio <- data1$ng/data1$PI.ng
    
    # import the sample information table in a text format. Please modify the sample iformation file in
    # advance so that it looks like (this is an example):
    
    # 1,100000,WT sictrl 1 a 2,100000,WT sictrl 0 b 3,100000,WT siINPP4A+B 1 a 4,100000,WT siINPP4A+B 0 b
    # 5,100000,PTEN sictrl 1 a 6,100000,PTEN sictrl 0 b 7,100000,PTEN siship2 1 a 8,100000,PTEN siship2 1 b
    
    # most importantly - the last column should have strings separated by ' ' -- this separation will create
    # table columns with these strings.
    samples <- read.table(paste0("all-data/sample-lists/", f), sep = ",")
    samples.split <- t(as.data.frame(strsplit(samples[, 3], " ")))[, c(1, 2, 3, 4, 6)]
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
  for (f in files) {
    system(paste0("mkdir plot-tech-rep/", strsplit(f, "\\.")[[1]][1]))
    d <- readRDS(paste0("all-data/processed/", f))
    t <- d[, list(Mean.GR = mean(Golden.Ratio), sd.GR = sd(Golden.Ratio)), by = c("Component.Name.x", 
                                                                                  "Genotype", "Condition", "Antagonist", "Time")]
    saveRDS(t, paste0("all-data/tech-rep-av/", f))
    for (comp in unique(t$Component.Name)) {
      p <- ggplot(t[Component.Name.x == comp], aes(x = Time, y = Mean.GR, color = Antagonist, group = Antagonist)) + 
        geom_point() + geom_line() + facet_grid(Genotype ~ Condition) + geom_errorbar(aes(ymax = Mean.GR + 
                                                                                            sd.GR, ymin = Mean.GR - sd.GR), size = 0.5, width = 0.2) + theme_bw()
      ggsave(p, file = paste0("plot-tech-rep/", strsplit(f, "\\.")[[1]][1], "/", comp, ".pdf"), w = 6, 
             h = 4)
    }
  }
}

get_bio_rep <- function(file.name, component) {
  rep <- readRDS(paste0("all-data/tech-rep-av/", file.name, ".rds"))
  if (component %in% unique(rep[, Component.Name.x])) {
    rep <- rep[Component.Name.x == component, list(Component.Name.x, Genotype, Condition, Antagonist, 
                                                   Time, Mean.GR)]
    rep[Antagonist == "dmso", `:=`(Antagonist, "-")]
  } else {
    print(paste0("There is no ", component, " component in ", file.name, " file!!!"))
  }
}

clean_for_copasi <- function() {
  p3 <- read.csv("all-data/bio-rep-av/p3_4-uM.csv")
  p2 <- read.csv("all-data/bio-rep-av/pi34p2-uM.csv")
  
  p3 <- as.data.table(p3)
  p2 <- as.data.table(p2)
  
  p3 <- p3[, list(Genotype, Condition, Antagonist, Time = Time * 60 + 300, uM)]
  p2 <- p2[, list(Genotype, Condition, Antagonist, Time = Time * 60 + 300, uM)]
  
  setkeyv(p3, c("Genotype", "Condition", "Antagonist", "Time"))
  setkeyv(p2, c("Genotype", "Condition", "Antagonist", "Time"))
  
  dat <- p2[p3]
  
  setnames(dat, colnames(dat), c("Genotype", "Condition", "Antagonist", "Time", "pi34p2", "pip3"))
  
  #     > unique(dat[,Genotype])
  #     [1] "PTEN"        "PTEN-INPP4B" "PTEN-SHIP2"  "WT"         
  dat[grepl("PTEN", Genotype), `:=`(pten_percentage, 0)]
  dat[!grepl("PTEN", Genotype), `:=`(pten_percentage, 1)]
  
  dat[grepl("INPP4B", Genotype), `:=`(inpp4b_percentage_crisp, 0)]
  dat[!grepl("INPP4B", Genotype), `:=`(inpp4b_percentage_crisp, 1)]
  
  dat[grepl("SHIP2", Genotype), `:=`(ship2_percentage_crisp, 0)]
  dat[!grepl("SHIP2", Genotype), `:=`(ship2_percentage_crisp, 1)]
  
  #     > unique(dat[,Condition])
  #     [1] "siINPP4(A+B)"         "siINPP4(A+B)&siSHIP2" "siSHIP2"             
  #     [4] "sictrl"               "siINPP4A"            
  dat[Condition == "siSHIP2", `:=`(ship2_percentage, 0)]
  dat[Condition != "siSHIP2", `:=`(ship2_percentage, 1)]
  
  dat[Condition == "siINPP4A", `:=`(inpp4a_percentage, 0)]
  dat[Condition != "siINPP4A", `:=`(inpp4a_percentage, 1)]
  
  dat[Condition == "siINPP4(A+B)", `:=`(pi34p2_degradation_via_inpp4ab, 0)]
  dat[Condition != "siINPP4(A+B)", `:=`(pi34p2_degradation_via_inpp4ab, 1)]
  
  dat[Condition == "siINPP4(A+B)&siSHIP2", `:=`(ship2_percentage, 0)]
  dat[Condition == "siINPP4(A+B)&siSHIP2", `:=`(pi34p2_degradation_via_inpp4ab, 0)]
  
  dat[Antagonist == "1uMPI-103", `:=`(pi3k_act, 0)]
  dat[Antagonist != "1uMPI-103", `:=`(pi3k_act, 1)]
  
  write.csv(dat[, list(Genotype, Condition, Antagonist, Time, pi34p2, pip3, pten_percentage, inpp4b_percentage_crisp, ship2_percentage_crisp, ship2_percentage, inpp4a_percentage, pi34p2_degradation_via_inpp4ab, 
                       pi3k_act)], file = "experiment.csv", row.names = F, quote = F)
}

regr <- function(d, point.num, cond) {
  model = lm(log(d$pip3[1:point.num]) ~ d$Time[1:point.num])
  cat(paste0("Condition: ", cond))
  cat("\n")
  cat(capture.output(summary(model)))
  cat("\n\n")
  return(data.table(Time = d$Time[1:point.num], pip3 = exp(predict(model, list(Time = d$Time[1:point.num]))), 
                    Condition = cond))
}

inhibitor_regressions <- function() {
  d <- as.data.table(read.csv("experiment.csv"))
  
  sink("inhibitor-regressions.txt")
  
  d1 <- d[Genotype == "PTEN" & Condition == "sictrl" & Antagonist == "1uMPI-103"]
  d1$Condition <- "PTEN"
  t1 <- regr(d1, 4, "PTEN")
  d2 <- d[Genotype == "WT" & Condition == "siSHIP2" & Antagonist == "1uMPI-103"]
  d2$Condition <- "SHIP2"
  t2 <- regr(d2, 3, "SHIP2")
  d3 <- d[Genotype == "PTEN" & Condition == "siSHIP2" & Antagonist == "1uMPI-103"]
  d3$Condition <- "PTEN&SHIP2"
  t3 <- regr(d3, 7, "PTEN&SHIP2")
  
  sink()
  
  d.tot <- rbind(d1, d2)
  d.tot <- rbind(d.tot, d3)
  d.tot <- d.tot[, list(Time, pip3, Condition)]
  t.tot <- rbind(t1, t2)
  t.tot <- rbind(t.tot, t3)
  
  p <- ggplot(d.tot, aes(x = Time, y = pip3)) +
    geom_point(aes(color = Condition)) +
    geom_line(data = t.tot, aes(group = Condition)) + 
    theme_bw() +
    labs(x = "Time, s", y = "PIP3, uM")
  ggsave(p, file = "inhibitor-regressions.pdf", w = 6, h = 4) 
}
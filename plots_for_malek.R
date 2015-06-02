library(ggplot2)
library(data.table)

get_data_f3 <- function(f) {
    d <- readRDS(paste0("../pip3/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.036718508
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "P3_4"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

get_data_f2 <- function(f) {
    d <- readRDS(paste0("../pip3/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.016267146
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "P2_4"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

get_data_f34 <- function(f) {
    d <- readRDS(paste0("../pip2/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.033106953
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "SA_P2_aldehyde_34"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

get_data_f45 <- function(f) {
    d <- readRDS(paste0("../pip2/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.1328752
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "SA_P2_aldehyde_45"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

get_data_inhibitors_f3 <- function(f) {
    d <- readRDS(paste0("../inhibitors/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.036718508
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "P3_4"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

get_data_inhibitors_f2 <- function(f) {
    d <- readRDS(paste0("../inhibitors/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.016267146
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "P2_4"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

get_data_inhibitors_f34 <- function(f) {
    d <- readRDS(paste0("../inhibitors/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.033106953
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "SA_P2_aldehyde_34"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

get_data_inhibitors_f45 <- function(f) {
    d <- readRDS(paste0("../inhibitors/data-processed/", f))
    # convert to nmols - see Malek's email (he made a mistake - it should be nmol)
    d$Golden.Ratio <- d$Golden.Ratio * 0.1328752
    d <- d[, list(Golden.Ratio.Av.Tech = mean(Golden.Ratio), Golden.Ratio.SD.Tech = sd(Golden.Ratio)), by = c("Component.Name", 
        "Genotype", "Condition", "Antagonist", "Time")]
    d <- d[Component.Name == "SA_P2_aldehyde_45"]
    # convert to pmols
    d$Golden.Ratio.Av.Tech <- d$Golden.Ratio.Av.Tech * 1000
    d$Golden.Ratio.SD.Tech <- d$Golden.Ratio.SD.Tech * 1000
    
    d$ymax <- d$Golden.Ratio.Av.Tech + d$Golden.Ratio.SD.Tech
    d$ymin <- d$Golden.Ratio.Av.Tech - d$Golden.Ratio.SD.Tech
    return(d)
}

###### PIP3, PIP2
files <- list.files("../pip3/data-processed/")
# files <- files[!grepl('FULLn2', files)]
limits <- aes(ymax = ymax, ymin = ymin)

f <- files[1]
d <- get_data_f3(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)
d <- get_data_f2(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)

f <- files[2]
d <- get_data_f3(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)
d <- get_data_f2(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)

f <- files[3]
d <- get_data_f3(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f2(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[4]
d <- get_data_f3(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f2(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[5]
d <- get_data_f3(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "10nMPI-103", "30nMPI-103", "100nMPI-103", "300nMPI-103", 
    "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f2(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "10nMPI-103", "30nMPI-103", "100nMPI-103", "300nMPI-103", 
    "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[6]
d <- get_data_f3(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "10nMPI-103", "30nMPI-103", "100nMPI-103", "300nMPI-103", 
    "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f2(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "10nMPI-103", "30nMPI-103", "100nMPI-103", "300nMPI-103", 
    "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[7]
d <- get_data_f3(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siCIIa", "siCIIb", "siINPP4(A+B)", "siINPP4(A+B)&siCIIa", 
    "siINPP4(A+B)&siCIIb"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)
d <- get_data_f2(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siCIIa", "siCIIb", "siINPP4(A+B)", "siINPP4(A+B)&siCIIa", 
    "siINPP4(A+B)&siCIIb"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)

f <- files[8]
d <- get_data_f3(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "IC50PIKTGX", "IC50x10PIKTGX", "IC50x100PIKTGX", 
    "IC50x1000PIKTGX"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f2(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "IC50PIKTGX", "IC50x10PIKTGX", "IC50x100PIKTGX", 
    "IC50x1000PIKTGX"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

###### PI34P2, PI45P2
files <- list.files("../pip2/data-processed/")
# files <- files[!grepl('FULLn2', files)]
limits <- aes(ymax = ymax, ymin = ymin)

f <- files[1]
d <- get_data_f34(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siINPP4(A+B)", "siSHIP2"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)
d <- get_data_f45(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siSHIP2", "siINPP4(A+B)"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)

f <- files[2]
d <- get_data_f34(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siINPP4(A+B)", "siSHIP2"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)
d <- get_data_f45(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siSHIP2", "siINPP4(A+B)"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)

f <- files[3]
d <- get_data_f34(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f45(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[4]
d <- get_data_f34(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f45(f)
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[5]
d <- get_data_f34(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "10nMPI-103", "30nMPI-103", "100nMPI-103", "300nMPI-103", 
    "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f45(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "10nMPI-103", "30nMPI-103", "100nMPI-103", "300nMPI-103", 
    "1uMPI-103"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[6]
d <- get_data_f34(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siCIIa", "siCIIb", "siINPP4(A+B)", "siINPP4(A+B)&siCIIa", 
    "siINPP4(A+B)&siCIIb"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)
d <- get_data_f45(f)
d$Condition <- factor(d$Condition, levels <- c("sictrl", "siCIIa", "siCIIb", "siINPP4(A+B)", "siINPP4(A+B)&siCIIa", 
    "siINPP4(A+B)&siCIIb"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Condition)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    .) + labs(x = "Time, min", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 8)

f <- files[7]
d <- get_data_f34(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "IC50PIKTGX", "IC50x10PIKTGX", "IC50x100PIKTGX", 
    "IC50x1000PIKTGX"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_f45(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "IC50PIKTGX", "IC50x10PIKTGX", "IC50x100PIKTGX", 
    "IC50x1000PIKTGX"))
p <- ggplot(d, aes(x = as.factor(Time), y = Golden.Ratio.Av.Tech, fill = Antagonist)) + geom_bar(position = "dodge", 
    stat = "identity") + geom_errorbar(limits, width = 0.25, position = position_dodge(0.9)) + facet_grid(Genotype ~ 
    Condition, scale = "free") + labs(x = "Time, min", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

###### INHIBITORS
files <- list.files("../inhibitors/data-processed/")
limits <- aes(ymax = ymax, ymin = ymin)

f <- files[1]
d <- get_data_inhibitors_f3(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) + geom_point() + 
    geom_line() + facet_grid(Genotype ~ Condition) + labs(x = "Time, s", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3_inhibitors/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_inhibitors_f2(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) + geom_point() + 
    geom_line() + facet_grid(Genotype ~ Condition) + labs(x = "Time, s", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2_inhibitors/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[2]
d <- get_data_inhibitors_f34(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) + geom_point() + 
    geom_line() + facet_grid(Genotype ~ Condition) + labs(x = "Time, s", y = "PI(3,4)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi34p2_inhibitors/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_inhibitors_f45(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) + geom_point() + 
    geom_line() + facet_grid(Genotype ~ Condition) + labs(x = "Time, s", y = "PI(4,5)P2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pi45p2_inhibitors/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)

f <- files[3]
d <- get_data_inhibitors_f3(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) + geom_point() + 
    geom_line() + facet_grid(Genotype ~ Condition) + labs(x = "Time, s", y = "PIP3, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip3_inhibitors/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4)
d <- get_data_inhibitors_f2(f)
d$Antagonist <- factor(d$Antagonist, levels <- c("dmso", "1uMPI-103"))
p <- ggplot(d, aes(x = Time, y = Golden.Ratio.Av.Tech, color = Antagonist, group = Antagonist)) + geom_point() + 
    geom_line() + facet_grid(Genotype ~ Condition) + labs(x = "Time, s", y = "PIP2, pmol") + theme_bw()
ggsave(p, file = paste0("../plots/pip2_inhibitors/", strsplit(f, "\\.")[[1]][1], ".pdf"), w = 8, h = 4) 

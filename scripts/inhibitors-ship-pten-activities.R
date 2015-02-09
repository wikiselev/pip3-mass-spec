library(data.table)
library(ggplot2)
# to find area under curve
library(pracma)

d <- as.data.table(read.csv("../copasi/all-data-uM.csv"))

d1 <- d[Component.Name == "SA_P2_aldehyde_34" & Antagonist == "-" &
	file != "2014_11_12B_c18_cIIa&cIIb_FULL"]

d2 <- d[Component.Name == "P3_4" & Antagonist == "-" &
	file != "2014_11_12A_c4_cIIa&cIIb_FULLn1"]
d.tot <- rbind(d1, d2)
d.tot[Genotype == "PTEN"]$Condition <- paste0(d.tot[Genotype == "PTEN"]$Genotype, "&", d.tot[Genotype == "PTEN"]$Condition)
d.tot[Condition == "PTEN&sictrl"]$Condition <- "PTEN"
p <- ggplot(d.tot, aes(Time, uM, group = Condition)) +
	geom_point(aes(shape = file)) +
	geom_line(aes(group = file)) +
	facet_grid(Component.Name ~ Condition, scale = "free") +
	theme_bw() +
	labs(x = "Time, s", y = "PIP3, uM")
ggsave(p, file = "../copasi/inhibitor-activities-all.pdf", w = 20, h = 5)

d3 <- d.tot[grepl("INPP", Condition)]
d3 <- d3[Condition != "PTEN&siINPP4(A+B)&siSHIP2"]

d3.S <- data.table()
for(t in c(0,1,5,15)) {
	tmp <- d3[Component.Name == "P3_4" & (Time %in% 0:t),
		list(S=trapz(Time,uM)*60*0.0138), by = c("file", "Condition")]
	tmp$Time <- t
	tmp$Component.Name <- "SA_P2_aldehyde_34"
	d3.S <- rbind(d3.S, tmp)
}

d3.initial <- d3[Component.Name == "SA_P2_aldehyde_34" & Time == 0, list(file, Condition, uM, Time, Component.Name)]
d3.S <- d3.S[,list(Condition,file,Component.Name,uM=S+d3.initial$uM), by = "Time"]
d3.S$cond <- "theory"

d3 <- d3[,list(Time,Condition,file,Component.Name,uM)]
d3$cond <- "experiment"

p <- ggplot(rbind(d3,d3.S), aes(Time, uM, group = Condition, color = cond)) +
	geom_point(aes(shape = file)) +
	geom_line(aes(group = file)) +
	facet_grid(Component.Name ~ Condition, scale = "free") +
	theme_bw() +
	labs(x = "Time, s", y = "PIP3, uM")
ggsave(p, file = "../copasi/inhibitor-activities-INPP4AB1.pdf", w = 9, h = 5)

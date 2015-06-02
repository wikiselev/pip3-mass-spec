library(data.table)
library(ggplot2)

regr <- function(d, point.num, cond) {
    model = lm(log(d$uM[1:point.num]) ~ d$Time[1:point.num])
    print(summary(model))
    return(data.table(Time = d$Time[1:point.num], uM = exp(predict(model, list(Time = d$Time[1:point.num]))), 
        Condition = cond))
}

d <- as.data.table(read.csv("../copasi/all-data-uM.csv"))

d1 <- d[Genotype == "PTEN" & Condition == "sictrl" & Antagonist == "1uMPI-103" & Component.Name == "P3_4" & 
    file == "2014_12_18A_full"]
d1$Condition <- "PTEN"
t1 <- regr(d1, 5, "PTEN")
d2 <- d[Genotype == "WT" & Condition == "siSHIP2" & Antagonist == "1uMPI-103" & Component.Name == "P3_4" & 
    file == "2014_12_18A_full"]
d2$Condition <- "SHIP2"
t2 <- regr(d2, 3, "SHIP2")
d3 <- d[Genotype == "PTEN" & Condition == "siSHIP2" & Antagonist == "1uMPI-103" & Component.Name == "P3_4" & 
    file == "2014_12_18A_full"]
d3$Condition <- "PTEN&SHIP2"
t3 <- regr(d3, 7, "PTEN&SHIP2")

d.tot <- rbind(d1, d2)
d.tot <- rbind(d.tot, d3)
d.tot <- d.tot[, list(Time, uM, Condition)]
t.tot <- rbind(t1, t2)
t.tot <- rbind(t.tot, t3)

p <- ggplot(d.tot, aes(Time, uM)) + geom_point(aes(color = Condition)) + geom_line(data = t.tot, aes(group = Condition)) + 
    theme_bw() + labs(x = "Time, s", y = "PIP3, uM")
ggsave(p, file = "../copasi/inhibitor-regressions.pdf") 

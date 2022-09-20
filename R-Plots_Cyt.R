## libraries used

library(ggplot2)
library(cowplot)
library(cowplot)
library(tidyr)
library(gtable)
library(grid)
library(gridExtra)
library(ggpubr)
library(tidyverse)
library(dplyr)
library(writexl)
library(readxl)

####### Cytosol BS #######


## load the data
setwd("..")
Cytosol_Final <- read_excel("Cytosol_Final.xlsx")

Cytosol_Final2 <- mutate(Cytosol_Final, Time = (Metadata_Time_formatted * 5) - 120)

Cytosol_Final2$Sample <- as.factor(Cytosol_Final2$Sample)
levels(Cytosol_Final2$Sample)

Cytosol <- select(Cytosol_Final2, -Metadata_Well, -variable)
Cytosol2 <- rename(Cytosol, Timepoint=Metadata_Time_formatted, R=value, Compartment=Plate, "Time (min)"=Time)

HighGlucose <- filter(Cytosol2, Sample == "LCIS+HighGlucose+DMSO" | Sample == "LCIS+HighGlucose+G6PDi[10uM]" | Sample == "LCIS+HighGlucose+G6PDi[50uM]")


#### LCIS + High Glucose + G6PDi 

HighGlucose2 <- HighGlucose %>% filter(`Time (min)`>= -60)
write_xlsx(HighGlucose2, "Cytosol_HighGlucose1.xlsx")

Cytosol_HighGlucose <- ggline(HighGlucose2, x = "Time (min)", y = "R", add = "mean_se", plot_type = "p", 
                                  color = "Sample",
                                  shape=19,
                                  point.size = 0.01)+
  xlab("Time (min)")+
  ylab("R")+
  scale_color_manual("Sample", values = c("LCIS+HighGlucose+DMSO" = "darkgoldenrod1", "LCIS+HighGlucose+G6PDi[10uM]" = "deepskyblue1", "LCIS+HighGlucose+G6PDi[50uM]" = "deeppink1")) +
  scale_y_continuous(breaks = seq(0.2, 0.7, 0.1)) +
  scale_x_discrete(breaks = seq(-60, 240, 60)) +
  ggtitle ("Cytosol - LCIS + High Glucose + G6PDi - 2021-08-29") +
  theme(axis.text.x=element_text(size=10, color = "black"),
        axis.text.y=element_text(size=10, color = "black"),
        axis.title=element_text(size=11,face="bold"),
        strip.text = element_text(size = 11),
        legend.text = element_text(color = "black", size = 10),
        legend.title = element_blank(),
        legend.position = c(0.3,0.9))
Cytosol_HighGlucose
Cytosol_HighGlucose1 <- Cytosol_HighGlucose + coord_cartesian(ylim = c(0.2, 0.5))
Cytosol_HighGlucose1

ggsave("Cytosol_HighGlucose1.jpg", Cytosol_HighGlucose1, width = 8, height = 7)
ggsave("Cytosol_HighGlucose1.pdf", Cytosol_HighGlucose1, width=8, height=7, units="cm", scale=2)
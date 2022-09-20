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

####### Mito BS #######


## load the data
setwd("")

Mito_Final <- read_excel("Mito_Final.xlsx")

Mito_Final2 <- mutate(Mito_Final, Time = (Metadata_Time_formatted * 5) - 120)

Mito_Final2$Sample <- as.factor(Mito_Final2$Sample)
levels(Mito_Final2$Sample)

Mito <- select(Mito_Final2, -Metadata_Well, -variable)
Mito2 <- rename(Mito, Timepoint=Metadata_Time_formatted, R=value, Compartment=Plate, "Time (min)"=Time)

LCIS <- filter(Mito2,Sample == "LCIS+DMSO" | Sample == "LCIS+G6PDi[0uM]")
HighGlucose <- filter(Mito2, Sample == "LCIS+HighGlucose+DMSO" | Sample == "LCIS+HighGlucose+G6PDi[10uM]" | Sample == "LCIS+HighGlucose+G6PDi[50uM]")


#### DMSO control 

DMSOcontrol <- LCIS %>% filter(`Time (min)`>= -60)
write_xlsx(DMSOcontrol, "DMSOcontrol_Mito.xlsx")

Mito_DMSOcontrol <- ggline(DMSOcontrol, x = "Time (min)", y = "R", add = "mean_se", plot_type = "p", 
                              color = "Sample",
                              shape=19,
                              point.size = 0.01)+
  xlab("Time (min)")+
  ylab("R")+
  scale_color_manual("Sample", values = c("LCIS+G6PDi[0uM]" = "green", "LCIS+DMSO" = "darkgoldenrod1")) +
  scale_y_continuous(breaks = seq(0.2, 0.7, 0.1)) +
  scale_x_discrete(breaks = seq(-60, 240, 60)) +
  ggtitle ("Mitochondria DMSO control") +
  theme(axis.text.x=element_text(size=10, color = "black"),
        axis.text.y=element_text(size=10, color = "black"),
        axis.title=element_text(size=11,face="bold"),
        strip.text = element_text(size = 11),
        legend.text = element_text(color = "black", size = 10),
        legend.title = element_blank(),
        legend.position = c(0.3,0.9))
Mito_DMSOcontrol
Mito_DMSOcontrol1 <- Mito_DMSOcontrol + coord_cartesian(ylim = c(0.2, 0.6))
Mito_DMSOcontrol1
ggsave("Mito_DMSOcontrol4.jpg", Mito_DMSOcontrol1, width = 6, height = 4)
ggsave("Mito_DMSOcontrol7.pdf",Mito_DMSOcontrol1, width=5, height=3.5, units="cm", scale=3)


#### High Glucose. G6PDi 

HighGlucose2 <- HighGlucose %>% filter(`Time (min)`>= -60)
write_xlsx(HighGlucose2, "Mito_HighGlucose1.xlsx")

Mito_HighGlucose <- ggline(HighGlucose2, x = "Time (min)", y = "R", add = "mean_se", plot_type = "p", 
                              color = "Sample",
                              shape=19,
                              point.size = 0.01)+
  xlab("Time (min)")+
  ylab("R")+
  scale_color_manual("Sample", values = c("LCIS+HighGlucose+DMSO" = "darkgoldenrod1", "LCIS+HighGlucose+G6PDi[10uM]" = "deepskyblue1", "LCIS+HighGlucose+G6PDi[50uM]" = "deeppink1")) +
  scale_y_continuous(breaks = seq(0.2, 0.7, 0.1)) +
  scale_x_discrete(breaks = seq(-60, 240, 60)) +
  ggtitle ("Mito - LCIS + High Glucose + G6PDi - 2021-08-29") +
  theme(axis.text.x=element_text(size=10, color = "black"),
        axis.text.y=element_text(size=10, color = "black"),
        axis.title=element_text(size=11,face="bold"),
        strip.text = element_text(size = 11),
        legend.text = element_text(color = "black", size = 10),
        legend.title = element_blank(),
        legend.position = c(0.3,0.9))
Mito_HighGlucose
Mito_HighGlucose1 <- Mito_HighGlucose + coord_cartesian(ylim = c(0.2, 0.5))
Mito_HighGlucose1

ggsave("Mito_HighGlucose1.jpg", Mito_HighGlucose1, width = 8, height = 7)
ggsave("Mito_HighGlucose1.pdf", Mito_HighGlucose1, width=8, height=7, units="cm", scale=2)

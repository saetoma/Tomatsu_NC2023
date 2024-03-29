library(ggplot2)
library(readxl)

# change path as your system
setwd('F:/Nature Comm/data_code/SourceData_ST2023') 

Rvolley_data <- read_excel("SourceData_ST2023_SFig2B.xlsx")

data <- data.frame(
  value <- Rvolley_data$value,
  epoch <- factor(Rvolley_data$epoch, levels = c("move","hold")),
  dir <- factor(Rvolley_data$direction, levels=c("ext","flx")),
  epdir <- factor(paste(Rvolley_data$epoch,Rvolley_data$direction),levels=c("move ext","hold ext","move flx","hold flx"))
)

ggplot(data,aes(epdir,value))+
  geom_boxplot()+
  geom_jitter(aes(epdir,value,colour=dir),width=0.1)+
  scale_color_manual(values=c(4,2))

library(ggplot2)
library(readxl)

# change path as your system
setwd('F:/Nature Comm/data_code/SourceData_ST2023') 

behavior_comp <- read_excel("SourceData_ST2023_SFig4BCEF.xlsx")
data<-behavior_comp

EMG_smallADV <- data[1:77,4:23]
avEMG_small <- colMeans(EMG_smallADV)
EMG_largeADV <- data[78:154,4:23]
avEMG_large <- colMeans(EMG_largeADV)

avEMG <- rbind(avEMG_large,avEMG_small)

avEMG_DelayF <- avEMG[,1:10]
avEMG_AHF <- avEMG[,11:20]


# Static task epoch, Extension
p1<-ggplot(data,aes(x=ADVlevel, y=sucrate_DelayF))+
  geom_boxplot()
p2<-ggplot(data,aes(x=ADVlevel, y=sucrate_AHF))+
  geom_boxplot()

df <- data.frame(
    ADV     = c(rep("large",10),rep("small",10)),
    muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
    value = c(avEMG_DelayF[1,],avEMG_DelayF[2,])
  )
p3<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(avEMG_AHF[1,],avEMG_AHF[2,])
)
p4<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))

library(patchwork)
(p1|p3)/(p2|p4)

  
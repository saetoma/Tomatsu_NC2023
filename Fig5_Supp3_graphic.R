library(ggplot2)
library(readxl)

# change path as your system
setwd('F:/Nature Comm/data_code/SourceData_ST2023') 

behavior_comp <- read_excel("SourceData_ST2023_Fig5DEFG_SFig3.xlsx")
data<-behavior_comp

EMG_smallADV <- data[1:77,32:71]
avEMG_small <- colMeans(EMG_smallADV)
EMG_largeADV <- data[78:154,32:71]
avEMG_large <- colMeans(EMG_largeADV)

sdEMG_smallADV <- data[1:77,72:111]
sdEMG_small <- colMeans(sdEMG_smallADV)
sdEMG_largeADV <- data[78:154,72:111]
sdEMG_large <- colMeans(sdEMG_largeADV)

avEMG <- rbind(avEMG_large,avEMG_small)
sdEMG <- rbind(sdEMG_large,sdEMG_small)

avEMG_emgE <- avEMG[,1:10]
avEMG_emgF <- avEMG[,11:20]
avEMG_CueAHE <- avEMG[,21:30]
avEMG_CueAHF <- avEMG[,31:40]

sdEMG_emgE <- sdEMG[,1:10]
sdEMG_emgF <- sdEMG[,11:20]
sdEMG_CueAHE <- sdEMG[,21:30]
sdEMG_CueAHF <- sdEMG[,31:40]

# Static task epoch, Extension
p1<-ggplot(data,aes(x=ADVlevel, y=RT_CueAHE))+
  geom_boxplot()
p2<-ggplot(data,aes(x=ADVlevel, y=meanTQ_CueAHE))+
  geom_boxplot()
p3<-ggplot(data,aes(x=ADVlevel, y=sdTQ_CueAHE))+
  geom_boxplot()
p4<-ggplot(data,aes(x=ADVlevel, y=PderTQ_CueAHE))+
  geom_boxplot()
p5<-ggplot(data,aes(x=ADVlevel, y=LatencyPderTQ_CueAHE))+
  geom_boxplot()
p6<-ggplot(data,aes(x=ADVlevel, y=P2derTQ_CueAHE))+
  geom_boxplot()
p7<-ggplot(data,aes(x=ADVlevel, y=LatencyP2derTQ_CueAHE))+
  geom_boxplot()
df <- data.frame(
    ADV     = c(rep("large",10),rep("small",10)),
    muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
    value = c(avEMG_CueAHE[1,],avEMG_CueAHE[2,])
  )
p8<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(sdEMG_CueAHE[1,],sdEMG_CueAHE[2,])
)
p9<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
p10<-ggplot(data,aes(x=ADVlevel, y=sucrate_CueAHE))+
  geom_boxplot()

# Static task epoch, Flexion
p11<-ggplot(data,aes(x=ADVlevel, y=RT_CueAHF))+
  geom_boxplot()
p12<-ggplot(data,aes(x=ADVlevel, y=meanTQ_CueAHF))+
  geom_boxplot()
p13<-ggplot(data,aes(x=ADVlevel, y=sdTQ_CueAHF))+
  geom_boxplot()
p14<-ggplot(data,aes(x=ADVlevel, y=PderTQ_CueAHF))+
  geom_boxplot()
p15<-ggplot(data,aes(x=ADVlevel, y=LatencyPderTQ_CueAHF))+
  geom_boxplot()
p16<-ggplot(data,aes(x=ADVlevel, y=P2derTQ_CueAHF))+
  geom_boxplot()
p17<-ggplot(data,aes(x=ADVlevel, y=LatencyP2derTQ_CueAHF))+
  geom_boxplot()
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(avEMG_CueAHF[1,],avEMG_CueAHF[2,])
)
p18<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(sdEMG_CueAHF[1,],sdEMG_CueAHF[2,])
)
p19<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
p20<-ggplot(data,aes(x=ADVlevel, y=sucrate_CueAHF))+
  geom_boxplot()

# dynamic task epoch, Extension
p22<-ggplot(data,aes(x=ADVlevel, y=meanTQ_emgE))+
  geom_boxplot()
p23<-ggplot(data,aes(x=ADVlevel, y=sdTQ_emgE))+
  geom_boxplot()
p24<-ggplot(data,aes(x=ADVlevel, y=PderTQ_emgE))+
  geom_boxplot()
p25<-ggplot(data,aes(x=ADVlevel, y=LatencyPderTQ_emgE))+
  geom_boxplot()
p26<-ggplot(data,aes(x=ADVlevel, y=P2derTQ_emgE))+
  geom_boxplot()
p27<-ggplot(data,aes(x=ADVlevel, y=LatencyP2derTQ_emgE))+
  geom_boxplot()
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(avEMG_emgE[1,],avEMG_emgE[2,])
)
p28<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(sdEMG_emgE[1,],sdEMG_emgE[2,])
)
p29<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
p30<-ggplot(data,aes(x=ADVlevel, y=sucrate_emgE))+
  geom_boxplot()

# dynamic task epoch, Flexion
p32<-ggplot(data,aes(x=ADVlevel, y=meanTQ_emgF))+
  geom_boxplot()
p33<-ggplot(data,aes(x=ADVlevel, y=sdTQ_emgF))+
  geom_boxplot()
p34<-ggplot(data,aes(x=ADVlevel, y=PderTQ_emgF))+
  geom_boxplot()
p35<-ggplot(data,aes(x=ADVlevel, y=LatencyPderTQ_emgF))+
  geom_boxplot()
p36<-ggplot(data,aes(x=ADVlevel, y=P2derTQ_emgF))+
  geom_boxplot()
p37<-ggplot(data,aes(x=ADVlevel, y=LatencyP2derTQ_emgF))+
  geom_boxplot()
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(avEMG_emgF[1,],avEMG_emgF[2,])
)
p38<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
df <- data.frame(
  ADV     = c(rep("large",10),rep("small",10)),
  muscle  = c(rep(c("ECU","ED45","EDC","ECR","APL","ED23","BRD","FCR","PL","FDS"),2)),
  value = c(sdEMG_emgF[1,],sdEMG_emgF[2,])
)
p39<-ggplot(df,aes(x=ADV, y=value,color=muscle))+geom_line(aes(group = muscle))
p40<-ggplot(data,aes(x=ADVlevel, y=sucrate_emgF))+
  geom_boxplot()

library(patchwork)
(p1|p2|p3|p4|p5|p6|p7|p8|p9|p10)/
  (p11|p12|p13|p14|p15|p16|p17|p18|p19|p20)/
  (plot_spacer()|p22|p23|p24|p25|p26|p27|p28|p29|p30)/
  (plot_spacer()|p32|p33|p34|p35|p36|p37|p38|p39|p40)

  
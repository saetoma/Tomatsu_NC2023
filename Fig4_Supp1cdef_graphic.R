# Fig 4 and Supp Fig.1cdef

library(ggplot2)
library(readxl)
# change path as your system
setwd('F:/Nature Comm/data_code/SourceData_ST2023') 
#
Zarea_EMGon   <- read_excel("SourceData_ST2023_Fig4A_SFig1C.xlsx")
Zarea_Movon   <- read_excel("SourceData_ST2023_Fig4B_SFig1D.xlsx")
Zarea_EMGoff  <- read_excel("SourceData_ST2023_Fig4C_SFig1E.xlsx")
Zarea_Reton   <- read_excel("SourceData_ST2023_Fig4D_SFig1F.xlsx")

val <- as.matrix(Zarea_EMGon[,3:24])
All1 <- data.frame(
  value = colMeans(val),
  cint_p  = colMeans(val)+qnorm(0.975)*apply(val,2,sd)/sqrt(77),
  cint_m  = colMeans(val)-qnorm(0.975)*apply(val,2,sd)/sqrt(77),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),2),
  dir = factor(c(rep("ext",11),rep("flex",11)),levels=c("ext","flex"))
)

val_Y <- val[1:39,1:11]
val_O <- val[40:77,1:11]
Ind1e <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,1:11])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,1:11])+qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(77)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,1:11])-qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(77)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)

val_Y <- val[1:39,12:22]
val_O <- val[40:77,12:22]
Ind1f <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,12:22])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,12:22])+qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(77)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,12:22])-qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(77)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)

val <- as.matrix(Zarea_Movon[,3:24])
All2 <- data.frame(
  value = colMeans(val),
  cint_p  = colMeans(val)+qnorm(0.975)*apply(val,2,sd)/sqrt(77),
  cint_m  = colMeans(val)-qnorm(0.975)*apply(val,2,sd)/sqrt(77),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),2),
  dir = factor(c(rep("ext",11),rep("flex",11)),levels=c("ext","flex"))
)

val_Y <- val[1:39,1:11]
val_O <- val[40:77,1:11]
Ind2e <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,1:11])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,1:11])+qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(77)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,1:11])-qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(77)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)

val_Y <- val[1:39,12:22]
val_O <- val[40:77,12:22]
Ind2f <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,12:22])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,12:22])+qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(77)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,12:22])-qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(77)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)

val <- as.matrix(Zarea_EMGoff[,3:24])
All3 <- data.frame(
  value = colMeans(val),
  cint_p  = colMeans(val)+qnorm(0.975)*apply(val,2,sd)/sqrt(76),
  cint_m  = colMeans(val)-qnorm(0.975)*apply(val,2,sd)/sqrt(76),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),2),
  dir = factor(c(rep("ext",11),rep("flex",11)),levels=c("ext","flex"))
)

val_Y <- val[1:39,1:11]
val_O <- val[40:76,1:11]
Ind3e <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,1:11])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(37),colMeans(val[,1:11])+qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(76)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(37),colMeans(val[,1:11])-qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(76)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)

val_Y <- val[1:39,12:22]
val_O <- val[40:76,12:22]
Ind3f <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,12:22])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(37),colMeans(val[,12:22])+qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(76)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(37),colMeans(val[,12:22])-qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(76)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)

val <- as.matrix(Zarea_Reton[,3:24])
All4 <- data.frame(
  value = colMeans(val),
  cint_p  = colMeans(val)+qnorm(0.975)*apply(val,2,sd)/sqrt(77),
  cint_m  = colMeans(val)-qnorm(0.975)*apply(val,2,sd)/sqrt(77),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),2),
  dir = factor(c(rep("ext",11),rep("flex",11)),levels=c("ext","flex"))
)

val_Y <- val[1:39,1:11]
val_O <- val[40:77,1:11]
Ind4e <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,1:11])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,1:11])+qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(77)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,1:11])-qnorm(0.975)*apply(val[,1:11],2,sd)/sqrt(77)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)

val_Y <- val[1:39,12:22]
val_O <- val[40:77,12:22]
Ind4f <- data.frame(
  value = c(colMeans(val_Y),colMeans(val_O),colMeans(val[,12:22])),
  cint_p  = c(colMeans(val_Y)+qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)+qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,12:22])+qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(77)),
  cint_m  = c(colMeans(val_Y)-qnorm(0.975)*apply(val_Y,2,sd)/sqrt(39),colMeans(val_O)-qnorm(0.975)*apply(val_O,2,sd)/sqrt(38),colMeans(val[,12:22])-qnorm(0.975)*apply(val[,12:22],2,sd)/sqrt(77)),
  time = rep(c(-500,-400,-300,-200,-100,0,100,200,300,400,500),3),
  subj = factor(c(rep("Y",11),rep("O",11),rep("All",11)),levels=c("Y","O","All"))
)


p1 = ggplot(All1,aes(x=time, y=value, color=dir))+
  geom_point(size=3)+
  geom_line(linewidth=1)+ggtitle("EMG onset")+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c(4,2))+
  theme(axis.title.x = element_blank())

p1e = ggplot(Ind1e,aes(x=time, y=value, color=subj))+
    geom_point(size=1.5)+
    geom_line()+ggtitle("Extension")+
    geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
    scale_color_manual(values=c("blue","cyan","gray"))+
  theme(axis.title.x = element_blank())
  
p1f = ggplot(Ind1f,aes(x=time, y=value, color=subj))+
  geom_point(size=1.5)+
  geom_line()+ggtitle("Flexion")+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c("red","yellow","gray"))+
  theme(axis.title.x = element_blank())

p2 = ggplot(All2,aes(x=time, y=value, color=dir))+
  geom_point(size=3)+
  geom_line(linewidth=1)+ggtitle("Movement onset")+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c(4,2))+
  theme(axis.title.x = element_blank())

p2e = ggplot(Ind2e,aes(x=time, y=value, color=subj))+
  geom_point(size=1.5)+
  geom_line()+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c("blue","cyan","gray"))+
  theme(axis.title.x = element_blank())

p2f = ggplot(Ind2f,aes(x=time, y=value, color=subj))+
  geom_point(size=1.5)+
  geom_line()+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c("red","yellow","gray"))+
  theme(axis.title.x = element_blank())

p3 = ggplot(All3,aes(x=time, y=value, color=dir))+
  geom_point(size=3)+
  geom_line(linewidth=1)+ggtitle("EMG offset")+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c(4,2))+
  theme(axis.title.x = element_blank())

p3e = ggplot(Ind3e,aes(x=time, y=value, color=subj))+
  geom_point(size=1.5)+
  geom_line()+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c("blue","cyan","gray"))+
  theme(axis.title.x = element_blank())

p3f = ggplot(Ind3f,aes(x=time, y=value, color=subj))+
  geom_point(size=1.5)+
  geom_line()+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c("red","yellow","gray"))+
  theme(axis.title.x = element_blank())

p4 = ggplot(All4,aes(x=time, y=value, color=dir))+
  geom_point(size=3)+
  geom_line(linewidth=1)+ggtitle("Return onset")+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c(4,2))+
  theme(axis.title.x = element_blank())

p4e = ggplot(Ind4e,aes(x=time, y=value, color=subj))+
  geom_point(size=1.5)+
  geom_line()+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c("blue","cyan","gray"))+
  theme(axis.title.x = element_blank())

p4f = ggplot(Ind4f,aes(x=time, y=value, color=subj))+
  geom_point(size=1.5)+
  geom_line()+
  geom_errorbar(aes(ymin=cint_m,ymax=cint_p))+
  scale_color_manual(values=c("red","yellow","gray"))+
  theme(axis.title.x = element_blank())

library(patchwork)
(p1|p1e|p1f)/(p2|p2e|p2f)/(p3|p3e|p3f)/(p4|p4e|p4f)

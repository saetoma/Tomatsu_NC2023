## make Fig 2c

library(ggplot2)
library(readxl)
Zarea4epoch <- read_excel("Datafile.xlsx",sheet = "ADVsize_EpochAverage")
Zarea <- c(Zarea4epoch$DelayE,Zarea4epoch$DelayF,Zarea4epoch$AME,Zarea4epoch$AMF,Zarea4epoch$AHE,Zarea4epoch$AHF,Zarea4epoch$PME,Zarea4epoch$PMF)
tag <- c(rep(1,77),rep(5,77),rep(2,77),rep(6,77),rep(3,77),rep(7,77),rep(4,77),rep(8,77))
data <- data.frame(tag,Zarea)

library(ggdist)
p1 = ggplot(data,aes(x=tag,y=Zarea,color=as.factor(tag)))+
  stat_halfeye(point_color=NA,.width=0,width=0.6,position=position_nudge(x=0.3))+
  geom_point(position=position_jitter(width=0.1,height=0,seed=1))+
  geom_boxplot(position=position_nudge(x=0.2),width=0.1, outlier.shape = NA)+
  scale_color_manual(values=c(4,4,4,4,2,2,2,2))+
  theme(axis.title.x = element_blank())

## make Fig 2d
csdata <- c(cumsum(sort(Zarea4epoch$DelayE)),cumsum(sort(Zarea4epoch$AME)),
            cumsum(sort(Zarea4epoch$AHE)),cumsum(sort(Zarea4epoch$PME)),
            cumsum(sort(Zarea4epoch$DelayF)),cumsum(sort(Zarea4epoch$AMF)),
            cumsum(sort(Zarea4epoch$AHF)),cumsum(sort(Zarea4epoch$PMF)))
df <- data.frame(
  cond  = c(rep(1,77),rep(2,77),rep(3,77),rep(4,77),rep(5,77),rep(6,77),rep(7,77),rep(8,77)),
  dnum  = rep(c(1:77),8),
  value = csdata
)

p2 = ggplot(df,aes(x=dnum, y=csdata,linetype = as.factor(cond),color = as.factor(cond)))+
  geom_line()+
  scale_linetype_manual(values=c("dashed","solid","dotdash","longdash","dashed","solid","dotdash","longdash"))+
  scale_color_manual(values=c(4,4,4,4,2,2,2,2))

# make Fig 3a
library(fastICA)
res <- fastICA(matrix(Zarea,nrow=154),4)
ICs <- res$A
WTs <- res$S
for(i in 1:4){
  if (ICs[i,which.max(abs(ICs[i,]))]<0){
    ICs[i,] <- -1*ICs[i,]
    WTs[,i] <- -1*WTs[,i]
  }
}

x1 <- data.frame(epoch=factor(c("Delay","AM","AH","PM"),levels=c("Delay","AM","AH","PM")),IC = ICs[1,])
x2 <- data.frame(epoch=factor(c("Delay","AM","AH","PM"),levels=c("Delay","AM","AH","PM")),IC = ICs[2,])
x3 <- data.frame(epoch=factor(c("Delay","AM","AH","PM"),levels=c("Delay","AM","AH","PM")),IC = ICs[3,])
x4 <- data.frame(epoch=factor(c("Delay","AM","AH","PM"),levels=c("Delay","AM","AH","PM")),IC = ICs[4,])
p3 = ggplot(x1,aes(x=epoch,y=IC))+geom_bar(stat="identity")+ggtitle("IC1")+theme(axis.title.x = element_blank())
p4 = ggplot(x2,aes(x=epoch,y=IC))+geom_bar(stat="identity")+ggtitle("IC2")+theme(axis.title.x = element_blank())
p5 = ggplot(x3,aes(x=epoch,y=IC))+geom_bar(stat="identity")+ggtitle("IC3")+theme(axis.title.x = element_blank())
p6 = ggplot(x4,aes(x=epoch,y=IC))+geom_bar(stat="identity")+ggtitle("IC4")+theme(axis.title.x = element_blank())

x1 <- data.frame(dir=factor(c("Ext","Flex"),levels=c("Ext","Flex")),WT = c(median(WTs[1:77,1]),median(WTs[78:154,1])))
x2 <- data.frame(dir=factor(c("Ext","Flex"),levels=c("Ext","Flex")),WT = c(median(WTs[1:77,2]),median(WTs[78:154,2])))
x3 <- data.frame(dir=factor(c("Ext","Flex"),levels=c("Ext","Flex")),WT = c(median(WTs[1:77,3]),median(WTs[78:154,3])))
x4 <- data.frame(dir=factor(c("Ext","Flex"),levels=c("Ext","Flex")),WT = c(median(WTs[1:77,4]),median(WTs[78:154,4])))
p7 = ggplot(x1,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank())
p8 = ggplot(x2,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank())
p9 = ggplot(x3,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank())
p10 = ggplot(x4,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank())


#Supp Fig 1ab
A_ext <- c(mean(Zarea4epoch$DelayE),mean(Zarea4epoch$AME),mean(Zarea4epoch$AHE),mean(Zarea4epoch$PME)) 
A_extSE <- c(sd(Zarea4epoch$DelayE),sd(Zarea4epoch$AME),sd(Zarea4epoch$AHE),sd(Zarea4epoch$PME))/sqrt(77) 
A_flex <- c(mean(Zarea4epoch$DelayF),mean(Zarea4epoch$AMF),mean(Zarea4epoch$AHF),mean(Zarea4epoch$PMF)) 
A_flexSE <- c(sd(Zarea4epoch$DelayF),sd(Zarea4epoch$AMF),sd(Zarea4epoch$AHF),sd(Zarea4epoch$PMF))/sqrt(77)  

Y_ext <- c(mean(Zarea4epoch$DelayE[1:39]),mean(Zarea4epoch$AME[1:39]),mean(Zarea4epoch$AHE[1:39]),mean(Zarea4epoch$PME[1:39])) 
Y_extSE <- c(sd(Zarea4epoch$DelayE[1:39]),sd(Zarea4epoch$AME[1:39]),sd(Zarea4epoch$AHE[1:39]),sd(Zarea4epoch$PME[1:39]))/sqrt(39)  
Y_flex <- c(mean(Zarea4epoch$DelayF[1:39]),mean(Zarea4epoch$AMF[1:39]),mean(Zarea4epoch$AHF[1:39]),mean(Zarea4epoch$PMF[1:39])) 
Y_flexSE <- c(sd(Zarea4epoch$DelayF[1:39]),sd(Zarea4epoch$AMF[1:39]),sd(Zarea4epoch$AHF[1:39]),sd(Zarea4epoch$PMF[1:39]))/sqrt(39) 

O_ext <- c(mean(Zarea4epoch$DelayE[40:77]),mean(Zarea4epoch$AME[40:77]),mean(Zarea4epoch$AHE[40:77]),mean(Zarea4epoch$PME[40:77])) 
O_extSE <- c(sd(Zarea4epoch$DelayE[40:77]),sd(Zarea4epoch$AME[40:77]),sd(Zarea4epoch$AHE[40:77]),sd(Zarea4epoch$PME[40:77]))/sqrt(38) 
O_flex <- c(mean(Zarea4epoch$DelayF[40:77]),mean(Zarea4epoch$AMF[40:77]),mean(Zarea4epoch$AHF[40:77]),mean(Zarea4epoch$PMF[40:77])) 
O_flexSE <- c(sd(Zarea4epoch$DelayF[40:77]),sd(Zarea4epoch$AMF[40:77]),sd(Zarea4epoch$AHF[40:77]),sd(Zarea4epoch$PMF[40:77]))/sqrt(38) 

epoch <- c(rep(c("Delay","AM","AH","PM"),3))
x1 <- data.frame(epoch=factor(epoch,levels=c("Delay","AM","AH","PM")),mv=c(Y_ext,O_ext,A_ext),sdv=c(Y_extSE,O_extSE,A_extSE),subj=factor(c(rep("Y",4),rep("O",4),rep("All",4)),levels=c("Y","O","All")))
p11 = ggplot(x1,aes(x=epoch,y=mv,fill=subj))+
  geom_bar(position=position_dodge(),stat="identity")+
  geom_errorbar(aes(ymax=mv+sdv,ymin=mv-sdv),position=position_dodge(0.9),width=0.25)+
  scale_fill_manual(values=c("blue","cyan","gray"))+
  theme(axis.title.x = element_blank())+ggtitle("Extension")

x2 <- data.frame(epoch=factor(epoch,levels=c("Delay","AM","AH","PM")),mv=c(Y_flex,O_flex,A_flex),sdv=c(Y_flexSE,O_flexSE,A_flexSE),subj=factor(c(rep("Y",4),rep("O",4),rep("All",4)),levels=c("Y","O","All")))
p12 = ggplot(x2,aes(x=epoch,y=mv,fill=subj))+
  geom_bar(position=position_dodge(),stat="identity")+
  geom_errorbar(aes(ymax=mv+sdv,ymin=mv-sdv),position=position_dodge(0.9),width=0.25)+
  scale_fill_manual(values=c("red","yellow","gray"))+
  theme(axis.title.x = element_blank())+ggtitle("Flexion")

library(patchwork)
(p1|p2)/{{(p3/p4/p5/p6)|(p7/p8/p9/p10)}|(p11/p12)}

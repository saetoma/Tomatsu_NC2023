## make Fig 2c, 3ab, and Suppl Fig1ab

library(ggplot2)
library(readxl)

# change path as your system
setwd('F:/Nature Comm/data_code/SourceData_ST2023') 

Zarea4epoch <- read_excel("SourceData_ST2023_Fig2CD_Fig3AB_SFig1AB.xlsx")
Zarea <- c(Zarea4epoch$DelayE,Zarea4epoch$DelayF,Zarea4epoch$AME,Zarea4epoch$AMF,Zarea4epoch$AHE,Zarea4epoch$AHF,Zarea4epoch$PME,Zarea4epoch$PMF)
tag <- factor(c(rep("DelayE",77),rep("DelayF",77),rep("AME",77),rep("AMF",77),rep("AHE",77),rep("AHF",77),rep("PME",77),rep("PMF",77)),levels=c("DelayE","AME","AHE","PME","DelayF","AMF","AHF","PMF"))
data <- data.frame(tag,Zarea)

library(ggdist)
p1 = ggplot(data,aes(x=tag,y=Zarea,color=as.factor(tag)))+
  stat_halfeye(point_color=NA,.width=0,width=0.6,position=position_nudge(x=0.3))+
  geom_point(position=position_jitter(width=0.1,height=0,seed=1))+
  geom_boxplot(position=position_nudge(x=0.2),width=0.1, outlier.shape = NA)+
  scale_color_manual(values=c(4,4,4,4,2,2,2,2))+
  theme(axis.title.x = element_blank(),legend.position = "none")

## make Fig 2d
csdata <- c(cumsum(sort(Zarea4epoch$DelayE)),cumsum(sort(Zarea4epoch$AME)),
            cumsum(sort(Zarea4epoch$AHE)),cumsum(sort(Zarea4epoch$PME)),
            cumsum(sort(Zarea4epoch$DelayF)),cumsum(sort(Zarea4epoch$AMF)),
            cumsum(sort(Zarea4epoch$AHF)),cumsum(sort(Zarea4epoch$PMF)))
df <- data.frame(
  cond  = factor(c(rep("DelayE",77),rep("AME",77),rep("AHE",77),rep("PME",77),rep("DelayF",77),rep("AMF",77),rep("AHF",77),rep("PMF",77)),levels=c("DelayE","AME","AHE","PME","DelayF","AMF","AHF","PMF")),
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
p7 = ggplot(x1,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank(), legend.position = "none")
p8 = ggplot(x2,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank(), legend.position = "none")
p9 = ggplot(x3,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank(), legend.position = "none")
p10 = ggplot(x4,aes(x=dir,y=WT,fill=as.factor(dir)))+geom_bar(stat="identity")+scale_fill_manual(values=c(4,2))+theme(axis.title.x = element_blank(), legend.position = "none")


#Supp Fig 1ab
x1 <- rbind(Zarea4epoch,Zarea4epoch)
x1$Monkey[78:154] <- "All"
dfr <- data.frame(mon=factor(c(x1$Monkey,x1$Monkey,x1$Monkey,x1$Monkey),levels=c("Y","O","All"))
                  ,epoch=factor(c(rep("Delay",154),rep("AM",154),rep("AH",154),rep("PM",154)),levels=c("Delay","AM","AH","PM"))
                  ,val=c(x1$DelayE,x1$AME,x1$AHE,x1$PME))

p11<-ggplot(dfr,aes(x=mon,y=val,fill=mon))+
  geom_boxplot(outlier.shape=NA,lwd=0.5,color="gray")+
  scale_fill_manual(values=c("blue","cyan","white"))+
  geom_point(position=position_jitter(width=0.1),size=1,colour="black"
             ,shape=1)+facet_grid(.~epoch)+
  theme(axis.title.x = element_blank(), legend.position = "none")+
  ggtitle("Extension")+
  stat_summary(fun.y=mean, geom="point",shape=1,size=4,col="red")


dfr <- data.frame(mon=factor(c(x1$Monkey,x1$Monkey,x1$Monkey,x1$Monkey),levels=c("Y","O","All"))
                  ,epoch=factor(c(rep("Delay",154),rep("AM",154),rep("AH",154),rep("PM",154)),levels=c("Delay","AM","AH","PM"))
                  ,val=c(x1$DelayF,x1$AMF,x1$AHF,x1$PMF))

p12 = ggplot(dfr,aes(x=mon,y=val,fill=mon))+
  geom_boxplot(outlier.shape=NA,lwd=0.5,color="gray")+
  scale_fill_manual(values=c("red","yellow","white"))+
  geom_point(position=position_jitter(width=0.1),size=1,colour="black"
             ,shape=1)+facet_grid(.~epoch)+
  theme(axis.title.x = element_blank(), legend.position = "none")+
  ggtitle("Flexion")+
  stat_summary(fun.y=mean, geom="point",shape=1,size=4,col="cyan")

library(patchwork)
(p1|(p11/p12))/{{(p3/p4/p5/p6)|(p7/p8/p9/p10)}|p2}


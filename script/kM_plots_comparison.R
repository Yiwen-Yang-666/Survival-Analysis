library(survival)
time1=ytst[cur.y==1]
time2=ytst[cur.y==2]
status1=icenstst[cur.y==1]
status2=icenstst[cur.y==2]
fit1=survfit(Surv(time1, status1) ~ 1)
fit2=survfit(Surv(time2,status2) ~1)
plot(fit1,conf.int="none", col = 'blue', xlab =
       'Time (years)', ylab = 'Survival Probability')
lines(fit2,conf.int="none", col = 'red')
legend(40,1,c('Group 1 ', 'Group 2'), col = c('blue','red'), lty = 1)
legend(40,0.2,c('p=0.353'),lty = 0)
title(main='KM-Curves for Gene Lung Cancer Data')

#Hierarchical clustering log rank
x1=read.table("Gene_Lung_Cancer_trimmed.txt")
x=x1[1:4752,1:45]
x=t(x)
x=t(x)
y1=scan("time.txt")
y=y1[1:45]
icens1=scan("status.txt")
icens=icens1[1:45]
x_hi=t(x)
clusters <- hclust(dist(x_hi))
clusterCut <- cutree(clusters, 2)
library(pamr)
cur.trn <- pamr.train(list(x=x, y=clusterCut))
cur.cv <- pamr.cv(cur.trn, list(x=x, y=clusterCut))
xtst=read.table("Gene_Lung_Cancer_trimmed.txt")
xtst=xtst[1:4752,46:86]
ytst=scan("time.txt")
ytst=ytst[46:86]
icenstst=scan("status.txt")
icenstst=icenstst[46:86]
cur.y<- pamr.predict(cur.trn,xtst,threshold=cur.trn$threshold[18])
sdf=survdiff(Surv(ytst, icenstst)~cur.y)

#Median Cut Method
library(pamr)
library(survival)
#fit=survfit(Surv(y, icens) ~ 1)
#plot(fit)

cutoffs <- quantile(y[icens == 1], 0.5)
#which.y <-((y>=cutoffs)&(y<=45))
class= pamr.surv.to.class2(y,icens,cutoffs = cutoffs)$class
cur.trn <- pamr.train(list(x=x, y=class))
cur.cv <- pamr.cv(cur.trn, list(x=x, y=class))
cur.y<- pamr.predict(cur.trn,xtst,threshold=cur.trn$threshold[19])
sdf=survdiff(Surv(ytst, icenstst)~cur.y)
sdf

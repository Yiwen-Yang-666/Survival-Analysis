library(MetaPath)
x1=read.table("Gene_Lung_Cancer_trimmed.txt")
x=x1[1:4752,1:45]
x=t(x)
x=t(x)
y1=scan("time.txt")
y=y1[1:45]
icens1=scan("status.txt")
icens=icens1[1:45]
output=coxfunc(x1,y1,icens1)
cur.tt=output$tt
data=list(x=x,y=y,icens=icens)







a=pamr.cv.cox(data,abs(cur.tt))


xtst=read.table("Gene_Lung_Cancer_trimmed.txt")
xtst=xtst[1:4752,46:86]
ytst=scan("time.txt")
ytst=ytst[46:86]
icenstst=scan("status.txt")
icenstst=icenstst[46:86]
cur.y<- pamr.predict(a$model.trn,xtst,threshold=a$model.trn$threshold[24])
sdf=survdiff(Surv(ytst, icenstst)~cur.y)
cur.genes <- (cur.tt>a$th)
cox=coxph(Surv(ytst, icenstst)~t(xtst[cur.genes,]))
cox.zph(cox)

cur.y0 <- kmeans2(t(xtst[a$th,]), 2)$cluster

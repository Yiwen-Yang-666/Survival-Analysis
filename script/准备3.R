library(survcomp)
x=read.table("Gene_Lung_Cancer_trimmed.txt")
x=x[1:4752,1:68]
x=t(x)
y=scan("time.txt")
y=y[1:68]
icens=scan("status.txt")
icens=icens[1:68]

scores=mrmr.cindex(x,y,icens)
lower=quantile(abs(scores),.9)
cur.genes=abs(scores)>lower
b=table(cur.genes)
print(b[names(b)==TRUE])
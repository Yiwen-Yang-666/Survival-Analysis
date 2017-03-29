sim.pcm.cv <- pcm.cv(data,abs(cur.tt))
sim.x.pcm <- x[(abs(cur.tt)>sim.pcm.cv),]
sim.svd.pcm <- svd(sim.x.pcm)
sim.v.pcm <- t(xtst[(abs(cur.tt)>sim.pcm.cv),]) %*% sim.svd.pcm$u %*% diag(1/sim.svd.pcm$d)
sim.surv.tst=Surv(ytst,icenstst)
sim.pcm.cox1 <- coxph(sim.surv.tst~sim.v.pcm[,1])
 



sim.surv=Surv(y,icens)
sim.pcm.cox2<- coxph(sim.surv~sim.svd.pcm$v[,1])





####
library(pamr)
x12=t(sim.svd.pcm$v[,1:2])
x13=t(sim.v.pcm[,1:2])
cur.y <- kmeans2(t(x12), 2)$cluster
cur.trn <- pamr.train(list(x=x12, y=cur.y))
cur.cv <- pamr.cv(cur.trn, list(x=x12, y=cur.y))
cur.y<- pamr.predict(cur.trn,x13,threshold=cur.trn$threshold[1])
sdf=survdiff(Surv(ytst, icenstst)~cur.y)
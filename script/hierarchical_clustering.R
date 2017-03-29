x_hi=t(x1)
clusters <- hclust(dist(x_hi))
plot(clusters)
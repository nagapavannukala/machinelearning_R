simfun <- function(n1=25, n2=n1, mu1=5, mu2=mu1) {
  x1 <- rexp(n1, 1/mu1)
  x2 <- rexp(n2, 1/mu2)
  wilcox.test(x1,x2)$p.value
}

out <- replicate(10000, simfun(mu1=5,mu2=8))
hist(out)
abline(v=0.05,col='red')
mean(out <= 0.05)

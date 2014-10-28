X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|")
# bad news
apply(X[1,], 2, class) # all character

q = c("x")
for (i in 1:18) {
	q = c(q, class(X[1,i]) )
}
q[2:19] # all factor


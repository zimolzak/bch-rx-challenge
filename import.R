X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "numeric", "factor", "numeric", "integer", "factor", "integer", "Date", "character"))

q = c("x")
n = dim(X)[2]
for (i in 1:n) {
	q = c(q, class(X[1,i]) )
}
rbind(names(X), q[2:(n+1)])

#first two ones to look at are Quantity and Refills

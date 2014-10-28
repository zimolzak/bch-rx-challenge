X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "character", "factor", "numeric", "character", "factor", "integer", "Date", "character"))

# Takes around 90 sec on my laptop.
# Quantity and Refills seem to be unused.
# The only one that definitely is non-integer is QuantityValue.
# Boring columns are DrugCodedProductCodeQualifier, RefillQualifier.

require(ggplot2)

qplot(X$DaySupply[X$DaySupply < 110])
qplot(X$FillNumber[X$FillNumber < 15])
qplot(X$FillDate)
qplot(X$QuantityQualifier)
qplot(X$QuantityValue[X$QuantityValue < 500])
qplot(X$RefillQuantity[X$RefillQuantity < 15])
qplot(X$DateWritten)

# Strictly, just plotting a distribution of QuantityValue conflates mL and pills. So don't do that in real life.

val_vs_qual = ggplot(X[X$QuantityValue < 300,], aes(QuantityQualifier, QuantityValue))
val_vs_qual + geom_boxplot()

subset = X[X$QuantityValue < 300,][1:10000,]
val10k = ggplot(subset, aes(x = QuantityValue))
val10k + geom_density(aes(color=QuantityQualifier))

ggm = rbind(X[X$QuantityQualifier == "GM",], X[X$QuantityQualifier == "GR",], X[X$QuantityQualifier == "ML",])
valgm = ggplot(ggm[ggm$QuantityValue < 300,], aes(x = QuantityValue))
valgm + geom_density(aes(color=QuantityQualifier))

X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "character", "factor", "numeric", "character", "factor", "integer", "Date", "character"))

#takes around 90 sec on my laptop
# Quantity and Refills seem to be unused

require(ggplot2)

qplot(X$DaySupply[X$DaySupply < 110])
qplot(X$FillNumber[X$FillNumber < 15])
qplot(X$FillDate)
qplot(X$QuantityQualifier)
qplot(X$QuantityValue[X$QuantityValue < 500])
qplot(X$RefillQuantity[X$RefillQuantity < 15])
qplot(X$DateWritten)

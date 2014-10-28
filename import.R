X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|")
# bad news
apply(X[1,], 2, class) # all character

q = c("x")
for (i in 1:18) {
	q = c(q, class(X[1,i]) )
}
q[2:19] # all factor

head(X$DrugCodedProductCodeQualifier) # something is definitely bad

X$messageid = as.character(X$messageid)
X$rowid = as.numeric(as.character(X$rowid))
X$DrugDescription = as.character(X$DrugDescription)
X$DaySupply = as.numeric(as.character(X$DaySupply))
X$Directions = as.character(X$Directions)
X$DrugCodedProductCode = as.numeric(as.character(X$DrugCodedProductCode))
# DrugCodedProductCodeQualifier # actually levels like ND
X$DrugCodedStrength = as.character(X$DrugCodedStrength)
X$FillNumber = as.numeric(as.character(X$FillNumber))
# FillDate
# Quantity # unused?
# QuantityQualifier # I think always ZZ
X$QuantityValue = as.numeric(as.character(X$QuantityValue))
# Refills # unused?
# RefillQualifier # actually levels
X$RefillQuantity = as.numeric(as.character(X$RefillQuantity))
# DateWritten
X$NPI = as.character(X$NPI)

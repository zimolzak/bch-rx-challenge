X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "character", "factor", "numeric", "character", "factor", "integer", "Date", "character"))

medHxRecord = read.csv("~/Desktop/local/surescript-code/Medication_History_Records.csv", sep=",", quote="", colClasses=c("character", "character", "integer", "character"))

drugDetails = X

joined = merge(x = drugDetails, y = medHxRecord, by = "messageid")
# around a minute


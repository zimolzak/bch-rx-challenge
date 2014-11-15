X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "character", "factor", "numeric", "character", "factor", "integer", "Date", "character"))

medHxRecord = read.csv("~/Desktop/local/surescript-code/Medication_History_Records.csv", sep=",", quote="", colClasses=c("character", "character", "integer", "character"))

drugDetails = X

joined = merge(x = drugDetails, y = medHxRecord, by = "messageid")
# around a minute

sorted = joined[order(joined$patientid, joined$DrugCodedProductCode, joined$FillDate),]
# 10 sec

patient_list = unique(sorted$patientid)
length(patient_list) # 35190 patients
drug_list = unique(sorted$DrugCodedProductCode)
length(drug_list) # 16015 NDCs

#####

df_ndc = data.frame(ndc = sorted$DrugCodedProductCode, stringsAsFactors=FALSE)
ndc_bestsellers = rle(sort(df_ndc$ndc)) # 15 sec

ndc_best_df = data.frame(count = unlist(ndc_bestsellers[1]), DrugCodedProductCode = unlist(ndc_bestsellers[2]))
ndc_best_df = ndc_best_df[order(ndc_best_df$count, decreasing = TRUE),]




uniq_drug_rownames = row.names(unique(df_ndc))
uniq_drugs = sorted[row.names(u),] # about 45 sec of CPU-intensive
ndc_dict = uniq_drugs[c("DrugDescription", "DrugCodedProductCode")]

bestseller_w_names = merge(x=ndc_dict, y=ndc_best_df, by="DrugCodedProductCode")
bestseller_w_names = bestseller_w_names[order(bestseller_w_names$count, decreasing=TRUE),]
bestseller_w_names = unique(bestseller_w_names)

#uniq_drugs = uniq_drugs$DrugDescription
#uniq_drugs = unique(uniq_drugs)
#uniq_drugs = sort(uniq_drugs)
#length(uniq_drugs)

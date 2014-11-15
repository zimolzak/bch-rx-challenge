X = read.csv("~/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "character", "factor", "numeric", "character", "factor", "integer", "Date", "character"))

medHxRecord = read.csv("~/Desktop/local/surescript-code/Medication_History_Records.csv", sep=",", quote="", colClasses=c("character", "character", "integer", "character"))

drugDetails = X

joined = merge(x = drugDetails, y = medHxRecord, by = "messageid")
# around a minute

sorted = joined[order(joined$patientid, joined$DrugCodedProductCode, joined$FillDate),]
# 10 sec

#### elementary counts

patient_list = unique(sorted$patientid)
length(patient_list) # 35190 patients
drug_list = unique(sorted$DrugCodedProductCode)
length(drug_list) # 16015 NDCs

##### find most frequently prescribed NDCs

row.names(sorted) = (1:dim(sorted)[1])

df_ndc = data.frame(ndc = sorted$DrugCodedProductCode, stringsAsFactors=FALSE)

ndc_bestsellers = rle(sort(df_ndc$ndc)) # 15 sec
ndc_best_df = data.frame(count = unlist(ndc_bestsellers[1]), DrugCodedProductCode = unlist(ndc_bestsellers[2]))
ndc_best_df = ndc_best_df[order(ndc_best_df$count, decreasing = TRUE),]

uniq_drug_rownames = row.names(unique(df_ndc))
uniq_drugs = sorted[uniq_drug_rownames,] # about 45 sec of CPU-intensive
ndc_dict = uniq_drugs[c("DrugDescription", "DrugCodedProductCode")]

bestseller_w_names = merge(x=ndc_dict, y=ndc_best_df, by="DrugCodedProductCode")
bestseller_w_names = bestseller_w_names[order(bestseller_w_names$count, decreasing=TRUE),]

head(bestseller_w_names, n=100)

#### elementary analyses on DrugDescription

length(unique(uniq_drugs$DrugDescription)) # 9451; not all NDCs have unique descriptions

head(unique(sort(uniq_drugs$DrugDescription)),n=100)

#### 
delay = sorted[sorted$FillNumber==0,"FillDate"] - sorted[sorted$FillNumber==0,"DateWritten"]
require(ggplot2)
qplot(x=as.numeric(delay), log="x")

plot = ggplot(data.frame(delay = as.numeric(delay)), aes(x=delay))
plot + geom_density() + scale_x_log10()

delay_all = data.frame(delay = as.numeric(sorted$FillDate - sorted$DateWritten))
sorted = cbind(sorted,delay_all)

# qplot(data=sorted, x=DateWritten, y=delay) # bad idea on 1E6 data points.

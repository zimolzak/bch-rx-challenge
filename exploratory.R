DrugDetails = read.csv("/Users/ajz/Desktop/local/surescript-code/fixed_drug_details.csv", sep="|", quote="", colClasses=c("character", "integer", "character", "integer", "character", "character", "factor", "character", "numeric", "Date", "character", "factor", "numeric", "character", "factor", "integer", "Date", "character"))

MedicationHistoryRecords = read.csv("/Users/ajz/Desktop/local/surescript-code/Medication_History_Records.csv", sep=",", quote="", colClasses=c("character", "character", "integer", "character"))

joined = merge(x = DrugDetails, y = MedicationHistoryRecords, by = "messageid") # around a minute

joined = joined[order(joined$patientid, joined$DrugCodedProductCode, joined$FillDate),] # 10 sec

#### elementary counts

patient_list = unique(joined$patientid)
length(patient_list) # 35190 patients
drug_list = unique(joined$DrugCodedProductCode)
length(drug_list) # 16015 NDCs

##### find most frequently prescribed NDCs

row.names(joined) = (1:dim(joined)[1])

df_ndc = data.frame(ndc = joined$DrugCodedProductCode, stringsAsFactors=FALSE)

ndc_bestsellers = rle(sort(df_ndc$ndc)) # 15 sec
ndc_best_df = data.frame(count = unlist(ndc_bestsellers[1]), DrugCodedProductCode = unlist(ndc_bestsellers[2]))
ndc_best_df = ndc_best_df[order(ndc_best_df$count, decreasing = TRUE),]

uniq_drug_rownames = row.names(unique(df_ndc))
uniq_drugs = joined[uniq_drug_rownames,] # about 45 sec of CPU-intensive
ndc_dict = uniq_drugs[c("DrugDescription", "DrugCodedProductCode")]

bestseller_w_names = merge(x=ndc_dict, y=ndc_best_df, by="DrugCodedProductCode")
bestseller_w_names = bestseller_w_names[order(bestseller_w_names$count, decreasing=TRUE),]

head(bestseller_w_names, n=100)

#### elementary analyses on DrugDescription

length(unique(uniq_drugs$DrugDescription)) # 9451; not all NDCs have unique descriptions

head(unique(sort(uniq_drugs$DrugDescription)),n=100)

#### elementary analysis on delay between date rx written and date rx filled.

delay = joined[joined$FillNumber==0,"FillDate"] - joined[joined$FillNumber==0,"DateWritten"]
require(ggplot2)
plot = ggplot(data.frame(delay = as.numeric(delay)), aes(x=delay))
plot + geom_density() + scale_x_log10() # univar distribution of delay (rx vs fill) is kinda bimodal

delay_all = data.frame(delay = as.numeric(joined$FillDate - joined$DateWritten))
joined = cbind(joined,delay_all)

plot2 = ggplot(head(joined,n=10000), aes(x=DateWritten, y=delay))
plot2 + geom_density2d() + geom_point()  + ylim(0, 150) + xlim(as.Date("2012-07-01"), as.Date("2013-12-31"))
  # envelope effect of delay vs date written, 2D density looks like flat trend.

plot3 = ggplot(head(joined,n=100000), aes(x=DateWritten, y=delay))
plot3 + geom_density2d() + ylim(0, 150) + xlim(as.Date("2012-07-01"), as.Date("2013-12-31"))
  # just zoomed in 2D density plot

#### rectangle plot for a few patients

pt_ndc_pairs = unique(joined[c("patientid", "DrugCodedProductCode")])
pt_ndc_pairs$n = 1:dim(pt_ndc_pairs)[1]

pt_n = unique(joined["patientid"])
pt_n$pt_n = 1:dim(pt_n)[1]

j_drugeras = merge(x=joined, y=pt_ndc_pairs, by = c("patientid", "DrugCodedProductCode"))
j_drugeras = merge(x=j_drugeras, y=pt_n, by = "patientid")

rect_plot = ggplot(head(j_drugeras, n=300), aes(xmin=n-0.5, xmax=n+0.5, ymin=FillDate, ymax=FillDate+DaySupply, alpha=0.5, color=as.factor(pt_n)))
rect_plot + geom_rect() + coord_flip()  # + geom_hline(yintercept=365) + scale_y_continuous(breaks = seq(0, 390, 30), limits=c(0,390)) 

#### NPI (provider) level analysis


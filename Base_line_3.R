### DO NOT CHANGE THIS PART
d <- readRDS("data_learn.rds")
for ( v in c("sex", "tissue_status", "project", "tissue", "t", "n", "m", "tnm_stage", "tnm_grade") ) {
    d[[ v ]] <- as.factor(x = d[[ v ]])
}
summary(object = d)

test <- readRDS("data_test_3.rds")
for ( v in c("sex", "tissue_status", "project", "tissue", "t", "n", "m", "tnm_stage", "tnm_grade") ) {
    test[[ v ]] <- as.factor(x = test[[ v ]])
}
test$sex <- NULL
summary(object = d)

## PUT YOUR SCRIPT HERE
model <- glm(
    formula = ATAD2 ~ SYCP3 + BRDT + BRD4 + NUTM1 + MAGEB6 + TUBA3C + H19 + IGF2 + NNAT + BLCAP + SMYD3 + MAP3K2 + KDR + TP53 + KRAS + BRAF + FASTKD1 + ND2 + ND3 + ND4
  , data = d
)
summary(object = model)

pred <- predict.glm(object = model, newdata = test)

### DO NOT CHANGE THIS PART
pred               <- as.data.frame(x = pred)
colnames(x = pred) <- "ATAD2"
saveRDS(pred, "results.rds")
zip_filename <- paste0(
    "results_"
  , format(x = Sys.time( ), format = "%Y_%m_%d_-_%s")
  , ".zip"
)
zip(zip_filename, "results.rds")
print(zip_filename)

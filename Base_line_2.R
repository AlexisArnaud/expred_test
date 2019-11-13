### DO NOT CHANGE THIS PART
d <- readRDS("data_learn.rds")
for ( v in c("project", "tissue_status", "project", "tissue", "t", "n", "m", "tnm_stage", "tnm_grade") ) {
    d[[ v ]] <- as.factor(x = d[[ v ]])
}
summary(object = d)

test <- readRDS("data_test_2.rds")
for ( v in c("project", "tissue_status", "project", "tissue", "t", "n", "m", "tnm_stage", "tnm_grade") ) {
    test[[ v ]] <- as.factor(x = test[[ v ]])
}
test$project <- NULL
summary(object = d)

## PUT YOUR SCRIPT HERE
model <- glm(
    formula = project ~ tissue_status + sex
  , data = d
  , family = binomial(link = 'logit')
)
summary(object = model)

pred <- predict.glm(object = model, newdata = test, type = "response")
idx  <- pred <= 0.5
pred[  idx ] <- levels(x = d$project)[ 1 ]
pred[ !idx ] <- levels(x = d$project)[ 2 ]
table(pred)

### DO NOT CHANGE THIS PART
pred               <- as.data.frame(x = pred)
colnames(x = pred) <- "project"
saveRDS(pred, "results.rds")
zip_filename <- paste0(
    "results_"
  , format(x = Sys.time( ), format = "%Y_%m_%d_-_%s")
  , ".zip"
)
zip(zip_filename, "results.rds")
print(zip_filename)

# 'dataset' holds the input data for this script
dataset$tax_rate <- dataset$TaxAmt / dataset$TotalProductCost
output <- dataset
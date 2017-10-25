newdata <- birthwt[-train,c('age','lwt','race','smoke','ptl','ht','ui','ftv')]
rownames(newdata) <- NULL
saveRDS(newdata,file="newbwdata.Rda")

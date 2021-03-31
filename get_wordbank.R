list_class <-c("nouns", "verbs", "adjectives", "function_words", "other")

load_wordbank<- function(lang_) {
  WB_tokens <- get_item_data(language = lang_, form = "WS")
  WB_tokens <- WB_tokens %>% 
    filter (type == "word")  #remove grammar
  
  data <- get_instrument_data(language = lang_, form = "WS", items = WB_tokens$item_id, administrations = TRUE, iteminfo=TRUE)
  names(data)[names(data) == "definition"] <- "lemma"
  
  aoa <- fit_aoa(data, measure = "produces", method = "glmrob", proportion = 0.5) # 145 NAs out of 680
  names(aoa)[names(aoa) == "definition"] <- "lemma"
  
  dataAoa <- unique(data) %>% left_join(unique(aoa))
  dataAoa <- dataAoa[!is.na(dataAoa$value), ]  #remove WB lemmas with no value
  # dataAoa_class<-split(dataAoa, dataAoa$lexical_class)
  # 
  return(dataAoa)
}

frequency_raw <- function(corpus_) {
  corpus_frequency <- corpus_ %>%  
    group_by(lemma, target_child_id, language) %>% 
    summarize(CountLemma = n()) #count each lemma for each child
  
  countAllLemmas <- corpus_frequency %>%  
    group_by(target_child_id, language) %>% 
    summarize(countAllLemmasChild=sum(CountLemma)) #count all lemma tokens for child 
  
  corpus_frequency<-corpus_frequency %>% 
    left_join(countAllLemmas) #join infos
  
  corpus_frequency<-corpus_frequency %>% 
    mutate (rawFrequency = CountLemma / countAllLemmasChild) %>% 
    mutate (FrequencyLog = log(1+ rawFrequency * 100)) #Convert rawFrequency to FrequencyLog to avoid very small values.
  
  corpus_frequency1<- corpus_frequency %>%  
    group_by(lemma, language) %>% 
    summarize(FrequencyLogMean=mean(FrequencyLog))
  
  corpus_frequency <- corpus_frequency %>% 
    left_join(corpus_frequency1) 
  
  return(corpus_frequency)
} 


frequency_model <- function(corpus_) {
  corpus_frequency <- frequency_raw(corpus_)
  
  models <- corpus_frequency %>%
    group_by(language, lemma) %>%  nest() 
  
  models_ <- models %>% 
    mutate (interceptmodel = map(.x=data, 
                                 .f=~coef(lm(.x$rawFrequency ~(.x$countAllLemmasChild-.x$CountLemma), data=data))["(Intercept)"], 
                                 na.rm = T))
  
  models_<-models_ %>% unnest(interceptmodel)
  
  corpus_frequency_ <- corpus_frequency %>% 
    left_join(unique(models_)) 
  
  return(corpus_frequency_)}

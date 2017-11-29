
rm(list = ls())

library(Matrix)
library(twitterreport)

source("tokens.r")

candidatos <- c("carolinagoic", "eduardo_artes", "joseantoniokast", "BeaSanchezYTu",
                "sebastianpinera", "guillier", "marcoporchile", "senadornavarro")

query <- paste0("@", candidatos, collapse = " OR ")

dat4 <- tw_api_get_search_tweets(query, twitter_token = tokens, lang = "es", count=4e4,
                                result_type = "mixed", max_id = 935320942460489728)

dat2 <- tw_extract(dat$text, obj = c("hashtag","mention"))

JC <- jaccard_coef(
  dat$text,
  stopwds = c(tm::stopwords("es"), "rt", "chile", "56949895434", "nov", "19", "noviembre")
  )

dat3<- tw_timeseries(dat2$hastag, dat$created_at)
plot(dat3)

head(words_closeness("pi(ñ|n)era", JC), 20)
head(words_closeness("guilli?er", JC), 20)

head(words_closeness("bachele", JC), 20)


rm(list = ls())

library(Matrix)
library(twitterreport)

source("tokens.r")

candidatos <- c("carolinagoic", "eduardo_artes", "joseantoniokast", "BeaSanchezYTu",
                "sebastianpinera", "guillier", "marcoporchile", "senadornavarro")

query <- paste0("@", candidatos, collapse = " OR ")

dat <- tw_api_get_search_tweets(query, twitter_token = tokens, lang = "es", count=5e4,
                                result_type = "mixed")

# Guardando archivo
readr::write_csv(dat, path = "tweets/sobre_candidatos.csv")
zip("tweets/sobre_candidatos.zip", files = "tweets/sobre_candidatos.csv",
    flags = "-r9Xm")

# Coefficiente de Jaccard
JC <- jaccard_coef(
  dat$text,
  stopwds = c(tm::stopwords("es"), "rt", "chile", "56949895434", "nov", "19", "noviembre")
  )

# Buscando terminos similares
regexs <- c("goic", "art(e|é)s", "kast", "bea|sanchez", "pi(ñ|n)era", "guilli?er",
            "marco|meo", "navarro")

ans <- vector("list", length(regexs))
names(ans) <- candidatos
for (i in seq_along(regexs))
  ans[[i]] <- head(words_closeness(regexs[i], JC, criter = 0.001), 20)

# Creando archivo readme
writeLines(
  paste0(
    "---\n",
    "title: Tweets SOBRE candidatos \n",
    "---\n\n",
    "Los tweets mencionando candidatos fueron actualizadas por ultima vez en ", Sys.time(),". ",
    "Los datos utilizados para crear las tablas [sobre_candidatos.zip](sobre_candidatos.zip)."
  ),
  con = "tweets/sobre_candidatos.md"
)

sobre_candidatos <- ans
save(sobre_candidatos, file="tweets/sobre_candidatos.rda")

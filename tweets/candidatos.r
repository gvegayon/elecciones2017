rm(list = ls())

library(twitterreport)
library(Matrix)

#' Creates a network based on the candidate's twitter account's tweets.
#' 
#' @param candidate Character scalar. Screen name of the candidate
#' @param nwords Integer scalar. Number of words to include in the network.
#' @param stopwrds Character vector. Stopwords
#' @param layoutf Function. Layout function. Should receive an `igraph` object 
#' as input.
#' @param clusterf Function. Community detection function. Should receive an
#' `igraph` object as an input.
#' @param path Character scalar. Path where the networks will be stored.
#' 
#' @return The network and jaccard matrix.
#' 
#' 
candidate_cloud <- function(
  candidate,
  token,
  dir      = tempdir(),
  nwords   = 100,
  stopwds = c(tm::stopwords("es"), "rt", "chile", "56949895434", "nov", "19", "noviembre"),
  layoutf  = igraph::layout_with_fr,
  clusterf = igraph::cluster_fast_greedy,
  ...
) {
  
  # Fetching the tweets
  ans <- tw_api_get_statuses_user_timeline(
    candidate, twitter_token = token, count = 2000)
  
  # Computing the jaccard coefficient
  ans_jac <- jaccard_coef(
    ans$text,
    stopwds = c(stopwds, candidate)
  )
  
  # Creating the adjacency network
  med <- median(ans_jac$mat@x)
  mat <- as.matrix(with(ans_jac, mat + t(mat)))
  size <- diag(mat)/2
  mat[] <- ifelse(mat[] < med, 0, 1)
  
  mat <- mat 
  diag(mat) <- 0
  
  # Keeping only the top nwords
  ids <- which(rank(-size) <= nwords)
  mat <- mat[ids,ids]
  size <- size[ids]
  
  # Dichotomizing
  mat[mat != 0] <- 1
  
  # Reading as igraph and computing layout
  net <- igraph::graph_from_adjacency_matrix(mat, mode="undirected")
  
  pos <- layoutf(net)
  pos[,1] <- (pos[,1] - mean(pos[,1]))/sd(pos[,1])
  pos[,2] <- (pos[,2] - mean(pos[,2]))/sd(pos[,2])
  
  # Communities
  types <- as.integer(igraph::membership(clusterf(net)))
  ntypes <- length(unique(types))
  
  # Creating files using -rgexf-
  plot(rgexf::igraph.to.gexf(
    net,
    nodesVizAtt = list(
      position = pos,
      color = topo.colors(ntypes)[types]
    )),
    edgeWidthFactor=.01,
    dir = dir,
    graphFile = sprintf("%s.gexf", candidate),
    ...
  )
  
  list(
    tweets  = ans,
    jaccard = mat,
    net     = net,
    community = types
  )
  
}

# Here you put the tokens :)
# You should get yours in https://apps.twitter.com/
source("tokens.r")
# tokens <- tw_gen_token('mytwitterapp','xxxxxxxx','yyyyyyyy')

# Listing candidates
candidatos <- c("carolinagoic", "eduardo_artes", "joseantoniokast", "BeaSanchezYTu",
                "sebastianpinera", "guillier", "marcoporchile", "senadornavarro")

# Creating vector
ans <- vector("list", length(candidatos))
names(ans) <- candidatos

# Looping through twitter accounts
for (candidato in candidatos) {
  
  # Checking folder
  if (!dir.exists(candidato))
    dir.create(candidato)
  
  # Getting the data!
  ans[[candidato]] <- candidate_cloud(
    candidato, tokens,
    dir = candidato, copy.only = TRUE
    )
 
  message("Candidate ", candidato, " done!") 
  
}

# Creando archivo readme
writeLines(
  paste0(
    "---------\n",
    "title: Tweets DE candidatos \n",
    "---------\n\n",
    "Las redes en\n\n  - `../", paste0(candidatos, collapse="`\n  - `../"),
    "`\n\nY datos en `candidatos.csv` fueron actualizadas por ultima vez en ", Sys.time(),". ",
    "Los datos utilizados para crear las redes estan en el archivo [candidatos.zip](candidatos.zip)."
    ),
  con = "tweets/candidatos.md"
  )

# Guardando datos y comprimiendo
dat <- do.call(rbind, lapply(ans, "[[", "tweets"))
readr::write_csv(dat, path = "tweets/candidatos.csv")
zip(zipfile = "tweets/candidatos.zip", files = "tweets/candidatos.csv",
    flags = "-r9Xm")

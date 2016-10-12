#### Wordcloud
library(wordcloud)
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)

par(family = "STKaiti") ## only for Mac OS
wordcloud(d$word, d$freq, min.freq = 50, random.order = F, ordered.colors = F, 
          colors = rainbow(length(row.names(m))))

#### you can using rWordCloud package for D3 wordcloud
library(rWordCloud)
d3Cloud(text = d$word, size = d$freq)


##########################
#       Collocations     #
##########################
# devtools::install_github("kbenoit/quanteda")
library(quanteda)
library(data.table)

# source("collocation2.R")
# Windows ??ˆè?‹æ?“é?‹collocation2_Win.Rå¾Œå…¨?¸?Ÿ·è¡?

C_words<- collocations2(unlist(Sentence), method = "all")

C_words <- C_words[C_words$pmi>3,]

C_words <- paste0(C_words$word1, C_words$word2)
C_words

#### you can using following code to insert words to directory
# insertWords(toTrad(words, rev = T))

##########################
#     Text Clustering    #
##########################
tdm_corpus <- removeSparseTerms(tdm, sparse=0.7)
dist_tdm_corpus <- dist(as.matrix(tdm_corpus))
fit <- hclust(dist_tdm_corpus, method="ward")
par(family = "STKaiti") ## only for Mac OS
plot(fit)
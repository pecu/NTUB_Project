##########################
#       Read Files       #
##########################
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)

dirPath = "./Food/"

#### Put the documents' directory
d.corpus <- Corpus(DirSource(dirPath), list(language = NA))


##########################
#    Text Processing     #
##########################

#### Remove Punctuation and Numbers from corpus
d.corpus <- tm_map(d.corpus, removePunctuation)
d.corpus <- tm_map(d.corpus, removeNumbers)
d.corpus <- tm_map(d.corpus, function(word)
{ gsub("\\n", "", word) })
d.corpus <- tm_map(d.corpus, function(word)
{ gsub("\\t", "", word) })

#### Using Rwordseg or jiebaR package to break down Chines. Here, we using Rwordseg
# d.corpus <-  sapply(1:length(d.corpus), function(u) { 
#  segmentCN(as.String(unlist(d.corpus[u])), nosymbol=F)})

#totalSegment = data.frame()
#for( j in 1:length(mat) )
#for( j in 1:endSetNo )
#{
#  result = segment(as.character(mat[j]), jiebar=mixseg)
#  totalSegment = rbind(totalSegment, data.frame(result))
#}

pageNo = 10
endSetNo = 300
corpusToChr = as.character(as.String(mat[1:300,]))
mixseg = worker()
mat <- matrix( unlist(d.corpus), nrow=length(unlist(d.corpus)) )
d.corpus <- sapply(1:pageNo, function(u) { 
  segment(corpusToChr, jiebar=mixseg, mod=NULL)
  })

Sentence <- sapply(1:length(d.corpus), function(u) paste(d.corpus[[u]], collapse=" "))
d.corpus <- Corpus(VectorSource(d.corpus))

#### Set the stopwords and rmove them
#myStopWords <- c(toTrad(stopwordsCN()), stopwords("english"), "蝺刻摩", "????", "璅??", "?靽?", "撖行平", "雿?")
#d.corpus <- tm_map(d.corpus, removeWords, myStopWords)

#### Building bag of words model(TF-IDF)

tdm <- TermDocumentMatrix(d.corpus, 
                          control = list(wordLengths = c(2, Inf),
                                         weighting =function(x) 
                                           weightTfIdf(x, normalize = FALSE)))
tdm

#### Get the Freq
findFreqTerms(tdm, lowfreq = 100)

#### Find association terms
findAssocs(tdm, "霸氣", 0.5)

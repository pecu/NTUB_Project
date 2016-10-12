library(XML)
library(RCurl)

##########################
#     Download Files     #
##########################
# only for windows
# signatures <- system.file("CurlSSL", cainfo="cacert.pem", package="RCurl")

dirPath = "./Food/"

#### Get the last page Number

# MAC
#lastpage <- unlist(xpathSApply(htmlParse( getURL(paste0("https://www.ptt.cc/bbs/Food/index.html"))),  "//div[@class='btn-group btn-group-paging']/a",xmlGetAttr, "href"))[[2]]
# windows
# url <- "https://www.ptt.cc/bbs/Food/index.html"
# page <- getURL(url)
# passXML <- htmlParse(page)
# xpathXML <- xpathSApply(passXML, "//div[@class='btn-group btn-group-paging']/a",xmlGetAttr, "href")
# lastpage <- unlist(xpathXML[[1]])
# 
# lastpage <- gsub(".*index", "", lastpage)
# lastpage <- as.numeric(gsub("[.]*html", "", lastpage))+1
# offset = 5800

startNo = 5800
endNo   = 5820

#### Get link form each pages
link.Food <- NULL
#for( i in (lastpage-offset):lastpage){ # ????????100蝭?
for( i in c(startNo:endNo) ){ # ????????100蝭?
  url <- paste0("https://www.ptt.cc/bbs/Food/index", i, ".html")
  html <- htmlParse(getURL(url))
  url.list <- xpathSApply(html, "//div[@class='title']/a[@href]", xmlAttrs)
  link.Food <- c(link.Food, paste('https://www.ptt.cc', url.list, sep=''))
  print(paste("Get url from the billboard's(Food) page :", i))
}


#### Write a function to save documents
getdoc <- function(link, path){
  doc <- xpathSApply(htmlParse(getURL(link), encoding="UTF-8"), "//div[@id='main-content']", xmlValue)
  name <- strsplit(link, '/')[[1]][6]
  write(doc, file=file.path(path,gsub('html', 'txt', name)))  
}

#### Set the path where you want to save documents
system.time(sapply(1:100, function(i) getdoc(link.Food[i], dirPath)))

# system.time(sapply(1:length(link.CVS), function(i) getdoc(link.CVS[i], path="~/Desktop/CVS document/")))


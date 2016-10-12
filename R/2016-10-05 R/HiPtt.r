rm(list=ls(all.names=TRUE))
library(XML)
library(RCurl)
library(httr)

startNo = 1
endNo   = 3
subPath = "https://www.ptt.cc/bbs/joke/index"
alltitle = data.frame()
for( i in c(startNo:endNo) )
{
  print(i)
  urlPath  = paste(subPath, i, ".html", sep = "")
  temp     = getURL(urlPath)
  xmlData  = htmlParse(temp) 
  titleRUL = xpathSApply(xmlData, "//div[@class=\"title\"]/a//@href")
  subtitle = data.frame(titleRUL)
  alltitle = rbind(alltitle, subtitle)
}

allPath = length(alltitle$titleRUL)
tempURL = "https://www.ptt.cc"
for( j in 1:allPath )
{
  urlPath  = paste(tempURL, alltitle$titleRUL[j], sep = "")
  temp     = getURL(urlPath)
  xmlData  = htmlParse(temp) 
  Pcontent = xpathSApply(xmlData, "//div[@id=\"main-content\"]", xmlValue)
  filename = paste("./data/", j, ".txt", sep = "")
  write.csv(Pcontent, filename)
}
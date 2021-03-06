rm(list = ls())

library(shiny)
library(ggplot2)
library(data.table)
library(ggalt)
library(tm)
library(wordcloud)

source("dataPreparation.R")
setDT(rawData)

wordsToRemove <- c('republic', 'breaking', 'now', 'will')

cleanTextVector <- function(x){
  textData   <- x
  corpusData <- Corpus(VectorSource(textData))
  corpusData <- tm_map(corpusData, content_transformer(tolower))
  corpusData <- tm_map(corpusData, removeNumbers)
  corpusData <- tm_map(corpusData, stripWhitespace)
  corpusData <- tm_map(corpusData, removePunctuation)
  corpusData <- tm_map(corpusData, removeWords, wordsToRemove)
  corpusData <- tm_map(corpusData, removeWords, stopwords('english'))
  return(corpusData)
}
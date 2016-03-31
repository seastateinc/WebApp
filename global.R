#global.R
library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(lubridate)

A80 <- readRDS("data/A80.rds")
dateRange  <- range(ymd(A80$HaulDate))

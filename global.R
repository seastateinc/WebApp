
library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(lubridate)

A80 <- readRDS("data/A80.rds")
tripTarget <- unique(A80$TripTarget); names(tripTarget)=paste(tripTarget)
dateRange  <- range(ymd(A80$HaulDate))
A80 <- A80 %>% mutate(HalibutCPUE=PreMortalityPacificHalibutWt/Duration)


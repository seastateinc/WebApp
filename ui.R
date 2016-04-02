# ui.R
# source("helpers.R")
# library(shiny)
# library(leaflet)
# library(dplyr)
# library(ggplot2)
# library(lubridate)

varRadius <- c("Halibut CPUE (t/hour)" = "HalibutCPUE")
dateRange  <- range(ymd(A80$HaulDate))

shinyUI(
	fluidPage(
	navbarPage("Amendment 80", id="nav",

		tabPanel("Interactive map",
	    	div(class="outer",

	    		tags$head(
			        # Include our custom CSS
			        includeCSS("styles.css")
			        # includeScript("gomap.js")
			    ),

				leafletOutput("map",width="100%",height="100%"),

				absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
		        			  draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
		                      width = 330, height = "auto",

		        	h2("Haul explorer"),
		        	# dateRangeInput("inpFullDate","Haul Date Range",
		        	#                min = min(dateRange), max=max(dateRange),
		        	#                startview="year"),

		        	sliderInput("inpYear","Year",
		        	            min     = year(dateRange[1]),
		        	            max     = year(dateRange[2]),
		        	            value   = year(dateRange[1]),
		        	            step    = 1,
		        	            animate = FALSE),

		        	# sliderInput("sldr_year","Year",min=2008,
		        	#             max=2016,
		        	#             value=2008,step=1,
		        	#             animate=FALSE),

		        	selectInput("inpTripTarget",h5("Trip Target"),
		        	            as.vector(tripTarget),
		        	            selected = "RockSole",
		        	            multiple=TRUE),

		        	selectInput("inpVariableRadius","Radius",
		        	            varRadius,multiple=FALSE),

		        	plotOutput("histCPUE",height=200)

				)
			)
	    ),

	    tabPanel("Data Explorer")
)))
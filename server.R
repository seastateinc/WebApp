# server.R

library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(lubridate)


source("helpers.R")


shinyServer(function(input, output, session) {

	# Interactive Leaflet Map
	output$map <- renderLeaflet({
		leaflet() %>%
		setView(lat = 57.79, lng = -152.4, zoom = 5) %>%
		addProviderTiles("Esri.WorldImagery",
			group = "Esri WI",
			options = providerTileOptions(noWrap=FALSE)
		)
	})

	# Reactive expression that returns the data that are currently in bounds
	haulInBounds <- reactive({
		if (is.null(input$map_bounds))
			return(A80[FALSE,])

		bounds <- input$map_bounds
		latRng <- range(bounds$south,bounds$north)
		lonRng <- range(bounds$west,bounds$east)
		
		# subset(A80,
		#        Latitude  >= latRng[1] & Latitude  <= latRng[2] &
		#        Longitude >= lonRng[1] & Longitude <= lonRng[2] )

		yr <- input$sldr_year
		tt <- input$inpTripTarget
		A80 %>% filter(year(HaulDate) %in% yr, TripTarget %in% tt) %>%
				filter(Latitude  >= latRng[1] & Latitude  <= latRng[2] &
		               -Longitude >= lonRng[1] & -Longitude <= lonRng[2] )
	})

	# Observer for maintaining cirles and legend, accoring to the variables 
	# that are currently in the map range.
	observe({
		# User input
		yr <- input$sldr_year
		tt <- input$inpTripTarget
		rr <- input$inpVariableRadius 

		# Filter df based on User Input
		df <- A80 %>% filter(year(HaulDate) %in% yr, TripTarget %in% tt) 

		colorData <- df$TripTarget
		pal <- colorFactor("Spectral",colorData)
		
		# Update interactive map with new data
		leafletProxy("map",data=df) %>%
			clearShapes() %>%
			addCircles(lng = ~-Longitude, 
			           lat = ~Latitude, 
			           radius = ~5000*sqrt(df[[rr]]),
			           # color  = "yellow",
			           color  = pal(colorData),
			           stroke = FALSE,
			           layerId=~Id)
			#TODO Add legend to map


	})

	# histogram of CPUE's
	output$histCPUE <- renderPlot({
		# If no reconts in view then don't plot
		df <- haulInBounds()
		if(nrow(df)==0) return(NULL)
	

		df %>% 	ggplot(aes(HalibutCPUE)) + 
				geom_histogram(aes(fill=TripTarget),bins=10,position="dodge") +
				labs(x=input$inpVariableRadius,y="Count") + 
				scale_y_sqrt() + scale_x_sqrt()


	})


	# Show a popup at given location
	showHaulInfoPopup <- function(haulId,lat,lng)
	{
		selectedHaul <- A80[A80$Id == haulId,]
		# print(selectedHaul$HalibutCPUE)

		content <- as.character(tagList(
		  tags$h4("Halibut CPUE (t/hr)", round(selectedHaul$HalibutCPUE,3))
		# tags$strong(HTML(sprintf("%s, %s %s",
		# selectedZip$city.x, selectedZip$state.x, selectedZip$zipcode
		# ))), tags$br(),
		# sprintf("Median household income: %s", dollar(selectedZip$income * 1000)), tags$br(),
		# sprintf("Percent of adults with BA: %s%%", as.integer(selectedZip$college)), tags$br(),
		# sprintf("Adult population: %s", selectedZip$adultpop)
		))
		print(content)
		leafletProxy("map") %>% addPopups(lng, lat, content, layerId = haulId)


	}

	# When map is clicked, show a popup with city info
	observe({
		leafletProxy("map") %>% clearPopups()
		event <- input$map_shape_click
		if (is.null(event))
		  return()
		
		isolate({
		  showHaulInfoPopup(event$id, event$lat, event$lng)
		})
	})

}) # END OF SHINY SERVER






























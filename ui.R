# ui.R

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
		        	            min=min(dateRange),
		        	            max=max(dateRange),
		        	            value=c(min(dateRanage),max(daterange))
		        	            ),

		        	sliderInput("sldr_year","Year",min=min(year(dateRange)),
		        	            max=max(year(dateRange)),
		        	            value=min(year(dateRange)),step=1,
		        	            # timeFormat = "%F",
		        	            animate=TRUE),

		        	selectInput("inpTripTarget","Trip Target",
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
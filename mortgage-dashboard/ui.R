library(shiny)

ui <- navbarPage("Mortgage portfolio",
                 tabPanel("Dashboard",
                          sidebarPanel("Controls",
                                  sliderInput("slider","Year", 1973, 2015, c(2000,2014)),
                                  uiOutput("saControl"),
                                  uiOutput("rgControl"),
                                  uiOutput("tpControl")
                                  #sliderInput("slider","Year", 1973, 2015, c(2000,2014)),
                                  
                          ),
                          mainPanel(
                                  tabsetPanel(
                                          tabPanel(
                                                  p(icon("line-chart"), "Visualization"),
                                                  plotOutput("plot1", height = 300),
                                                  tags$p("Total mortages according selection:"),
                                                  verbatimTextOutput("summary1"),
                                                  plotOutput("plot2", height = 300),
                                                  tags$p("Total value (Millions MXP) according selection:"),
                                                  verbatimTextOutput("summary2")
                                          ),
                                          tabPanel(
                                                  p(icon("pie-chart"), "Ratios"),
                                                  plotOutput("plot3", height = 700),
                                                  tags$p("The previous chart represents in the vertical axis: partitions
                                                         according the warranty at 40% vs the current balance (severity),
                                                         and in the horizontal axis: the required payment vs the
                                                         theorical payment (with initial conditions).")
                                                  
                                          )
                                  )
                        )
                ),
                tabPanel("About",
                         mainPanel(
                                 includeMarkdown("about.md")
                         )
                )
                                 
        )

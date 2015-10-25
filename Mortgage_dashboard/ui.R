library(shiny)

ui <- navbarPage("Mortgage dashboard",
                 tabPanel("dashboard",
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
                                          )
                                  )        
                        )
                )
        )

library(shinythemes)
library(downloader)
library('rCharts')




shinyUI(
  navbarPage(title="ustwo Diversity Dashboard",theme = shinytheme("flatly"),
             tabPanel('Graphs',
                      tags$head(
                        tags$script("
                                    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                                    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                                    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                                    ga('create', 'UA-7940378-1', 'auto');
                                    "),
                            tags$meta(property="og:title", content="ustwo Diversity Dashboard"),
                            tags$meta(property="og:url", content="http://diversity.ustwo.com"),
                            tags$meta(property="og:description", content="With this Dashboard we share our team data in the specific areas of age, gender, and ethnicity.")
                      ),
                      tags$link(rel = "stylesheet", type = "text/css", href = "button.css"),
                      sidebarLayout(
                        sidebarPanel(
                          tags$div(HTML('<div style="margin-bottom: 20px">
                            <p>We’re taking steps to build a more diverse company, and one of these is being open and transparent about the people who, together, make up ustwo.</p>
                            <p>We’ve built this using an <a href="https://github.com/bufferapp/diversity-dashboard">open source tool</a>. If you’ve got questions – <a href="mailto:hello@ustwo.com">let us know</a>!</p>
                            <p>Our data is dynamic and complex, so it might not always display beautifully. You can visit the “raw data” tab if there’s anything you’d like to check.</p>
                            <p style="color: #888; font-size: 14px; font-style: italic;">It’s important to note that due to Swedish data storage and privacy protection law, our Malmö studio is not included in our global dashboard.</p>
                          </div>')),
                          selectInput("dataset", "Show diversity data for",choices = c("The ustwo Team")),
                          radioButtons("plotType", "Plot type",c("Bar"="b", "Pie"="p")),
                          checkboxGroupInput("genderFilter", "Filter by gender",
                                             c('Male', 'Female', 'Self-described', 'Prefer Not to Answer'),
                                             selected=c('Male', 'Female', 'Self-described', 'Prefer Not to Answer')
                          ),
                          checkboxGroupInput("areaFilter", "Filter by area",
                                             c('Biz Dev',
                                               'Coaches',
                                               'Design',
                                               'Development',
                                               'Studio',
                                               'Finance',
                                               'Founders',
                                               'Marketing',
                                               'Operations',
                                               'Other'),
                                             selected=c('Biz Dev',
                                                        'Coaches',
                                                        'Design',
                                                        'Development',
                                                        'Studio',
                                                        'Finance',
                                                        'Founders',
                                                        'Marketing',
                                                        'Operations',
                                                        'Other')
                          ),
                          checkboxGroupInput("ethnicityFilter", "Filter by race",
                                             c('Asian/Asian Other',
                                               'Black/African/Caribbean/Black Other',
                                               'Latino/Hispanic',
                                               'Mixed/Multiple ethnic groups',
                                               'Other ethnic group',
                                               'Pacific Islander',
                                               'Prefer not to say',
                                               'Self-described',
                                               'White/Caucasian/White Other'
                                             ),
                                             selected=c('Asian/Asian Other',
                                                        'Black/African/Caribbean/Black Other',
                                                        'Latino/Hispanic',
                                                        'Mixed/Multiple ethnic groups',
                                                        'Other ethnic group',
                                                        'Pacific Islander',
                                                        'Prefer not to say',
                                                        'Self-described',
                                                        'White/Caucasian/White Other'
                                             )),
                          checkboxGroupInput("ageFilter", "Filter by age range",
                                             c('Under 18',
                                               '18-24',
                                               '25-34',
                                               '35-44',
                                               '45-54',
                                               '55-64',
                                               '65 or Above',
                                               'Prefer Not to Answer'
                                             ),
                                             selected=c('Under 18',
                                                        '18-24',
                                                        '25-34',
                                                        '35-44',
                                                        '45-54',
                                                        '55-64',
                                                        '65 or Above',
                                                        'Prefer Not to Answer'
                                             )
                          )
                        ),
                        mainPanel(
                          fluidRow(
                            column(width=10,
                                   tags$div(class='panel panel-default',
                                            tags$div(class='panel-heading','Gender Data'),
                                            htmlOutput('genderRatings'),
                                            tags$div(class='panel-body',
                                                     showOutput("genderPlot","nvd3"),
                                                     conditionalPanel(condition="input.dataset =='Applicants'",
                                                                      showOutput("genderTimeSeries","nvd3")
                                                     )
                                            )
                                   )
                            )
                          ),

                          #ethnicity
                          fluidRow(
                            column(width=10,
                                   tags$div(class='panel panel-default',
                                            tags$div(class='panel-heading','Ethnicity Data'),
                                            tags$div(class='panel-body',
                                                     htmlOutput('ethnicityRatings'),
                                                     showOutput("ethnicityPlot","nvd3"),
                                                     conditionalPanel(condition="input.dataset =='Applicants'",
                                                                       showOutput("ethnicityTimeSeries","nvd3")
                                                     )
                                            )
                                   )
                            )
                          ),
                          #age
                          fluidRow(
                            column(width=10,
                                   tags$div(class='panel panel-default',
                                            tags$div(class='panel-heading','Age Data'),
                                            tags$div(class='panel-body',
                                                     htmlOutput('ageRatings'),
                                                     showOutput("age_rangePlot","nvd3")
                                            )
                                   )
                            )
                          )

                        )
                      )
                      ),
             tabPanel('Raw Data',
                      mainPanel(
                        titlePanel("ustwo Team Data"),
                        tableOutput('teamTable')
                      )
             )
             #,tabPanel('Debug',
             #          mainPanel(
             #            tableOutput('debugTable1'),
             #            tableOutput('debugTable2')
             #          )
             #)
             )
)

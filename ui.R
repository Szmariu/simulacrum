#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(
        theme = shinytheme("readable"),
        
        # Application title
        titlePanel("Simulacrum"),
        
        # Sidebar with a slider input for number of bins
        sidebarLayout(
            sidebarPanel(
                tags$img(
                    src = 'logo.png',
                    width = '100%',
                    style = 'max-width: 700px;
                             margin: auto;
                             display: block;'),
                tabsetPanel(type = "tabs",
                            tabPanel("Attacker",
                                     splitLayout(
                                         numericInput('BS_', 'Ballistic skill', 50, 0, 100, 5),
                                         numericInput('damageDie_', "Weapon's damage die (e.g. d10)", 10, 0, 20, 1)
                                     ),
                                     
                                     splitLayout(
                                         numericInput('damageModifier_', "Weapon's damage modifier", 9, 0, 100, 1),
                                         numericInput('penetration_', "Weapon's penetration", 4, 0, 100, 1)
                                     ),
                                     
                                     numericInput('rateOfFire_', "Weapon's rate of fire (input only the one used, usually highest)", 3, 0, 100, 5),
                                     
                                     splitLayout(
                                         radioButtons('firingMode', "Weapon's type of fire", choiceNames = c('Single', 'Semi auto', 'Full auto'), choiceValues = c('single', 'semi', 'full'), selected = 'full'),
                                         checkboxGroupInput('additional_attacker', "Additional features (attacker)", choiceNames = c('Tearing', 'Proven'), choiceValues = c('tearing', 'proven'), selected = c('tearing'))
                                     ),

                                     conditionalPanel(
                                         condition = "input.additional_attacker.includes('proven')",
                                         numericInput('proven_', "Round damage values lower than:", 0, 0, 10, 1))
                                     ),
                            tabPanel("Defender", 
                                     splitLayout(
                                         numericInput('T_', 'Toughness', 30, 0, 100, 5),
                                         numericInput('wounds_', "Wounds", 20, 0, 100, 1)
                                     ),
                                     
                                     splitLayout(
                                         numericInput('armour_', "Armour", 4, 0, 100, 1),
                                         numericInput('dodge_', 'Dodge', 30, 0, 100, 5)
                                     ),
                                     
                                     splitLayout(
                                         numericInput('forceField_', "Force field", 0, 0, 100, 5),
                                         numericInput('forceFieldOverload_', "Force field overload", 0, 0, 100, 1)
                                     )
                                     ),
                            tabPanel("Settings",
                                     numericInput('nReps_', 'Number of monte carlo rounds', 4000, 1000, 50000, 1000),
                                     checkboxInput('showMisses_', 'Show misses on the plot?', 0)
                                    )
                            ),
                #submitButton(text = "Apply Changes", icon = NULL, width = NULL)
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("damagePlot"),
                plotOutput("damagePlotCumulated")
            )
        )
    )
)



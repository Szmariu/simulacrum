#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(
        
        # Application title
        titlePanel("Simulacrum"),
        
        # Sidebar with a slider input for number of bins
        sidebarLayout(
            sidebarPanel(
                tabsetPanel(type = "tabs",
                            tabPanel("Attacker",
                                     numericInput('BS_', 'BS', 50, 0, 100, 5),
                                     numericInput('damageDie_', "Weapon's damage die (e.g. d10)", 10, 0, 20, 1),
                                     numericInput('damageModifier_', "Weapon's damage modifier", 9, 0, 100, 1),
                                     numericInput('penetration_', "Weapon's penetration", 4, 0, 100, 1),
                                     numericInput('rateOfFire_', "Weapon's rate of fire (input only the one used, usually highest)", 3, 0, 100, 5),
                                     radioButtons('firingMode', "Weapon's type of fire", choiceNames = c('Single', 'Semi auto', 'Full auto'), choiceValues = c('single', 'semi', 'full'), selected = 'semi'),
                                     checkboxGroupInput('additional_attacker', "Additional features (attacker)", choiceNames = c('Tearing', 'Lol'), choiceValues = c('tearing', 'lol'), selected = c('tearing'))
                                     ),
                            tabPanel("Defender", 
                                     numericInput('T_', 'T', 30, 0, 100, 5),
                                     numericInput('wounds_', "Wounds", 20, 0, 100, 1),
                                     numericInput('armour_', "Armour", 4, 0, 100, 1),
                                     numericInput('dodge_', 'Dodge', 30, 0, 100, 5),
                                     numericInput('forceField_', "Force field", 0, 0, 100, 5),
                                     numericInput('forceFieldOverload_', "Force field overload", 0, 0, 100, 1)
                                     ),
                            tabPanel("Settings",
                                     numericInput('nReps_', 'Number of monte carlo rounds', 10000, 100, 10000000, 10000),
                                     checkboxInput('showMisses_', 'Show misses on the plot?', 0)
                                    )
                            ),
                submitButton(text = "Apply Changes", icon = NULL, width = NULL)
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("damagePlot"),
                plotOutput("damagePlotCumulated")
            )
        )
    )
)



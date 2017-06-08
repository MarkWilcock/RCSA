# tidy data.R

# Transforms score data from RCSA Excel Viz sheet into a format useful to the PBI Visual 

library(openxlsx)
library(dplyr)
library(tidyr)
library(ggplot2) 
library(readr) 

xls_viz <- "RCSA Example Viz.xlsx"
xls_lookup <- "RCSA Example Lookup.xlsx"
xls_tidy <- "RCSA Tidy Data.xlsx"

df <- read.xlsx(xls_viz, namedRegion = "markedRegion")

risk_hierarchy <- read.xlsx(xls_lookup, sheet = "RiskHierarchy")

score_lookup <- read.xlsx(xls_lookup, sheet = "ScoreLookup")

str(risk_hierarchy)

df_tidy <- 
  bind_rows(
    df %>%
      select(
        RiskSubCategoryKey,
        Europe = `Inherent-Europe`,
        Asia = `Inherent-Asia`,
        Americas = `Inherent-Americas`) %>%
      mutate(MeasureGroup = 'Inherent Risk Score'),
    df %>%
      select(
        RiskSubCategoryKey,
        Europe = `Control-Europe`,
        Asia = `Control-Asia`,
        Americas = `Control-Americas`) %>%
      mutate(MeasureGroup = 'Mitigating Controls'),
    df %>%
      select(
        RiskSubCategoryKey,
        Europe = `Residual-Europe`,
        Asia = `Residual-Asia`,
        Americas = `Residual-Americas`) %>%
      mutate(MeasureGroup = 'Residual Risk Score')
  ) %>%
  gather(Region, Score, Europe:Americas) %>%
  inner_join(risk_hierarchy) %>%
  inner_join(score_lookup)



dataset <-  rename(df_tidy, WorstCaseScore = Score)

ggplot(dataset, aes(x=Region, y = `RiskSubCategory`, fill = WorstCaseScore)) +
  geom_tile() +
  geom_text(aes(label = WorstCaseScore)) +
  facet_grid(RiskCategory ~ MeasureGroup, scales = "free_y") +
  scale_fill_manual(values = c(VH = "firebrick", H = "darkorange", M = "yellow", L = "seagreen3", 
                               A = "white", I  = "lightcoral", V = "tomato", NC = "red")) +
  scale_x_discrete(position = "top") +
  scale_y_discrete("Risk Sub Category", position = "left") +
  ggtitle("Operational Risk And Controls Self Assessment", 
          "Implementation in R using ggplot") +
  theme_minimal() +
  theme(strip.text.y = element_text(angle = 0, hjust = 0), strip.placement = "outside") +
  theme(legend.position = "none")
    

# for some reason, need to open / save this in Excel before PBID will read it
#write.xlsx(df_tidy, file = xls_tidy, asTable = TRUE)
  
# RCSA demo

Objective is to build an RCSA heatmap implemented  ggplot and deliver within PBI.  

## Background

An RCSA plot is an important standard visual used in Operational Risk.  It  shows scores expressed as ordinal values (Low, Medium, High) mapped to a RAG colour scale  on a table with the industry standard operational risk categories and sub-categories  on rows and some organisational breakdown e.g. region, division on the columns.  These columns are grouped / faceted into three broad categories

- inherent risk
-  controls
-  residual risk


PBI current visuals cannot plot RCSA charts well since they can't do coloured heatmaps of ordinal values but using ggplot to do this  may solve the issue.


## Work To Do

- improve the R code so the ggplot looks good
- build a RCSA PBI dataset and then an Excel sheet using this as source with CUBE() functions




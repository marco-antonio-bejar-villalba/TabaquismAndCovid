library(ggplot2)
library(dplyr)
library(data.table)

data.covid<-fread("210608COVID19MEXICO.csv")
invalidCases<-c(97,98,99)
data.covid[EMBARAZO==97]$EMBARAZO<-2

data.covid<-data.covid[CLASIFICACION_FINAL %in% c(1,2,3),]

data.covid <- data.covid %>% filter(! ASMA %in% invalidCases) %>%
  filter(! OBESIDAD %in% invalidCases) %>%
  filter(! DIABETES %in% invalidCases) %>%
  filter(! EPOC %in% invalidCases) %>%
  filter(! INMUSUPR %in% invalidCases) %>%
  filter(! HIPERTENSION %in% invalidCases) %>%
  filter(! CARDIOVASCULAR %in% invalidCases) %>%
  filter(! TABAQUISMO %in% invalidCases) %>%
  filter(! EMBARAZO %in% invalidCases) %>%
  filter(! OTRA_COM %in% invalidCases) %>%
  filter(! RENAL_CRONICA %in% invalidCases)

data.covid<-mutate(data.covid,DECEASED=ifelse((FECHA_DEF=="9999-99-99"),0,1))


data.covid.cdmx.summarizedbyday<-data.covid[ENTIDAD_RES==9,] %>% 
  mutate(week = cut.Date(FECHA_SINTOMAS, breaks = "1 week", labels = FALSE)) %>%
  count(week)

data.covid.cdmx.diseased.summarizedbyday<-data.covid[DECEASED==1 & ENTIDAD_RES==9,] %>% 
  mutate(week = cut.Date(as.IDate(FECHA_DEF), breaks = "1 week", labels = FALSE)) %>%
  count(week)


####  C O P E P O D O S ###
#Librerías

library(tidyverse)
library(VennDiagram)

#Cargar base de datos

data_copepodos <- read.delim("../data/Outliers1-0.csv", sep = ",")
data_copepodos
head(data_copepodos)

#Separar los outliers para cada población y filtrar los datos, para quedarnos solo con las presencias "1"
#Para ATX:
pop_atx <- data_copepodos[,c(1,2)] %>%
  rowwise() %>%
  filter(sum(c(ATX)) != 0)
pop_atx <- pop_atx[,1]
pop_atx  #Visualizar
#Convertir
write.csv(pop_atx,"../data/pop.atx.csv")
atx <-read.csv("../data/pop.atx.csv")
atx <-atx[,-1]
class(atx)

#Para CAR
pop_car <- data_copepodos[,c(1,3)] %>%
  rowwise() %>%
  filter(sum(c(CAR)) != 0)
pop_car <- pop_car[,1]
pop_car
#Convertir
write.csv(pop_car,"../data/pop.car.csv")
car <-read.csv("../data/pop.car.csv")
car <-car[,-1]
class(car)

#Para PRE
pop_pre <- data_copepodos[,c(1,4)] %>%
  rowwise() %>%
  filter(sum(c(PRE)) != 0)
pop_pre <- pop_pre[,1]
pop_pre
#Convertir
write.csv(pop_pre,"../data/pop.pre.csv")
pre <-read.csv("../data/pop.pre.csv")
pre <-pre[,-1]
class(pre)

#Para QUE
pop_que <- data_copepodos[,c(1,5)] %>%
  rowwise() %>%
  filter(sum(c(QUE)) != 0)
pop_que <- pop_que[,1]
pop_que
#Convertir
write.csv(pop_que,"../data/pop.que.csv")
que <-read.csv("../data/pop.que.csv")
que <-que[,-1]
class(que)

# Esta línea no funciona porque intersect por sí solo, solo permite comparar dos conjuntos de datos
#outliers <- intersect(outl.bay.2pop, outl.bay.8sites, outl.snpstats.2pop, outl.snpstats.8sites, outl.pcadapt)

# En su lugar, utlizamos estamos línea:
outliers_intersect <- Reduce(intersect, list(pop_atx, pop_car, pop_pre, pop_que))
outliers_intersect #Nos muestra que outliers son los compartidos por las cuatro poblaciones

# Prepare a palette of 3 colors with R colorbrewer:
#library(RColorBrewer)
#myCol <- brewer.pal(4, "Pastel2")


######  El diagrama de venn se guardará en la carpeta results/ 
venn.diagram( x = list(atx, car, pre, que), 
             category.names = c("ATX" ,"CAR", "PRE", "QUE"),
             filename = "../results/venn_diagram_copepodos.png",
             output = TRUE ,
             #Output features
             imagetype="png" ,
             height = 880,
             width = 880,
             resolution = 600,
             compression = "lzw",
             #Circles
             lwd = 1,
             lty = "blank",
             fill = c("blue", "red","yellow","green"), #fill= myCol
             #Numbers
             cex = 0.3,
             fontface= "bold",
             fontfamily = "sans",
             #Set names
             cat.cex = 0.4,
             #cat.fontface="bold",
             cat.default.pos = "outer",
             #cat.pos = c(-27, 27, -135),
             #cat.dist = c(0.055, 0.055, 0.085, 0.085),
            cat.fontfamily = "sans",
            #rotation= 1
)



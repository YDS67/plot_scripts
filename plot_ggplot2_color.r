library(ggplot2)

flnm <- paste("t_norm_energy.dat",sep="")

d <- read.table(flnm)

V1 <- d$V1
V2 <- d$V2
V3 <- d$V3

len <- length(V1)

V3 <- V3/V3[1]

#Create a new data frame with "long form" like this:

#___x1___y1___"y"
#___x2___y2___"y"
#___x3___y3___"y"
#___x4___y4___"y"
#___x5___y5___"y"
#___x1___z1___"z"
#___x2___z2___"z"
#___x3___z3___"z"
#___x4___z4___"z"
#___x5___z5___"z"

#This is how ggplot2 works

d1 <- data.frame(x = c(V1, V1), f = c(V2, V3), group = c(rep("Norm",len),rep("Energy",len)))

#Create the plot
g <- ggplot(d1, aes(x = x, y = f, colour = group)) +
#Draw lines
geom_line(linewidth=0.5) + 
#Draw points
#geom_point(size = 2.5) +
#Plot style parameters
theme_bw(base_size = 14) + 
theme(
    #aspect.ratio = 0.618, 
    axis.text.x = element_text(colour = "black"), 
    axis.text.y = element_text(colour = "black", angle = 90, hjust = 0.5)
    ) + 
#Legend parameters
theme(legend.title = element_blank(), legend.text = element_text(size = 14), legend.background = element_rect(colour = "black", fill = "white", linewidth = 0.3)) + 
theme(legend.position = c(0.7, 0.5), legend.spacing.y = unit(5, "pt"), legend.margin=margin(t=0,l=10,b=8,r=10, unit='pt')) + 
guides(colour = guide_legend(byrow = TRUE)) +
#Axes labels
labs(x = "Time, 1/eV", y = expression(paste("Results, a.u.")))

#Show the plot on screen
g

#Export the plot

flnm <- paste("t_norm_energy.png",sep="")

ggsave(flnm, scale = 1, width = 6, height = 5)

flnm <- paste("t_norm_energy.pdf",sep="")

ggsave(flnm, scale = 1, width = 6, height = 5)



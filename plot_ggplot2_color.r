library(ggplot2)

flnm <- paste("dataset_fermi.dat",sep="")

d <- read.table(flnm)

x <- d$V1
y1 <- d$V2
y2 <- d$V3
y3 <- d$V4

len <- length(x)

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

d1 <- data.frame(x = c(x, x, x), f = c(y1, y2, y3), 
    group = c(rep("kT = 0",len),rep("kT = 0.1",len),rep("kT = 0.2",len)))

#Create the plot
g <- ggplot(d1, aes(x = x, y = f, colour = group, linetype = group)) +
#Draw lines
geom_line(linewidth=0.7) + 
#Choose colors and linetypes manually. Can delete the next two lines, then ggplot will pick.
scale_color_manual(values = c("black", "blue", "red")) +
scale_linetype_manual(values = c("dashed", "solid", "longdash")) +
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
theme(legend.position = c(0.8, 0.8), legend.spacing.y = unit(5, "pt"), legend.margin=margin(t=0,l=10,b=8,r=10, unit='pt')) + 
guides(colour = guide_legend(byrow = TRUE)) +
#Axes labels
labs(x = "Energy, a.u.", y = expression(paste("Fermi distribution")))

#Show the plot on screen
g

#Export the plot

flnm <- paste("plot_fermi_2.png",sep="")

ggsave(flnm, scale = 1, width = 6, height = 5)

flnm <- paste("plot_fermi_2.pdf",sep="")

ggsave(flnm, scale = 1, width = 6, height = 5)



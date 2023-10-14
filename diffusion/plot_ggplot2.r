# You need this package!
# if you don't have it, run the code
# install.packages("ggplot2")

library(ggplot2)

data1 <- read.table("diffusion_results_FD.dat")
data2 <- read.table("diffusion_results_RW.dat")

x1 <- data1$V1
y1 <- data1$V2
y2 <- data1$V3
x2 <- data2$V1
y3 <- data2$V2

nms <- c("Exact formula", "Finite difference", "Random walk")

len1 <- length(x1)
len2 <- length(x2)

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

d1 <- data.frame(x = c(x1, x1, x2), f = c(y1, y2, y3), 
    group = c(rep(nms[1], len1), rep(nms[2], len1), rep(nms[3], len2)))

#Create the plot
g <- ggplot(d1, aes(x = x, y = f, colour = group, linetype = group, shape = group)) +
#Draw lines
geom_line(linewidth=0.7) + 
#Choose colors and linetypes manually. Can delete the next two lines, then ggplot will pick.
scale_color_manual(values = c("blue", "red", "black")) +
scale_linetype_manual(values = c("solid", "dashed", "blank")) +
#Draw points
geom_point(size = 2.5) +
scale_shape_manual(values = c(NA, NA, 16)) +
#Plot style parameters
theme_bw(base_size = 14) + 
theme(
    #aspect.ratio = 0.618, 
    axis.text.x = element_text(colour = "black"), 
    axis.text.y = element_text(colour = "black", angle = 90, hjust = 0.5)
    ) + 
#Legend parameters
theme(legend.title = element_blank(), legend.text = element_text(size = 12), 
    legend.background = element_rect(colour = "black", fill = "white", linewidth = 0.3),
    legend.key.width = unit(2.5, "line")) + 
theme(legend.position = c(0.985, 0.87), 
    legend.justification = "right",
    legend.spacing.y = unit(3, "pt"), legend.margin=margin(t=3,l=10,b=7,r=10, unit='pt')
) + 
guides(colour = guide_legend(byrow = TRUE)) +
#Axes labels
labs(x = "z, cm", y = "Number of particles")

#Show the plot on screen
g

#Export the plot

flnm <- paste("plot_diffusion_2.png",sep="")

ggsave(flnm, scale = 1, width = 6, height = 5)

flnm <- paste("plot_diffusion_2.pdf",sep="")

ggsave(flnm, scale = 1, width = 6, height = 5)



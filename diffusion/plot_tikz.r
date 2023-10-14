#Color plot of smooth lines with R base package AND tikzDevice for LaTeX output
# YOU NEED THIS LIBRARY

library(tikzDevice)

# The position of the legend can be specified also using the following keywords:
# "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center".
# The parameter inset is used to create margins



data1 <- read.table("diffusion_results_FD.dat")
data2 <- read.table("diffusion_results_RW.dat")

x1 <- data1$V1
y1 <- data1$V2
y2 <- data1$V3
x2 <- data2$V1
y3 <- data2$V2

nms <- c("Exact formula", "Finite difference", "Random walk")

x_max <- max(x1,x2)
x_min <- min(x1,x2)
x_length <- x_max-x_min

y_max <- max(y1,y2)
y_min <- min(y1,y2)
y_height <- y_max-y_min

cols <- c("blue", "red", "black")
ltys <- c(1, 2, 0)
pchs <- c(NA, NA, 16)
txtsize <- 1.5

filename <- "plot_diffusion_3"

tikz(paste(filename, ".tex", sep = ""), width = 6, height = 5)
par(mar = c(3.2, 3.2, 0.6, 0.6), mgp = c(1.7, 0.5, 0), lwd = 1)
line_width <- 5
psz <- 1

plot(x1, y1, type = "l",
    xlim = c(x_min - x_length*0.1, x_max + x_length*0.1),
    ylim = c(y_min, y_max + y_height*0.1), 
    lwd = line_width, 
    col = cols[1],
    lty = ltys[1], 
    xlab = "$z$, cm", 
    ylab = "$N(z)$",
    cex.axis = 1.2, 
    cex.lab = txtsize)
lines(x1, y2, lwd = line_width, col = cols[2], lty = ltys[2])
points(x2, y3, cex = psz, col = cols[3], pch = pchs[3])

legend("topright", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, 3), 
    lty = ltys,
    pch = pchs,  
    col = cols, 
    cex = 1.3)

text(x = x_min - x_length*0.1, 
    y = y_max,
    cex = txtsize,
    pos = 4,
    labels = "Exact formula: \n \n $\\displaystyle \\frac{N_0}{\\sqrt{4 \\pi D t}} \\exp \\left( - \\frac{z^2}{4 D t} \\right)$"
)

dev.off()

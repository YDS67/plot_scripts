#Color plot of smooth lines with R base package

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

filename <- "plot_diffusion_1"

png(paste(filename, ".png", sep = ""), width = 1800, height = 1500, units = "px", pointsize = 45)
par(mar = c(3.2, 3.2, 0.6, 0.6), mgp = c(1.7, 0.5, 0), lwd = 4)
line_width <- 7
psz <- 1

plot(x1, y1, type = "l",
    xlim = c(x_min - x_length*0.1, x_max + x_length*0.1),
    ylim = c(y_min, y_max + y_height*0.1), 
    lwd = line_width, 
    col = cols[1],
    lty = ltys[1], 
    xlab = "z, cm", 
    ylab = "Number of particles", 
    cex.lab = 1.3)
lines(x1, y2, lwd = line_width, col = cols[2], lty = ltys[2])
points(x2, y3, cex = psz, col = cols[3], pch = pchs[3])

legend("topright", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, 3), 
    lty = ltys,
    pch = pchs, 
    col = cols, 
    cex = 1.3)

dev.off()

pdf(paste(filename, ".pdf", sep = ""), width = 6, height = 5)
par(mar = c(3.2, 3.2, 0.6, 0.6), mgp = c(1.7, 0.5, 0), lwd = 1)
line_width <- 2
psz <- 0.7

plot(x1, y1, type = "l",
    xlim = c(x_min - x_length*0.1, x_max + x_length*0.1),
    ylim = c(y_min, y_max + y_height*0.1), 
    lwd = line_width, 
    col = cols[1],
    lty = ltys[1], 
    xlab = "z, cm", 
    ylab = "Number of particles", 
    cex.lab = 1.0)
lines(x1, y2, lwd = line_width, col = cols[2], lty = ltys[2])
points(x2, y3, cex = psz, col = cols[3], pch = pchs[3])

legend("topright", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, 3), 
    lty = ltys,
    pch = pchs,  
    col = cols, 
    cex = 1.0)

dev.off()

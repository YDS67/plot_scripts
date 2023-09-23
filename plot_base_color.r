#Color plot of smooth lines with R base package

data <- read.table("dataset_smooth.dat")

x <- data$V1
y1 <- data$V2
y2 <- data$V3
y3 <- data$V4

x_max <- max(x)
x_min <- min(x)
x_length <- x_max-x_min

y_max <- max(y1,y2,y3)
y_min <- min(y1,y2,y3)
y_height <- y_max-y_min

png("plot_smooth_1.png", width = 1200, height = 1000, units = "px", pointsize = 30)
par(mar = c(5.1, 5.1, 2.1, 2.1), lwd = 3)
line_width <- 5

plot(x, y1, type = "l", ylim = c(y_min, y_max), 
    lwd = line_width, 
    col = "blue", 
    xlab = "Энергия, усл. ед.", 
    ylab = "Распределение Ферми", 
    cex.lab = 1.5)
lines(x, y2, lwd = line_width, col = "red", lty = 2)
lines(x, y3, lwd = line_width, col = "purple", lty = 4)

legend(x_min + x_length*0.6, y_max - y_height*0.05, 
    legend = c("kT = 0.05", "kT = 0.1", "kT = 0.5"), 
    lwd = rep(line_width, 3), 
    lty = c(1,2,4), 
    col = c("blue", "red", "purple"), 
    cex = 1.2)

dev.off()

pdf("plot_smooth_1.pdf", width = 6, height = 5)
par(mar = c(5.1, 5.1, 2.1, 2.1), lwd = 1)
line_width <- 2

plot(x, y1, type = "l", ylim = c(y_min, y_max), 
    lwd = line_width, 
    col = "blue", 
    xlab = "Energy, a.u.", 
    ylab = "Fermi distribution", 
    cex.lab = 1.2)
lines(x, y2, lwd = line_width, col = "red", lty = 2)
lines(x, y3, lwd = line_width, col = "purple", lty = 4)

legend(x_min + x_length*0.6, y_max - y_height*0.05, 
    legend = c("kT = 0.05", "kT = 0.1", "kT = 0.5"), 
    lwd = rep(line_width, 3), 
    lty = c(1,2,4), 
    col = c("blue", "red", "purple"), 
    cex = 1)

dev.off()

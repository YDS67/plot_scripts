#Color plot of smooth lines with R base package

data <- read.table("dataset_fermi.dat")

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

cols <- c("black", "blue", "red")
ltys <- c(2, 1, 5)

filename <- "plot_fermi_1"

png(paste(filename, ".png", sep = ""), width = 1200, height = 1000, units = "px", pointsize = 30)
par(mar = c(3.2, 3.2, 0.6, 0.6), mgp = c(1.7, 0.5, 0), lwd = 3)
line_width <- 5

plot(x, y1, type = "l", ylim = c(y_min, y_max), 
    lwd = line_width, 
    col = cols[1],
    lty = ltys[1], 
    xlab = "Energy, a.u.", 
    ylab = "Fermi distribution", 
    cex.lab = 1.3)
lines(x, y2, lwd = line_width, col = cols[2], lty = ltys[2])
lines(x, y3, lwd = line_width, col = cols[3], lty = ltys[3])

legend(x_min + x_length*0.7, y_max - y_height*0.05, 
    legend = c("kT = 0", "kT = 0.1", "kT = 0.2"), 
    lwd = rep(line_width, 3), 
    lty = ltys, 
    col = cols, 
    cex = 1.3)

dev.off()

pdf(paste(filename, ".pdf", sep = ""), width = 6, height = 5)
par(mar = c(3.2, 3.2, 0.6, 0.6), mgp = c(1.7, 0.5, 0), lwd = 1)
line_width <- 2

plot(x, y1, type = "l", ylim = c(y_min, y_max), 
    lwd = line_width, 
    col = cols[1],
    lty = ltys[1], 
    xlab = "Energy, a.u.", 
    ylab = "Fermi distribution", 
    cex.lab = 1.0)
lines(x, y2, lwd = line_width, col = cols[2], lty = ltys[2])
lines(x, y3, lwd = line_width, col = cols[3], lty = ltys[3])

legend(x_min + x_length*0.7, y_max - y_height*0.05, 
    legend = c("kT = 0", "kT = 0.1", "kT = 0.2"), 
    lwd = rep(line_width, 3), 
    lty = ltys, 
    col = cols, 
    cex = 1.0)

dev.off()

#Color plot of smooth lines with R base package

# The position of the legend can be specified also using the following keywords:
# "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center".
# The parameter inset is used to create margins

tol <- 1e-9

data1 <- read.table("data/results.dat")

x1 <- data1$V1
z1 <- data1$V5
z2 <- data1$V6
z3 <- data1$V7

z1 <- abs(z1-z1[1])
z2 <- abs(z2-z2[1])
z3 <- abs(z3-z3[1])

#=========================================

nms <- c("Explicit","Implicit 1","Implicit 2")

x_max <- max(x1)
x_min <- min(x1)
x_length <- x_max-x_min
z_max <- max(z1,z2,z3)
z_min <- min(z1,z2,z3)

cols <- c("#0092cc", "#ff3333", "#22af4b")
ltys <- c(1, 1, 1)
pchs <- c(NA, NA, NA)


col_main <- "#282828"
lwd_main <- 5
axis_label_size <- 1.8
legend_font_size <- 1.5
tick_font_size <- 1.3
title_font_size <- 1.5

filename <- paste("dp_energy", sep="")

png(paste(filename, ".png", sep = ""), width = 2000, height = 2000, units = "px", pointsize = 45)
# par(mar = c(bottom, left, top, right))
par(mar = c(4.0, 4.2, 3.2, 0.6), mgp = c(2.5, 0.6, 0), lwd = lwd_main, 
    bg = "#ffffff", col = col_main, col.lab = col_main, col.axis = col_main, col.main = col_main)

line_width <- 9
psz <- 1

plot(0, 0, pch = NA, # log = "y",
    xlim = c(x_min, x_max), ylim = c(z_min, z_max), 
    xlab = "Time, a.u.", 
    ylab = "Total energy, a.u.", 
    main = paste("Runge-Kutta methods for double pendulum", sep=""),
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

grid(nx = 10, ny = 10, col = "lightgray", lty = 2, lwd = 0.5*line_width, equilogs = FALSE)

lines(x1, z1, lwd = line_width, col = cols[1], lty = ltys[1])
lines(x1, z2, lwd = line_width, col = cols[2], lty = ltys[2])
lines(x1, z3, lwd = line_width, col = cols[3], lty = ltys[3])


legend("topleft", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, 3), 
    lty = ltys,
    pch = pchs, 
    col = cols, 
    cex = legend_font_size,
    box.col = col_main)

dev.off()
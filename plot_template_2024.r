# Generate some data
# Distributions
lorenz <- function(x,a){a/pi/(a^2+x^2)}
gauss <- function(x,a){exp(-x^2/a^2/2)/a/sqrt(2*pi)}
sech <- function(x,a){1/a/pi/cosh(x/a)}
a <- 2
# Parameters
x_min <- -10
x_max <- 10
Nx <- 500
# Exact functions for plotting
dx <- (x_max-x_min)/Nx
x <- x_min + (1:Nx)*dx - dx/2
y1 <- lorenz(x,a)
y2 <- gauss(x,a)
y3 <- sech(x,a)
# Write data
d <- data.frame(x,y1,y2,y3)
write.table(d, "exact_distributions.dat", row.names=FALSE, col.names=FALSE)
#===================
# Read data
#===================
d <- read.table("exact_distributions.dat")
x <- d$V1
y1 <- d$V2
y2 <- d$V3
y3 <- d$V4
#===================
# Plot parameters general
#===================
width = 8
height = 6
col_main <- "#282828"
lwd_main <- 1
axis_label_size <- 1
legend_font_size <- 1
tick_font_size <- 11/12
title_font_size <- 14/12
line_width <- 2
psz <- 1
#===================
# Plot 1 - compare distributions
#===================
filename <- paste("Distributions_compare", sep="")
x_name <- "x, усл.ед."
y_name <- "Распределение, норм."
number_of_lines <- 3
nms <- c("Лоренц","Гаусс","1/cosh")
cols <- c("#0092cc", "#ff3333", "#22af4b")
ltys <- c(1, 1, 1)
pchs <- c(NA, NA, NA)
x_min <- min(x)
x_max <- max(x)
y_min <- min(y1,y2,y3)
y_max <- max(y1,y2,y3)
cairo_pdf(paste(filename, ".pdf", sep = ""), width = width, height = height)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 0.6, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main,
    bg = "#ffffff", col = col_main, col.lab = col_main, 
    col.axis = col_main, col.main = col_main
)

plot(0, 0, pch = NA, # log = "y",
    ylim = c(y_min, y_max), xlim = c(x_min, x_max),
    xlab = x_name, 
    ylab = y_name, 
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size
)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

grid(nx = 5, ny = 5, col = "lightgray", lty = 2, lwd = 0.5*line_width, equilogs = FALSE)

lines(x, y1, lwd = line_width, col = cols[1], lty = ltys[1])
lines(x, y2, lwd = line_width, col = cols[2], lty = ltys[2])
lines(x, y3, lwd = line_width, col = cols[3], lty = ltys[3])

legend("topright", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, number_of_lines), 
    lty = ltys,
    pch = pchs, 
    col = cols, 
    cex = legend_font_size,
    box.col = col_main
)

dev.off()


# Generate some data
# Generate random particles from a distribution
grp <- function(distr, a, N_particles, x_min, x_max){
    particles <- NULL
    Np <- 0
    while(Np < N_particles){
        # Two random numbers between 0 and 1
        r1 <- runif(1)
        r2 <- runif(1)
        # Pick a random point between x_min and x_max
        x <- x_min + (x_max-x_min)*r1
        f <- distr(x,a)
        if(f > r2*l0){
            particles <- c(particles, x)
            Np <- Np+1
        }
    }
    particles
}
# Put random numbers into bins
bin <- function(particles,x_min,dx,N_bins){
    y <- rep(0,N_bins)
    for(p in particles){
        j <- floor((p-x_min)/dx)
        if(j>=0 && j<N_bins){
            y[j+1] <- y[j+1]+1
        }   
    }
    y
}
# Distributions
lorenz <- function(x,a){a/pi/(a^2+x^2)}
gauss <- function(x,a){exp(-x^2/a^2/2)/a/sqrt(2*pi)}
sech <- function(x,a){1/a/pi/cosh(x/a)}
a <- 2
l0 <- lorenz(0,a)
g0 <- gauss(0,a)
s0 <- sech(0,a)
# Parameters
x_min <- -10
x_max <- 10
Nx <- 500
N_particles <- 2000
N_bins <- 20
# Exact functions for plotting
dx <- (x_max-x_min)/Nx
x <- x_min + (1:Nx)*dx - dx/2
y1 <- lorenz(x,a)
y2 <- gauss(x,a)
y3 <- sech(x,a)
# Write data
d <- data.frame(x,y1,y2,y3)
write.table(d, "exact_distributions.dat", row.names=FALSE, col.names=FALSE)
# Generate random particles from the distributions
particles_lorenz <- grp(lorenz, a, N_particles, x_min, x_max)
particles_gauss <- grp(gauss, a, N_particles, x_min, x_max)
particles_sech <- grp(sech, a, N_particles, x_min, x_max)
# Write data
d <- data.frame(particles_lorenz, particles_gauss, particles_sech)
write.table(d, "particles.dat", row.names=FALSE, col.names=FALSE)
# Create "experimental" distributions for histograms
dx <- (x_max-x_min)/N_bins
x <- x_min + (1:N_bins)*dx - dx/2
y1 <- bin(particles_lorenz,x_min,dx,N_bins)/N_particles/dx
y2 <- bin(particles_gauss,x_min,dx,N_bins)/N_particles/dx
y3 <- bin(particles_sech,x_min,dx,N_bins)/N_particles/dx
# Write data
d <- data.frame(x,y1,y2,y3)
write.table(d, "approx_distributions.dat", row.names=FALSE, col.names=FALSE)
#===================
# Read data
#===================
d <- read.table("exact_distributions.dat")
xe <- d$V1
ye1 <- d$V2
ye2 <- d$V3
ye3 <- d$V4
d <- read.table("approx_distributions.dat")
xa <- d$V1
ya1 <- d$V2
ya2 <- d$V3
ya3 <- d$V4
d <- read.table("particles.dat")
p1 <- d$V1
p2 <- d$V2
p3 <- d$V3
#===================
# Plot parameters general
#===================
width = 6
height = 4
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
x_min <- min(xe)
x_max <- max(xe)
y_min <- min(ye1,ye2,ye3)
y_max <- max(ye1,ye2,ye3)
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

lines(xe, ye1, lwd = line_width, col = cols[1], lty = ltys[1])
lines(xe, ye2, lwd = line_width, col = cols[2], lty = ltys[2])
lines(xe, ye3, lwd = line_width, col = cols[3], lty = ltys[3])

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
#===================
# Plot 2 - compare with approximate, Lorenz
#===================
filename <- paste("Lorenz_distribution", sep="")
x_name <- "x, усл.ед."
y_name <- "Распределение, норм."
number_of_lines <- 2
nms <- c("Точная формула","Случ. выборка")
cols <- c("#0092cc", "#ff3333")
ltys <- c(1, NA)
pchs <- c(NA, 16)
x_min <- min(xe)
x_max <- max(xe)
y_min <- min(ye1)
y_max <- max(ye1)
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

lines(xe, ye1, lwd = line_width, col = cols[1], lty = ltys[1])
points(xa, ya1, cex = psz, col = cols[2], pch = pchs[2])

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
#===================
# Plot 3 - compare with histogram, Lorenz
#===================
filename <- paste("Lorenz_distribution_hist", sep="")
x_name <- "x, усл.ед."
y_name <- "Распределение, норм."
number_of_lines <- 1
nms <- c("Точная формула")
cols <- c("#22af4b")
ltys <- c(1)
pchs <- c(NA)
cairo_pdf(paste(filename, ".pdf", sep = ""), width = width, height = height)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 0.6, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main,
    bg = "#ffffff", col = col_main, col.lab = col_main, 
    col.axis = col_main, col.main = col_main
)

hist(p1, breaks = N_bins, freq = FALSE, main = NA, # log = "y",
    ylim = c(y_min, y_max), xlim = c(x_min, x_max),
    xlab = x_name, 
    ylab = y_name, 
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size,
    col = "#f0f0f0"
)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
#grid(nx = 5, ny = 5, col = "lightgray", lty = 2, lwd = 0.5*line_width, equilogs = FALSE)

lines(xe, ye1, lwd = line_width, col = cols[1], lty = ltys[1])

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
#===================
# Plot 2 - compare with approximate, Gauss
#===================
filename <- paste("Gauss_distribution", sep="")
x_name <- "x, усл.ед."
y_name <- "Распределение, норм."
number_of_lines <- 2
nms <- c("Точная формула","Случ. выборка")
cols <- c("#0092cc", "#ff3333")
ltys <- c(1, NA)
pchs <- c(NA, 16)
x_min <- min(xe)
x_max <- max(xe)
y_min <- min(ye2)
y_max <- max(ye2)
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

lines(xe, ye2, lwd = line_width, col = cols[1], lty = ltys[1])
points(xa, ya2, cex = psz, col = cols[2], pch = pchs[2])

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
#===================
# Plot 3 - compare with histogram, Gauss
#===================
filename <- paste("Gauss_distribution_hist", sep="")
x_name <- "x, усл.ед."
y_name <- "Распределение, норм."
number_of_lines <- 1
nms <- c("Точная формула")
cols <- c("#22af4b")
ltys <- c(1)
pchs <- c(NA)
cairo_pdf(paste(filename, ".pdf", sep = ""), width = width, height = height)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 0.6, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main,
    bg = "#ffffff", col = col_main, col.lab = col_main, 
    col.axis = col_main, col.main = col_main
)

hist(p2, breaks = N_bins, freq = FALSE, main = NA, # log = "y",
    ylim = c(y_min, y_max), xlim = c(x_min, x_max),
    xlab = x_name, 
    ylab = y_name, 
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size,
    col = "#f0f0f0"
)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
#grid(nx = 5, ny = 5, col = "lightgray", lty = 2, lwd = 0.5*line_width, equilogs = FALSE)

lines(xe, ye2, lwd = line_width, col = cols[1], lty = ltys[1])

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

#===================
# Plot 2 - compare with approximate, Sech
#===================
filename <- paste("Sech_distribution", sep="")
x_name <- "x, усл.ед."
y_name <- "Распределение, норм."
number_of_lines <- 2
nms <- c("Точная формула","Случ. выборка")
cols <- c("#0092cc", "#ff3333")
ltys <- c(1, NA)
pchs <- c(NA, 16)
x_min <- min(xe)
x_max <- max(xe)
y_min <- min(ye3)
y_max <- max(ye3)
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

lines(xe, ye3, lwd = line_width, col = cols[1], lty = ltys[1])
points(xa, ya3, cex = psz, col = cols[2], pch = pchs[2])

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
#===================
# Plot 3 - compare with histogram, Sech
#===================
filename <- paste("Sech_distribution_hist", sep="")
x_name <- "x, усл.ед."
y_name <- "Распределение, норм."
number_of_lines <- 1
nms <- c("Точная формула")
cols <- c("#22af4b")
ltys <- c(1)
pchs <- c(NA)
cairo_pdf(paste(filename, ".pdf", sep = ""), width = width, height = height)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 0.6, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main,
    bg = "#ffffff", col = col_main, col.lab = col_main, 
    col.axis = col_main, col.main = col_main
)

hist(p3, breaks = N_bins, freq = FALSE, main = NA, # log = "y",
    ylim = c(y_min, y_max), xlim = c(x_min, x_max),
    xlab = x_name, 
    ylab = y_name, 
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size,
    col = "#f0f0f0"
)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
#grid(nx = 5, ny = 5, col = "lightgray", lty = 2, lwd = 0.5*line_width, equilogs = FALSE)

lines(xe, ye3, lwd = line_width, col = cols[1], lty = ltys[1])

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

#Color plot of smooth lines with R base package

# The position of the legend can be specified also using the following keywords:
# "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center".
# The parameter inset is used to create margins

tol <- 1e-9

a <- 15
a1 <- 20
b1 <- 8
R <- 2*a1*b1*sqrt((log(a1)-log(b1))/(a1^2-b1^2))
A <- (1+R^2/a1^2)*exp(-R^2/a1^2) - (1+R^2/b1^2)*exp(-R^2/b1^2)

xmax <- 50
Nx <- 1000

x <- -xmax + (1:Nx)/Nx*2*xmax
y <- x

UQD <- function(x, y){(1+x^2/a^2+y^2/a^2)*exp(-x^2/a^2-y^2/a^2)}
UQR <- function(x, y){((1+x^2/a1^2+y^2/a1^2)*exp(-x^2/a1^2-y^2/a1^2) - (1+x^2/b1^2+y^2/b1^2)*exp(-x^2/b1^2-y^2/b1^2))/A}

z1 <- UQD(x,0)
z2 <- UQR(x,0)

u1 <- outer(x,y,FUN = UQD)
u2 <- outer(x,y,FUN = UQR)

#=========================================

nms <- c("КТ","КК")

x_max <- max(x)
x_min <- min(x)
x_length <- x_max-x_min
z_max <- max(z1,z2)
z_min <- min(z1,z2)

number_of_lines <- 2

cols <- c("#0092cc", "#ff3333")
ltys <- c(1, 1)
pchs <- c(NA, NA)


col_main <- "#282828"
lwd_main <- 5
axis_label_size <- 1.8
legend_font_size <- 1.5
tick_font_size <- 1.3
title_font_size <- 1.5

filename <- paste("qd_qr_potential_", sep="")

png(paste(filename, "1d.png", sep = ""), width = 2000, height = 2000, units = "px", pointsize = 45)
# par(mar = c(bottom, left, top, right))
par(mar = c(4.0, 4.2, 3.2, 0.6), mgp = c(2.5, 0.6, 0), lwd = lwd_main, family = "Times",
    bg = "#ffffff", col = col_main, col.lab = col_main, col.axis = col_main, col.main = col_main)

line_width <- 9
psz <- 1

plot(0, 0, pch = NA, # log = "y",
    xlim = c(x_min, x_max), ylim = c(z_min, z_max), 
    xlab = "x, нм", 
    ylab = "z(x,0), a.u.", 
    main = paste("Радиус КК: ", format(R, digits=2), " нм"),
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

grid(nx = 10, ny = 10, col = "lightgray", lty = 2, lwd = 0.5*line_width, equilogs = FALSE)

lines(x, z1, lwd = line_width, col = cols[1], lty = ltys[1])
lines(x, z2, lwd = line_width, col = cols[2], lty = ltys[2])

legend("bottomright", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, number_of_lines), 
    lty = ltys,
    pch = pchs, 
    col = cols, 
    cex = legend_font_size,
    box.col = col_main)

dev.off()


png(paste("qd_potential_2d.png", sep = ""), width = 2000, height = 2000, units = "px", pointsize = 45)
# par(mar = c(bottom, left, top, right))
par(mar = c(4.0, 4.2, 0.6, 0.6), mgp = c(2.5, 0.6, 0), lwd = lwd_main, family = "Times",
    bg = "#ffffff", col = col_main, col.lab = col_main, col.axis = col_main, col.main = col_main)

line_width <- 9
psz <- 1

image(x, y, u1,
    xlab = "x, нм", 
    ylab = "y, нм", 
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size,
    col = hcl.colors(100, "RdBu", rev = TRUE),
    useRaster = TRUE)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

dev.off()


png(paste("qr_potential_2d.png", sep = ""), width = 2000, height = 2000, units = "px", pointsize = 45)
# par(mar = c(bottom, left, top, right))
par(mar = c(4.0, 4.2, 0.6, 0.6), mgp = c(2.5, 0.6, 0), lwd = lwd_main, family = "Times",
    bg = "#ffffff", col = col_main, col.lab = col_main, col.axis = col_main, col.main = col_main)

line_width <- 9
psz <- 1

image(x, y, u2,
    xlab = "x, нм", 
    ylab = "y, нм", 
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size,
    col = hcl.colors(100, "RdBu", rev = TRUE),
    useRaster = TRUE)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

dev.off()

# PDF изображения

nms <- c("КТ","КК")

lwd_main <- 1
axis_label_size <- 14/12
legend_font_size <- 12/12
tick_font_size <- 1
title_font_size <- 12/12

filename <- paste("qd_qr_potential_", sep="")

cairo_pdf(paste(filename, "1d.pdf", sep = ""), width = 6, height = 4)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 2.5, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main, family = "Times",
    bg = "#ffffff", col = col_main, col.lab = col_main, col.axis = col_main, col.main = col_main)

line_width <- 2
psz <- 1

plot(0, 0, pch = NA, # log = "y",
    xlim = c(x_min, x_max), ylim = c(z_min, z_max), 
    xlab = "x, нм", 
    ylab = expression(paste("z(x,0)/", z[0])), 
    main = paste("Радиус КК: ", format(R, digits=2), " нм"),
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

grid(nx = 10, ny = 10, col = "lightgray", lty = 2, lwd = 0.5*line_width, equilogs = FALSE)

lines(x, z1, lwd = line_width, col = cols[1], lty = ltys[1])
lines(x, z2, lwd = line_width, col = cols[2], lty = ltys[2])

legend("topright", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, number_of_lines), 
    lty = ltys,
    pch = pchs, 
    col = cols, 
    cex = legend_font_size,
    box.col = col_main)

dev.off()

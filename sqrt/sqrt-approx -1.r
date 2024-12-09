a <- exp(-1)
b <- pi
exact <- function(x){
    sqrt(x+1i*a)/sqrt(x+1i*b)
}
appr <- function(x){
    (4*x+1i*(3*a+b))/(4*x+1i*(3*b+a))
}
dif <- function(x){
    -1/32*(a-b)^3/x^3*(1i+(a+2*b)/x)
}

xmin <- -20
xmax <- 20
Nx <- 1000
x <- xmin + (xmax-xmin)*(1:Nx-1/2)/Nx

ex <- exact(x)
ax <- appr(x)
dx <- dif(x)


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
# Plot 1
#===================
x <- x
y1 <- Re(ex-ax)
y2 <- Im(ex-ax)
y3 <- Re(dx)
y4 <- Im(dx)
filename <- paste("sqrt-approx", sep="")
x_name <- "x"
y_name <- "f(x)"
number_of_lines <- 4
mains <- expression(sqrt((x+i/e)/(x+i*pi))-(4*x+i*(3/e+pi))/(4*x+i*(1/e+3*pi)))
nms <- c("Re","Im", expression(Re(A/x^3+B/x^4)), expression(Im(A/x^3+B/x^4)))
cols <- c("#0092cc", "#ff3333", "#22af4b", "#888888")
ltys <- c(1, 1, 2, 2)
pchs <- c(NA, NA, NA, NA)
x_min <- min(x)
x_max <- max(x)
y_min <- min(y1,y2)
y_max <- max(y1,y2)

#cairo_pdf(paste(filename, ".pdf", sep = ""), width = width, height = height)
png(paste(filename, ".png", sep = ""), width = width, height = height, units = "in", res = 300)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 3.5, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main,
    bg = "#ffffff", col = col_main, col.lab = col_main, 
    col.axis = col_main, col.main = col_main
)

plot(0, 0, pch = NA, # log = "y",
    ylim = c(y_min, y_max), xlim = c(x_min, x_max),
    xlab = x_name, 
    ylab = y_name, 
    main = mains,
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
lines(x, y4, lwd = line_width, col = cols[4], lty = ltys[4])

abline(v = 3*abs(a-b), lwd = line_width, col = "black", lty = 3)
abline(v = -3*abs(a-b), lwd = line_width, col = "black", lty = 3)

legend("topleft", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, number_of_lines), 
    lty = ltys,
    pch = pchs, 
    col = cols, 
    cex = legend_font_size,
    box.col = col_main
)

dev.off()

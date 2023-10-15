#Color plot of smooth lines with R base package

# The position of the legend can be specified also using the following keywords:
# "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center".
# The parameter inset is used to create margins

data1 <- read.table("data/initial_functions.dat")

x1 <- data1$V1
y1 <- data1$V2
y2 <- data1$V3

nms <- c(expression(sin(t^2)), expression(cos(t^2)))

x_max <- max(x1)
x_min <- min(x1)
x_length <- x_max-x_min

y_max <- max(y1, y2)
y_min <- min(y1, y2)
y_height <- y_max-y_min

cols <- c("#0092cc", "#ff3333")
ltys <- c(1, 1)
pchs <- c(NA, NA)

col_main <- "#f0f0f0"

filename <- "images/plot_initial"

png(paste(filename, ".png", sep = ""), width = 2000, height = 900, units = "px", pointsize = 45)
par(mar = c(3.2, 3.2, 0.6, 0.6), mgp = c(1.7, 0.5, 0), lwd = 3, 
    bg = "black", col = col_main, col.lab = col_main, col.axis = col_main)

line_width <- 5
psz <- 1

plot(x1, y1, type = "l",
    xlim = c(x_min, x_max),
    ylim = c(y_min - y_height*0.1, y_max + y_height*0.1), 
    lwd = line_width, 
    col = cols[1],
    lty = ltys[1], 
    xlab = "t", 
    ylab = "f(t)", 
    cex.lab = 1.3)

axis(1, col.ticks=col_main, lwd = 3, lwd.ticks = 3, col = col_main)
axis(2, col.ticks=col_main, lwd = 3, lwd.ticks = 3, col = col_main)


lines(x1, y2, lwd = line_width, col = cols[2], lty = ltys[2])
abline(h=0, lwd = line_width, lty = 2)

legend("bottomleft", inset = 0.02, 
    legend = nms, 
    lwd = rep(line_width, 2), 
    lty = ltys,
    pch = pchs, 
    col = cols, 
    cex = 1.3,
    box.col = col_main)



dev.off()
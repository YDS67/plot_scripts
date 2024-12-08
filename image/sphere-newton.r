ratio <- function(mu,sigma,rho,tau,theta){
    (mu^3-3*rho*cos(theta)*mu^2+((3-2*sin(theta)^2)*rho^2+sigma-tau)*mu-rho*(rho^2-tau)*cos(theta)-sigma)/(3*mu^2-6*rho*cos(theta)*mu+(3-2*sin(theta)^2)*rho^2+sigma-tau)
}
#coeffs <- function(rho,sigma,tau){c(-rho*(rho^2-tau)-sigma,3*rho^2+sigma-tau,-3*rho,1)}
newton <- function(maxIt,tol,sigma,rho,tau,theta){
    mu1 <- 1
    it <- maxIt
    for(j in 1:maxIt){
        mu2 <- mu1 - ratio(mu1,sigma,rho,tau,theta)
        if(abs(mu2-mu1) < tol){
            it <- j
            break
        }
        mu1 <- mu2
    }
    list(mu2,it,abs(mu2-mu1))
}

maxIt <- 30
tol <- 1e-4
rhos <- 2 + 1:100/100 * 3
thetas <- 1:100/100*pi/2-1/100
sigma <- 0.1
tau <- 1
mus <- matrix(rep(0),100,100)
its <- matrix(rep(0),100,100)

for(n in 1:100){
    for(m in 1:100){
    res <- newton(maxIt,tol,sigma,rhos[n],tau,thetas[m])
    mus[n,m] <- res[[1]]
    its[n,m] <- res[[2]]
    }
}

#===================
# Plot parameters general
#===================
width = 8
height = 7
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
x <- rhos
y <- thetas
z <- mus
filename <- paste("Sphere-Newton-Mu-image", sep="")
x_name <- expression(rho)
y_name <- expression(theta)
z_name <- expression(mu)
mains <- expression(paste(tau,"=1, ",sigma,"=0.1"))
x_min <- min(x)
x_max <- max(x)
y_min <- min(y)
y_max <- max(y)
z_min <- min(z)
z_max <- max(z)

#cairo_pdf(paste(filename, ".pdf", sep = ""), width = width, height = height)
png(paste(filename, ".png", sep = ""), width = width, height = height, units = "in", res = 300)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 3.5, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main,
    bg = "#ffffff", col = col_main, col.lab = col_main, 
    col.axis = col_main, col.main = col_main
)

layout( matrix(c(1,2), ncol=2), widths=c(7,1) )

image(x, y, z, col = hcl.colors(100, "RdBu", rev = TRUE),
    ylim = c(y_min, y_max), xlim = c(x_min, x_max),
    xlab = x_name, 
    ylab = y_name, 
    main = mains,
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size, useRaster = TRUE
)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

z_bar <- z_min + (z_max-z_min)*(0:99)/99

image(c(0,1,2), z_bar, t(matrix(rep(z_bar),100,3)), col = hcl.colors(100, "RdBu", rev = TRUE),
    ylim = c(z_min, z_max), xlim = c(0, 2),
    xlab = "", 
    ylab = z_name, 
    #main = mains,
    xaxt = "n",
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size, useRaster = TRUE
)

dev.off()

#===================
# Plot 2
#===================
x <- rhos
y <- thetas
z <- its
filename <- paste("Sphere-Newton-It-image", sep="")
x_name <- expression(rho)
y_name <- expression(theta)
z_name <- "Iterations"
mains <- expression(paste(tau,"=1, ",sigma,"=0.1"))
x_min <- min(x)
x_max <- max(x)
y_min <- min(y)
y_max <- max(y)
z_min <- min(z)
z_max <- max(z)

#cairo_pdf(paste(filename, ".pdf", sep = ""), width = width, height = height)
png(paste(filename, ".png", sep = ""), width = width, height = height, units = "in", res = 300)
# par(mar = c(bottom, left, top, right))
par(mar = c(3.5, 3.5, 3.5, 0.6), mgp = c(2, 0.6, 0), lwd = lwd_main,
    bg = "#ffffff", col = col_main, col.lab = col_main, 
    col.axis = col_main, col.main = col_main
)

layout( matrix(c(1,2), ncol=2), widths=c(7,1) )

image(x, y, z, col = hcl.colors(100, "RdBu", rev = TRUE),
    ylim = c(y_min, y_max), xlim = c(x_min, x_max),
    xlab = x_name, 
    ylab = y_name, 
    main = mains,
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size, useRaster = TRUE
)

axis(1, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)
axis(2, col.ticks = col_main, lwd = lwd_main, lwd.ticks = lwd_main, col = col_main, labels = FALSE)

z_bar <- z_min + (z_max-z_min)*(0:99)/99

image(c(0,1,2), z_bar, t(matrix(rep(z_bar),100,3)), col = hcl.colors(100, "RdBu", rev = TRUE),
    ylim = c(z_min, z_max), xlim = c(0, 2),
    xlab = "", 
    ylab = z_name, 
    #main = mains,
    xaxt = "n",
    cex.axis = tick_font_size,
    cex.main = title_font_size,
    cex.lab = axis_label_size, useRaster = TRUE
)

dev.off()

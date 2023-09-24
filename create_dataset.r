fermi <- function(x,temp){1/(1+exp(x/temp))}

filename <- "dataset_fermi.dat"

n_points <- 100

x <- (-n_points):(n_points) / n_points

y1 <- c(rep(1, n_points), 0.5, rep(0, n_points))
y2 <- fermi(x,0.1)
y3 <- fermi(x,0.2)

data <- data.frame(x, y1, y2, y3)

write.table(data, filename, row.names = FALSE, col.names = FALSE)


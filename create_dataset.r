filename <- "dataset_smooth.dat"

n_points <- 100

fermi <- function(x,temp){1/(1+exp(x/temp))}

x <- (-n_points):(n_points) / n_points

y1 <- fermi(x,0.05)
y2 <- fermi(x,0.1)
y3 <- fermi(x,0.5)

data <- data.frame(x, y1, y2, y3)

write.table(data, filename, row.names = FALSE, col.names = FALSE)

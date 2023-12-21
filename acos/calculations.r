# Вычисление

t_min <- -1
t_max <- 1

n_t <- 100

t_j <- (-n_t):n_t / n_t

a <- acos(t_j)

b <- t_j

for (j in (-n_t):0) {
	b[j+n_t+1] <- pi - pi/2 * sqrt(1+t_j[j+n_t+1])
}

for (j in 1:n_t) {
	b[j+n_t+1] <- pi/2 * sqrt(1-t_j[j+n_t+1])
}

d <- data.frame(t_j, a, b)

write.table(d, "data/initial_functions.dat", col.names = FALSE, row.names = FALSE)


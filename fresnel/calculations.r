# Вычисление интегралов Френеля

# Вычисление подынтегральных функций

t_max <- 10

n_t <- 1000

t_j <- 1:n_t / n_t * t_max

s_j <- sin(t_j^2)

c_j <- cos(t_j^2)

d <- data.frame(t_j, s_j, c_j)

write.table(d, "data/initial_functions.dat", col.names = FALSE, row.names = FALSE)


# Create a function to generate Chebyshev polynomials
chebyshev_polynomials <- function(x, degree) {
  T <- matrix(0, nrow = length(x), ncol = degree + 1)
  T[,1] <- 1  # T0(x)
  T[,2] <- x  # T1(x)
  
  for (n in 2:degree) {
    T[,n+1] <- 2 * x * T[,n] - T[,n-1]  # Recurrence relation
  }
  
  return(T)
}

# Generate some example data (for illustration)
set.seed(123)
x <- seq(-1, 1, length.out = 100)
y <- cos(4*x)  # Quadratic function with noise

# Transform x to the Chebyshev basis (Chebyshev polynomials of degree 5)
degree <- 5
chebyshev_matrix <- chebyshev_polynomials(x, degree)

# Fit a linear regression model using the Chebyshev polynomials as predictors
model <- lm(y ~ chebyshev_matrix - 1)  # -1 to remove the intercept, since T0(x) = 1

# Summary of the model
summary(model)

# Predict the fitted values
y_hat <- predict(model)

# Plot the data and the fitted curve
library(ggplot2)
ggplot(data = data.frame(x = x, y = y), aes(x, y)) +
  geom_point() +
  geom_line(aes(x = x, y = y_hat), color = "blue") +
  labs(title = "Chebyshev Polynomial Regression", x = "x", y = "y") +
  theme_bw()

# Save the plot as a PNG file
ggsave("chebyshev.png", width = 8, height = 6, dpi = 300)
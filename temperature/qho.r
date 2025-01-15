# Load necessary libraries
library(ggplot2)

# Define the Hermite polynomial H_n(x)
hermite <- function(n, x) {
  if (n == 0) {
    return(1)
  } else if (n == 1) {
    return(2 * x)
  } else {
    return(2 * x * hermite(n - 1, x) - 2 * (n - 1) * hermite(n - 2, x))
  }
}

# Normalize the wavefunction
normalize_wavefunction <- function(n) {
  return(1 / sqrt(2^n * factorial(n) * sqrt(pi)))
}

# Define the wavefunction for the quantum harmonic oscillator
wavefunction <- function(n, x) {
  N_n <- normalize_wavefunction(n)
  return(N_n * exp(-x^2 / 2) * hermite(n, x))
}

# Set the range for x values (the space where the wavefunctions are plotted)
x_vals <- seq(-5, 5, length.out = 1000)

# Set the quantum numbers for the first five levels
n_levels <- 0:4

# Compute the wavefunctions and energy levels
energy_levels <- (n_levels + 0.5)
wavefunctions <- sapply(n_levels, function(n) wavefunction(n, x_vals))

# Potential curve for the quantum harmonic oscillator (V(x) = 0.5 * x^2)
potential_curve <- 0.5 * x_vals^2

# Create a data frame for plotting
data <- data.frame(
  x = rep(x_vals, times = length(n_levels)),
  y = c(wavefunctions) + rep(energy_levels, each = length(x_vals)),  # Shift wavefunctions by their energy levels
  n = factor(rep(n_levels, each = length(x_vals))),
  p = potential_curve/max(potential_curve)*max(energy_levels),
  energy = rep(energy_levels, each = length(x_vals))
)

# Plot the wavefunctions and annotate the energy levels
ggplot(data, aes(x = x, y = y, color = n)) +
  geom_line() +
  # Add the potential energy curve
  geom_line(aes(x = x, y = p), color = "black") +
  # Add horizontal lines for each energy level in the same color as the wavefunction
  geom_hline(aes(yintercept = energy, color = n), linetype = "dashed") +
  labs(title = "Quantum Harmonic Oscillator Wavefunctions",
       subtitle = "First 5 Energy Levels",
       x = "Position (x)", y = "Wavefunction",
       color = "Quantum Number (n)") +
  theme_bw() +
  theme(legend.position = "top")

# Save the plot as a PNG file
ggsave("qho.png", width = 8, height = 8, dpi = 300)
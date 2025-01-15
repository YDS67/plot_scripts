# Load necessary libraries
library(ggplot2)

# Data for the smiley face
smiley_data <- data.frame(
  x = c(0, -0.35, 0.35, 0, 0),
  y = c(0, 0.35, 0.35, -0.2, -0.6),
  type = c("head", "left_eye", "right_eye", "mouth", "smile")
)

# Create the plot
p <- ggplot() +
  # Draw the face (circle)
  geom_polygon(data = data.frame(
    x = cos(seq(0, 2 * pi, length.out = 100)), 
    y = sin(seq(0, 2 * pi, length.out = 100))
  ), aes(x = x, y = y), fill = "yellow", color = "black", size = 2) +
  # Draw eyes
  geom_point(data = smiley_data[smiley_data$type %in% c("left_eye", "right_eye"), ],
             aes(x = x, y = y), 
             size = 5, 
             color = "black") +
  # Draw the smile (positive curvature for an upward smile)
  geom_curve(data = smiley_data[smiley_data$type == "smile", ],
             aes(x = -0.35, y = -0.35, xend = 0.35, yend = -0.35), 
             curvature = 0.3,  # Positive curvature for a smile
             size = 2, 
             color = "black") +
  coord_fixed(ratio = 1) +
  theme_void() +
  theme(plot.background = element_rect(fill = "white", color = "white")) +
  theme(plot.margin = margin(20, 20, 20, 20))

# Save the plot as a PNG file
ggsave("smiley_face.png", plot = p, width = 8, height = 6, dpi = 300)
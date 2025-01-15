# Load necessary library
library(ggplot2)

# Load the data (replace "path/to/your/data.csv" with your actual file path)
data_file <- "global_temp.dat"
climate_data <- read.table(data_file)
climate_data <- data.frame(climate_data$V1, climate_data$V2)

# Check the structure of the data
str(climate_data)

# Ensure the data contains the required columns: Year and AvgTemperature
# If column names are different, adjust accordingly (e.g., rename them)
colnames(climate_data) <- c("Year", "AvgTemperature") # Rename columns if needed

# Plot the data

p <- ggplot(data = climate_data, aes(x = Year, y = AvgTemperature)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Average Global Temperature Over Time",
       x = "Year",
       y = "Average Temperature (°C)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot as a PNG file
ggsave("temperature_plot.png", plot = p, width = 8, height = 6, dpi = 300)
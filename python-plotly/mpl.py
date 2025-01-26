import numpy as np
import matplotlib.pyplot as plt

# Enable LaTeX rendering in Matplotlib
from matplotlib.pyplot import rc
rc('text', usetex=True)
rc('font', family='Times')
#rc('text.latex',unicode=True)
rc('text.latex', preamble=r'\usepackage[utf8]{inputenc}')
rc('text.latex', preamble=r'\usepackage[russian]{babel}')

# Generate some example data
x = np.linspace(0, 10, 100)
y1 = np.sin(x)
y2 = np.cos(x)

# Create a figure with custom size and layout
fig, ax = plt.subplots(figsize=(6, 5))  # Figure size in inches (width, height)

# Plot the data
ax.plot(x, y1, label=r'$\sin(x)$', color='blue', linestyle='-', linewidth=2, marker='o', markersize=4)
ax.plot(x, y2, label=r'$\cos(x)$', color='red', linestyle='--', linewidth=2, marker='s', markersize=4)

# Customize the axes
ax.set_xlabel(r'Подпись оси X', fontsize=14, fontweight='bold', labelpad=10)
ax.set_ylabel(r'Подпись оси Y', fontsize=14, fontweight='bold', labelpad=10)
ax.set_title('Custom Layout Example', fontsize=16, fontweight='bold', pad=15)
ax.tick_params(axis='both', which='major', labelsize=12, length=6, width=1.5)
ax.grid(True, which='both', linestyle='dotted', linewidth=1, alpha=1)

# Add a legend
ax.legend(fontsize=12, loc='lower left', frameon=True, framealpha=0.9, edgecolor='black')

# Adjust subplot parameters for better spacing
plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1, hspace=0.3, wspace=0.3)

# Save the plot to a PDF file
plt.savefig("mpl_plot.pdf", format="pdf", bbox_inches="tight")

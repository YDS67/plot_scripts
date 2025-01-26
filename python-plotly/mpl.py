import numpy as np
import matplotlib.pyplot as plt

# Enable LaTeX rendering in Matplotlib
#from matplotlib.pyplot import rc
#rc('text', usetex=True)
#rc('font', family='Times')
#rc('text.latex',unicode=True)
#rc('text.latex', preamble=r'\usepackage[utf8]{inputenc}')
#rc('text.latex', preamble=r'\usepackage[russian]{babel}')

# Enable regular rendering in Matplotlib (without LaTeX)
from matplotlib import rcParams
# Set the font globally
rcParams['font.family'] = 'Times New Roman'  # Replace with your font name
rcParams['mathtext.fontset'] = 'stix'

# Colors
c = [
    (68, 119, 170),  # good blue
    (238, 119, 51),  # orange
    (34, 136, 51),   # green
    (80, 80, 80),    # dark gray
    (170, 51, 119),  # purple, cherry
    (0, 153, 136),   # teal
    (204, 51, 17),   # red
    (102, 37, 6),    # brown
    (221, 170, 51),  # good yellow
    (102, 204, 238), # sky blue
    (51, 34, 136),   # indigo, dark purple
    (204, 187, 68),  # lemon
    (187, 187, 187), # gray
    (0, 68, 136),    # darker blue
    (153, 153, 51),  # olive
    (136, 34, 85),   # wine
    (0, 0, 0),       # black
]

def col(i):
    return tuple(rgb / 255 for rgb in c[i-1])

# Generate some example data
x = np.linspace(0, 10, 100)
y1 = np.sin(x)
y2 = np.cos(x)

# Create a figure with custom size and layout
fig, ax = plt.subplots(figsize=(6, 5))  # Figure size in inches (width, height)

# Plot the data
ax.plot(x, y1, label=r'$\sin(x)$', color=col(1), linestyle='-', linewidth=2, marker='o', markersize=4)
ax.plot(x, y2, label=r'$\cos(x)$', color=col(2), linestyle='--', linewidth=2, marker='s', markersize=4)

# Customize the axes
ax.set_xlabel('Подпись оси X', fontsize=14, fontweight='normal', labelpad=10)
ax.set_ylabel('Подпись оси Y', fontsize=14, fontweight='normal', labelpad=10)
ax.set_title('График с заданным стилем', fontsize=16, fontweight='normal', pad=15)
ax.tick_params(axis='both', which='major', labelsize=12, length=6, width=1.5)
ax.grid(True, which='both', linestyle='dotted', linewidth=1, alpha=1)
plt.tick_params(axis='both', width=1)

# Add a legend
ax.legend(fontsize=14, loc='lower left', frameon=True, framealpha=1, fancybox=True, edgecolor='black')

# Adjust subplot parameters for better spacing
plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1, hspace=0.3, wspace=0.3)

# Save the plot to a PDF file
plt.savefig("mpl_plot.pdf", format="pdf", bbox_inches="tight")

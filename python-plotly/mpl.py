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
    (51, 34, 136),   # indigo, dark purple
    (204, 51, 17),   # red
    (0, 153, 136),   # teal
    (221, 170, 51),  # good yellow
    (80, 80, 80),    # dark gray
    (170, 51, 119),  # purple, cherry
    (102, 37, 6),    # brown
    (102, 204, 238), # sky blue
    (204, 187, 68),  # lemon
    (187, 187, 187), # gray
    (0, 68, 136),    # darker blue
    (153, 153, 51),  # olive
    (136, 34, 85),   # wine
    (0, 0, 0),       # black
]

# Dash types
d = [
    'solid',
    'dashed',
    'dotted',
    'dashdot',
    (5, (10, 3)),
]

def col(i):
    return tuple(rgb / 255 for rgb in c[i])

# Read the file
data = np.loadtxt('data/taylor.dat')
x = data[:, 0]
y1 = data[:, 1]
y2 = data[:, 2]
y3 = data[:, 3]
y4 = data[:, 4]
y5 = data[:, 5]

# Create a figure with custom size and layout
fig, ax = plt.subplots(figsize=(6.4, 4.8))  # Figure size in inches (width, height)

# Plot the data
ax.plot(x, y1, label=r'$\cos x^2$', color=col(0), linestyle=d[0], linewidth=2, markersize=4)
ax.plot(x, y2, label=r'$T_1(x)$', color=col(1), linestyle=d[1], linewidth=2, markersize=4)
ax.plot(x, y3, label=r'$T_2(x)$', color=col(2), linestyle=d[2], linewidth=2, markersize=4)
ax.plot(x, y4, label=r'$T_3(x)$', color=col(3), linestyle=d[3], linewidth=2, markersize=4)
ax.plot(x, y5, label=r'$T_4(x)$', color=col(4), linestyle=d[4], linewidth=2, markersize=4)

# Customize the axes
ax.set_xlabel(r'$x$', fontsize=14, fontweight='normal', labelpad=10)
ax.set_ylabel(r'$f(x)$', fontsize=14, fontweight='normal', labelpad=10)
ax.set_title('Приближение функции рядом Тейлора', fontsize=16, fontweight='normal', pad=15)
ax.tick_params(axis='both', which='major', labelsize=12, length=6, width=1.5)
ax.grid(True, which='both', linestyle='dotted', linewidth=1, alpha=1)
plt.tick_params(axis='both', width=1, length=4, direction='in')
plt.tick_params(axis='y', labelrotation=90)
plt.ylim(-1,1)

# Add a legend
ax.legend(fontsize=14, loc='lower left', frameon=True, framealpha=1, fancybox=True, edgecolor='black', borderaxespad=1)

# Adjust subplot parameters for better spacing
plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1, hspace=0.3, wspace=0.3)

# Save the plot to a PDF file
plt.savefig("mpl_plot.pdf", format="pdf", bbox_inches="tight")

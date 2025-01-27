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

# Desired figure size in centimeters
def inch(width, height):
    return (width / 2.54, height / 2.54)

# =========================
# Square (half page) plot
# =========================

width = 7.5
height = 7.5
lwd = 1
bwd = 0.5
msz = 1
fsz = 10
scale = 1

# Create a figure with custom size and layout
fig, ax = plt.subplots(figsize=inch(width, height))  # Figure size in inches (width, height)

# Plot the data
ax.plot(x, y1, label=r'$\cos x^2$', color=col(0), linestyle=d[0], linewidth=lwd, markersize=msz)
ax.plot(x, y2, label=r'$T_1(x)$', color=col(1), linestyle=d[1], linewidth=lwd, markersize=msz)
ax.plot(x, y3, label=r'$T_2(x)$', color=col(2), linestyle=d[2], linewidth=lwd, markersize=msz)
ax.plot(x, y4, label=r'$T_3(x)$', color=col(3), linestyle=d[3], linewidth=lwd, markersize=msz)
ax.plot(x, y5, label=r'$T_4(x)$', color=col(4), linestyle=d[4], linewidth=lwd, markersize=msz)

# Customize the axes
ax.set_xlabel(r'$x$', fontsize=fsz, fontweight='normal', labelpad=5*scale)
ax.set_ylabel(r'$f(x)$', fontsize=fsz, fontweight='normal', labelpad=5*scale)
ax.set_title('Приближение функции рядом Тейлора', fontsize=fsz, fontweight='normal', pad=5*scale)
ax.tick_params(axis='both', which='major', labelsize=fsz-2, length=2*scale, width=bwd, direction='out')
ax.grid(True, which='both', linestyle='dotted', linewidth=bwd, alpha=1)
# Change the box (spines) line width
for spine in ax.spines.values():
    spine.set_linewidth(bwd)
plt.tick_params(axis='y', labelrotation=90)
plt.ylim(-1,1)

# Add a legend
ax.legend(
    fontsize=fsz,
    loc='lower left',
    frameon=True,
    framealpha=1,
    fancybox=True,
    edgecolor='black',
    borderaxespad=0.5*scale,
    handleheight=0.25*scale,
    labelspacing=0.25*scale,
).get_frame().set_linewidth(bwd)

# Adjust subplot parameters for better spacing
plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1, hspace=0.3, wspace=0.3)

# Save the plot to a PDF file
plt.savefig("mpl_plot_square.pdf", format="pdf", bbox_inches="tight")

# =========================
# Rectangular (full page) plot
# =========================

width = 15
height = 10
lwd = 1.5
bwd = 0.75
msz = 2
fsz = 12
scale = 1.5

# Create a figure with custom size and layout
fig, ax = plt.subplots(figsize=inch(width, height))  # Figure size in inches (width, height)

# Plot the data
ax.plot(x, y1, label=r'$\cos x^2$', color=col(0), linestyle=d[0], linewidth=lwd, markersize=msz)
ax.plot(x, y2, label=r'$T_1(x)$', color=col(1), linestyle=d[1], linewidth=lwd, markersize=msz)
ax.plot(x, y3, label=r'$T_2(x)$', color=col(2), linestyle=d[2], linewidth=lwd, markersize=msz)
ax.plot(x, y4, label=r'$T_3(x)$', color=col(3), linestyle=d[3], linewidth=lwd, markersize=msz)
ax.plot(x, y5, label=r'$T_4(x)$', color=col(4), linestyle=d[4], linewidth=lwd, markersize=msz)

# Customize the axes
ax.set_xlabel(r'$x$', fontsize=fsz, fontweight='normal', labelpad=5*scale)
ax.set_ylabel(r'$f(x)$', fontsize=fsz, fontweight='normal', labelpad=5*scale)
ax.set_title('Приближение функции рядом Тейлора', fontsize=fsz, fontweight='normal', pad=5*scale)
ax.tick_params(axis='both', which='major', labelsize=fsz-2, length=2*scale, width=bwd, direction='out')
ax.grid(True, which='both', linestyle='dotted', linewidth=bwd, alpha=1)
# Change the box (spines) line width
for spine in ax.spines.values():
    spine.set_linewidth(bwd)
plt.tick_params(axis='y', labelrotation=90)
plt.ylim(-1,1)

# Add a legend
ax.legend(
    fontsize=fsz,
    loc='lower left',
    frameon=True,
    framealpha=1,
    fancybox=True,
    edgecolor='black',
    borderaxespad=0.5*scale,
    handleheight=0.25*scale,
    labelspacing=0.25*scale,
).get_frame().set_linewidth(bwd)

# Adjust subplot parameters for better spacing
plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1, hspace=0.3, wspace=0.3)

# Save the plot to a PDF file
plt.savefig("mpl_plot_rect.pdf", format="pdf", bbox_inches="tight")

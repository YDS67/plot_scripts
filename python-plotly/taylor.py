import plotly.graph_objects as go
import plotly.io as pio
import pars
import numpy as np

# Read the file
data = np.loadtxt('data/taylor.dat')
x = data[:, 0]
y1 = data[:, 1]
y2 = data[:, 2]
y3 = data[:, 3]
y4 = data[:, 4]
y5 = data[:, 5]

# import math
# n = 250
# x_min = 0.0
# x_max = 3.0
# dx = (x_max - x_min) / n
# x = [i * dx + x_min for i in range(n)]

# y1 = [math.cos(val**2) for val in x]
# y2 = [1.0 - val**4 / 2.0 for val in x]
# y3 = [1.0 - val**4 / 2.0 + val**8 / 24.0 for val in x]
# y4 = [1.0 - val**4 / 2.0 + val**8 / 24.0 - val**12 / 720.0 for val in x]
# y5 = [1.0 - val**4 / 2.0 + val**8 / 24.0 - val**12 / 720.0 + val**16 / (720.0 * 7.0 * 8.0) for val in x]

# Create traces
trace1 = go.Scatter(x=x, y=y1, mode='lines', name=r'$\cos x^2$', line=dict(color=pars.c[0], dash=pars.d[0]))
trace2 = go.Scatter(x=x, y=y2, mode='lines', name=r'$T_1(x)$', line=dict(color=pars.c[1], dash=pars.d[1]))
trace3 = go.Scatter(x=x, y=y3, mode='lines', name=r'$T_2(x)$', line=dict(color=pars.c[2], dash=pars.d[2]))
trace4 = go.Scatter(x=x, y=y4, mode='lines', name=r'$T_3(x)$', line=dict(color=pars.c[3], dash=pars.d[3]))
trace5 = go.Scatter(x=x, y=y5, mode='lines', name=r'$T_4(x)$', line=dict(color=pars.c[4], dash=pars.d[4]))

xaxis = dict(
    title=r'$x$',
    position=0.0,
    showline=True,
    linecolor="black",
)

yaxis = dict(
    title=r'$f(x)$',
    range=[-1, 1],
    position=0.0,
    showline=True,
    linecolor="black",
)

linetop = dict(
    type='line',
    xref='paper',
    yref='paper',
    x0=0,
    y0=1,
    x1=1,
    y1=1,
    line=dict(color="black", width=1),
)

lineright = dict(
    type='line',
    xref='paper',
    yref='paper',
    x0=1,
    y0=0,
    x1=1,
    y1=1,
    line=dict(color="black", width=1),
)

# Define the general layout
my_layout = go.Layout(
    title={
        'text': r'Приближения функции рядом Тейлора',
        'x': 0.5,  # Center the title
    },
    xaxis=xaxis,
    yaxis=yaxis,
    font=dict(family='Times', size=14, color='black'),
    legend=dict(title='', orientation='v', x=0.01, y=0.01, xanchor='left', yanchor='bottom'),
    template='plotly_white',
    width=640,
    height=480,
)

# Create the figure
fig = go.Figure(layout=my_layout)

fig.add_shape(linetop)
fig.add_shape(lineright)

# Add traces to the figure
fig.add_trace(trace1)
fig.add_trace(trace2)
fig.add_trace(trace3)
fig.add_trace(trace4)
fig.add_trace(trace5)

#fig.show()

# Export the plot as a PNG file
pio.write_image(fig, 'taylor.png', format='png', scale=5, engine='kaleido')
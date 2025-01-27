import plotly.graph_objects as go
import plotly.io as pio
import math

# Compute the function and its approximations
n = 250
x_min = 0.0
x_max = 3.0
dx = (x_max - x_min) / n
x = [i * dx + x_min for i in range(n)]

y1 = [math.cos(val**2) for val in x]
y2 = [1.0 - val**4 / 2.0 for val in x]
y3 = [1.0 - val**4 / 2.0 + val**8 / 24.0 for val in x]
y4 = [1.0 - val**4 / 2.0 + val**8 / 24.0 - val**12 / 720.0 for val in x]
y5 = [1.0 - val**4 / 2.0 + val**8 / 24.0 - val**12 / 720.0 + val**16 / (720.0 * 7.0 * 8.0) for val in x]

# Colors and dash types
c = [
    "rgb(68, 119, 170)",  # good blue
    "rgb(238, 119, 51)",  # orange
    "rgb(34, 136, 51)",   # green
    "rgb(80, 80, 80)",    # dark gray
    "rgb(170, 51, 119)",  # purple, cherry
    "rgb(0, 153, 136)",   # teal
    "rgb(204, 51, 17)",   # red
    "rgb(102, 37, 6)",    # brown
    "rgb(221, 170, 51)",  # good yellow
    "rgb(102, 204, 238)", # sky blue
    "rgb(51, 34, 136)",   # indigo, dark purple
    "rgb(204, 187, 68)",  # lemon
    "rgb(187, 187, 187)", # gray
    "rgb(0, 68, 136)",    # darker blue
    "rgb(153, 153, 51)",  # olive
    "rgb(136, 34, 85)",   # wine
    "rgb(0, 0, 0)",       # black
]

d = [
    'solid',
    'dot',
    'dash',
    'longdash',
    'dashdot',
    'longdashdot',
]

line_width = 2

# Create traces
trace1 = go.Scatter(x=x, y=y1, mode='lines', name=r'$\cos x^2$', line=dict(color=c[0], dash=d[0], width=line_width))
trace2 = go.Scatter(x=x, y=y2, mode='lines', name=r'$T_1(x)$', line=dict(color=c[1], dash=d[1], width=line_width))
trace3 = go.Scatter(x=x, y=y3, mode='lines', name=r'$T_2(x)$', line=dict(color=c[2], dash=d[2], width=line_width))
trace4 = go.Scatter(x=x, y=y4, mode='lines', name=r'$T_3(x)$', line=dict(color=c[3], dash=d[3], width=line_width))
trace5 = go.Scatter(x=x, y=y5, mode='lines', name=r'$T_4(x)$', line=dict(color=c[4], dash=d[4], width=line_width))

xaxis = dict(
    title=r'$x$',
    position=0,
    showline=True,
    linecolor="black",
    ticks="inside",
    tickwidth=1,
    tickcolor="black",
    ticklen=5,
    tickfont=dict(size=16),
)

yaxis = dict(
    title=r'$f(x)$',
    range=[-1, 1],
    position=0,
    showline=True,
    linecolor="black",
    ticks="inside",
    tickwidth=1,
    tickcolor="black",
    ticklen=5,
    tickangle=270,
    tickfont=dict(size=16),
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
        'text': r'Taylor series approximations',
        'x': 0.5,  # Center the title
    },
    xaxis=xaxis,
    yaxis=yaxis,
    font=dict(family='Times', size=14, color='black'),
    legend=dict(
        title='',
        orientation='v',
        x=0.02,
        y=0.01,
        xanchor='left',
        yanchor='bottom',
        itemwidth=50,
        ),
    template='plotly_white',
    autosize=False,
    width=640,
    height=480,
    margin=dict(l=65, r=10, t=50, b=60, pad=10),
)

# Create the figure
fig = go.Figure(layout=my_layout)

# Add top and right lines to complete the box
fig.add_shape(linetop)
fig.add_shape(lineright)

# Add traces to the figure
fig.add_trace(trace1)
fig.add_trace(trace2)
fig.add_trace(trace3)
fig.add_trace(trace4)
fig.add_trace(trace5)

# Export the plot as a PNG file
pio.write_image(fig, 'taylor.png', format='png', scale=4, engine='kaleido')
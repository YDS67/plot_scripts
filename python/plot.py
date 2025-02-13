import plotly.graph_objects as go
import plotly.io as pio
import time
import math_rend as mr

# Array of colors in RGB format with comments for color names
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
]

d = [
    'solid',
    'dot',
    'dash',
    'longdash',
    'dashdot',
    'longdashdot',
]

class Pars:
    fsz = 22
    fsz_title = 22
    fsz_axis = 25
    family = 'Times'
    lwd = 3
    def __init__(self, ):
        pass

#def plot(pars, x, y):

xaxis = dict(
    title=dict(text=mr.html("$x$"),font=dict(family='Times', size=25, color="black")),
    position=0,
    showline=True,
    linecolor="black",
    ticks="inside",
    tickwidth=1,
    tickcolor="black",
    ticklen=5,
    tickfont=dict(family='Times', size=20, color="black"),
    showgrid=True,
    gridcolor='darkgrey',
    gridwidth=1,
    zeroline=False,
    griddash='dot',
)

yaxis = dict(
    title=dict(text=mr.html("$f(x)$"),font=dict(family='Times', size=25, color="black")),
    range=[-1, 1],
    position=0,
    showline=True,
    linecolor="black",
    ticks="inside",
    tickwidth=1,
    tickcolor="black",
    ticklen=5,
    tickangle=270,
    tickfont=dict(family='Times', size=20, color="black"),
    showgrid=True,
    gridcolor='darkgrey',
    gridwidth=1,
    zeroline=False,
    griddash='dot',
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

legend = dict(
        title='',
        font=dict(family='Times', size=22, color="black"),
        orientation='v',
        x=0.02,
        y=0.02,
        xanchor='left',
        yanchor='bottom',
        itemwidth=50,
        bgcolor='white',
        bordercolor='black',
        borderwidth=1,
        indentation=7,
)

# Define the general layout
my_layout = go.Layout(
    title=dict(text="Приближение функции рядом Тейлора", x=0.5, font=dict(family='Times', size=22, color='black')),
    xaxis=xaxis,
    yaxis=yaxis,
    legend=legend,
    template='plotly_white',
    autosize=False,
    width=640,
    height=480,
    margin=dict(l=65, r=10, t=50, b=60, pad=10),
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

pio.write_html(fig, 'taylor.html', include_mathjax='cdn')

# Export the plot as a PNG file
pio.write_image(fig, 'taylor.png', format='png', scale=4, engine='kaleido')
pio.write_image(fig, 'taylor.pdf', format='pdf', scale=1, engine='kaleido')
time.sleep(1)
pio.write_image(fig, 'taylor.pdf', format='pdf', scale=1, engine='kaleido')
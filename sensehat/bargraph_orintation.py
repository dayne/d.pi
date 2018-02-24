#!/usr/bin/env python
# http://benwyrosdick.com/2016/08/29/starting-with-pi.html
import time
import signal
import sys

from sense_hat import SenseHat
sense = SenseHat()

def exit_gracefully(signal, frame):
  sense.clear()
  sys.exit(0)
signal.signal(signal.SIGINT, exit_gracefully)

GRAPH_BAR_HEIGHT = 8
GRAPH_BAR_WIDTH = 2

red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
black = (0, 0, 0)

sense.set_rotation(270)
sense.low_light = True

def normalize_deg(deg, bound):
  deg = int(deg)
  q = deg / 90
  r = deg % 90
  if (q % 2 == 1):
    r = 90 - r
  return int(r * (bound / 90.0))

while True:
  orientation = sense.orientation
  x = normalize_deg(orientation['pitch'], GRAPH_BAR_HEIGHT)
  y = normalize_deg(orientation['roll'], GRAPH_BAR_HEIGHT)
  z = normalize_deg(orientation['yaw'], GRAPH_BAR_HEIGHT)

  grid = []

  grid += ([red] * x + [black] * (GRAPH_BAR_HEIGHT - x)) * GRAPH_BAR_WIDTH
  grid += [black] * GRAPH_BAR_HEIGHT
  grid += ([green] * y + [black] * (GRAPH_BAR_HEIGHT - y)) * GRAPH_BAR_WIDTH
  grid += [black] * GRAPH_BAR_HEIGHT
  grid += ([blue] * z + [black] * (GRAPH_BAR_HEIGHT - z)) * GRAPH_BAR_WIDTH

  sense.set_pixels(grid)

  time.sleep(0.1)

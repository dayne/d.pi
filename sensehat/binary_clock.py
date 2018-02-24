#!/usr/bin/env python
# http://benwyrosdick.com/2016/08/29/starting-with-pi.html
# pip install pytz

import time
import signal
import sys

import pytz
from datetime import datetime
from pytz import timezone

from sense_hat import SenseHat
sense = SenseHat()
sense.set_rotation(270)
sense.low_light = True

def exit_gracefully(signal, frame):
  sense.clear()
  sys.exit(0)
signal.signal(signal.SIGINT, exit_gracefully)

GRAPH_BAR_HEIGHT = 8

red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
black = (0, 0, 0)

central = timezone('US/Central')

def digit_to_grid(digit, color):
  digits = []
  while digit > 0:
    if digit % 2 == 1:
      digits += [color]
    else:
      digits += [black]
    digit /= 2
  digits += [black] * (GRAPH_BAR_HEIGHT - len(digits))
  return digits

while True:
  grid = []

  local = datetime.now(timezone('UTC')).astimezone(central)

  hour = int(local.strftime("%I"))
  grid += digit_to_grid(hour / 10, red)
  grid += digit_to_grid(hour % 10, red)

  grid += [black] * GRAPH_BAR_HEIGHT
  
  grid += digit_to_grid(local.minute / 10, green)
  grid += digit_to_grid(local.minute % 10, green)

  grid += [black] * GRAPH_BAR_HEIGHT

  grid += digit_to_grid(local.second / 10, blue)
  grid += digit_to_grid(local.second % 10, blue)

  sense.set_pixels(grid)

  time.sleep(0.5)

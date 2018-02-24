#!/usr/bin/env python
import sys 
import signal
from sense_hat import SenseHat
sense = SenseHat()

def exit_gracefully(signal, frame):
    sense.clear()
    sys.exit(0)
signal.signal(signal.SIGINT, exit_gracefully)

argv = sys.argv
program_name = argv.pop(0)
argv_string = ' '.join(argv)
print argv_string
sense.show_message(argv_string)

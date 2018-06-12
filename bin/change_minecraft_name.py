#!/usr/bin/env python
# Set the player name (7 chars) for Minecraft PI Edition
# Written by Richard Garsthagen - richard@coderdojo-zoetermeer.nl
#
# Use at own risk. Please make a backup of minecraft-pi first!
# https://www.raspberrypi.org/forums/viewtopic.php?t=186229
# 
# sudo cp /opt/minecraft-pi/minecraft-pi /opt/minecraft-pi/minecraft-pi.backup
# sudo python change_minecraft_name.py

namestart= 1026250

try:

 fh = open("/opt/minecraft-pi/minecraft-pi", "r+b")
 fh.seek(namestart)

 print ("Current name: {} ".format(fh.read(7)))
 print ("Provide a new name 7 characters or less")
 print             ("           hint: 1234567")
 piname = raw_input("New player name: ")

 if len(piname) > 1:
  if len(piname) > 7: piname = piname[:7]
  if len(piname) < 7:
   extraspaces = 7 - len(piname)
   for x in xrange(0,extraspaces):
     piname = piname + " "
  print ("Changed name to: " + piname + " - " + str(len(piname)))
  fh.seek(namestart)
  fh.write(piname)
 else:
  print ("No new name given")

 fh.close()

except:
 print ("Can not change name, is minecraft running? Please close the app first")
 print ("Double check you have permission to modify /opt/minecraft-pi/minecraft-pi")
 print ("Hint: sudo # remember: backup your minecraft-pi")

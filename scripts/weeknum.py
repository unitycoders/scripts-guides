#! /usr/bin/python

from datetime import date

FRESHERS_WEEK = date(2014,10,2)
today = date.today()
dayDelta = (today - FRESHERS_WEEK)

uoe_week = ((dayDelta.days / 7) + 1) % 52
print (uoe_week)
print ("0x%X" % uoe_week)

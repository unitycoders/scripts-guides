#! /usr/bin/env python
##
# Convert roman numerals into ints
# Created by Joseph Walton-Rivers
##
##
# Useage: ./roman.py and follow the prompt
##

roman = {'I':1, 'V':5, 'X':10, 'L':50, 'C':100, 'D':500, 'M':1000}
roman_input = raw_input("Enter Roman Numeral: ")

def main(roman_input):
	lowest = 1000

	total = 0
	skip = []
	for x in range(0, len(roman_input)):
		roman_value = roman_input[x]
		int_value = roman[roman_value]

		# Subtraction rule
		next_roman_value = roman_input[x+1] if x+1 < len(roman_input) else ''
		next_int_value = roman[next_roman_value] if next_roman_value != '' else 0	
		if int_value < next_int_value:
			int_value = (next_int_value - int_value)
			skip.append(x+1)

		# Skip the value if it's part of a subsitution rule
		if x not in skip:
			total = total + int_value

			# ERROR CHECK: the number should always decrease or be equal to the last
			if lowest < int_value:
				print ("ERROR - value goes up!")
				return 0
			lowest = int_value
	return total

print ("the total is "+str(main(roman_input)))

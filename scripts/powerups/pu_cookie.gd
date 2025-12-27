class_name CookiePU extends Powerup

"""
Basis-Powerup increasing damage on all powerups
"""


func stack_callback():
	super()
	Powerup.damage_modifier += 2

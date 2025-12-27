class_name CookiePU extends Powerup

"""
Basis-Powerup increasing damage on all powerups
"""


func stack_callback():
	Powerup.damage_modifier += 3

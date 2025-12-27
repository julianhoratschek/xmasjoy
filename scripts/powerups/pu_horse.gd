class_name HorsePU extends Powerup

"""
Basis-powerup increasing frequency on all powerups
"""

func stack_callback():
	super()
	Powerup.frequency_modifier  += 0.02

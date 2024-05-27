extends Marker2D

func cast_spell():
	const SPELL = preload("res://characters/base_character/spell.tscn")
	
	var new_spell = SPELL.instantiate()
	
	new_spell.global_position = self.global_position
	new_spell.global_rotation = self.global_rotation
	self.add_child(new_spell)

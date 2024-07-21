extends Spatial
class_name weapon

var weapon_manager = null
var player = null
var animation_player 


var is_equiped = false
var is_firing = false
var is_reloading = false 

export var weapon_name = "Weapon"

export var equip_speed = 1.0
export var unequip_speed = 1.0



func equip():
	animation_player.play("equip" , -1.0, equip_speed)

func unequip():
	animation_player.play("unequip", -1.0,unequip_speed)
	
func is_equip_finished():
	if is_equiped:
		return true
		
func is_unequiped_finished():
	if is_equiped:
		return false
	else :
		return true
		
func on_animation_finish(anim_name):
	match anim_name:
		"unequip":
			is_equiped = false
		"equip":
			is_equiped = true
			

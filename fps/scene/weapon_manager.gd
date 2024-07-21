extends Spatial

var all_weapons={}

var weapons = {}

var hud 
var current_weapon 
var current_weapon_slot = "Empty"
var changing_weapon = false
var unequipped_weapon = false

func _ready():
	hud = owner.get_node("hud")
	all_weapons = {
		"unarmed": preload("res://weapons/unarmed/unarmed.tscn"),
		"pistol" : preload("res://weapons/pistol.tscn"),
		"rifel" : preload("res://weapons/rifel/rifel.tscn")
	}
	weapons = {
		"Empty" : $unarmed,
		"Primary": $pistol,
		"Secondary" : $rifel
		
	}

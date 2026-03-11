extends NameList

@export var player_color:Color =Color(0.173, 0.561, 0.349, 0.471)
#@export var server_color:Color =Color(0.71, 0.549, 0.141, 0.471)


func _ready() -> void:
	super._ready()
	generate(PlayersManager.get_players().values())
	#name_added.connect(_coloration_check)
	#
#
#func _coloration_check(node:Button):
	#var set_bg_color = func(color:Color):
		#var stylebox:StyleBoxFlat = node.get_theme_stylebox("normal").duplicate()
		#stylebox.bg_color = color
		#node.add_theme_stylebox_override("normal",stylebox)
	#if ConnectionManager.player_info["name"] == node.text:
		#set_bg_color.call(player_color)
	#
		

func generate(names_list:Array[Dictionary]):
	refresh(names_list)

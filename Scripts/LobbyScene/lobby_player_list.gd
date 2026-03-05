extends NameList

@export var player_color:Color
@export var server_color:Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	PlayersManager.player_added.connect(_on_player_added)
	PlayersManager.player_removed.connect(_on_player_removed)
	PlayersManager.player_list_set.connect(refresh)
	name_added.connect(_coloration_check)


func _coloration_check(node:Label):
	var set_bg_color = func(color:Color):
		var stylebox:StyleBoxFlat = node.get_theme_stylebox("normal").duplicate()
		stylebox.bg_color = color
		node.add_theme_stylebox_override("normal",stylebox)
	if ConnectionManager.player_info["name"] == node.text:
		set_bg_color.call(player_color)
	elif PlayersManager.get_players()[1]["name"]== node.text:
		set_bg_color.call(server_color)
		
func _on_player_removed(player_info:Dictionary):
	remove_name(player_info["id"])

func _on_player_added(player_info:Dictionary):
	add_name(player_info,_base_children[0])


 

extends ColoredNameList


func _ready() -> void:
	super._ready()
	PlayersManager.player_added.connect(_on_player_added)
	PlayersManager.player_removed.connect(_on_player_removed)
	PlayersManager.player_list_set.connect(func(dict:Dictionary[int,Dictionary]):refresh(dict.values()))
	_style_checks_array.append_array([
		(func(element:Label):return "isPlayer" if element.text == ConnectionManager.player_info["name"] else ""),	
		(func(element:Label):return "isServer" if PlayersManager.get_players()[1]["name"]== element.text else ""),	
	])

func _on_player_removed(player_info:Dictionary):
	remove_name(player_info["id"])

func _on_player_added(player_info:Dictionary):
	add_name(player_info,_base_children[0])

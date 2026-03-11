extends ColouredNameList


func _ready() -> void:
	super._ready()
	PlayersManager.player_added.connect(_on_player_added)
	PlayersManager.player_removed.connect(_on_player_removed)
	PlayersManager.player_list_set.connect(func(dict:Dictionary[int,Dictionary]):refresh(dict.values()))

func _on_player_removed(player_info:Dictionary):
	remove_name(player_info["id"])

func _on_player_added(player_info:Dictionary):
	add_name(player_info,_base_children[0])

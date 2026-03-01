extends Node


signal pause_game
signal resume_game

var _disconnected_players:Dictionary[String,Dictionary] #name -> Player
var _kicked_players:Array[String]

var missing_players = 0 

func _ready() -> void:
	if multiplayer.is_server():
		PlayersManager.player_added.connect(_on_player_added)
		PlayersManager.player_removed.connect(_on_player_removed)

@rpc("authority")
func kick():
	%MultiplayerManager.disconnect_player()

func _on_player_added(player_info:Dictionary):
	if player_info["name"] in _disconnected_players.keys():
		missing_players-=1
		if missing_players==0:
			resume_game.emit()
		_disconnected_players.erase(player_info["name"])
	else:
		kick.rpc_id(player_info["id"])
		_kicked_players.push_back(player_info["name"])


func _on_player_removed(player_info:Dictionary):
	if not player_info["name"] in _kicked_players:
		_disconnected_players[player_info["name"]]=player_info
		missing_players+=1
		pause_game.emit()
	else:
		_kicked_players.erase(player_info["name"])
	

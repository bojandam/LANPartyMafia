extends Node


const PORT = 9999

var _disconnected_players:Dictionary[String,Dictionary] = {}
var missing_players_count = 0

func _ready():
	if multiplayer.is_server():
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)




@rpc("authority")
func _kick():
	multiplayer.set_multiplayer_peer(OfflineMultiplayerPeer.new())
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	

func _on_peer_disconnected(id:int):
	if multiplayer.is_server():
		if id in PlayersManager.get_players().keys():
			_disconnected_players[PlayersManager.get_players()[id]["name"]]=PlayersManager.get_players()[id]
			print(PlayersManager.get_players()[id]["name"]," disconnected")
			PlayersManager.remove_player(id)
			if missing_players_count==0:
				%MultiplayerAdapter._pause.rpc()
			missing_players_count+=1
		

@rpc("any_peer")
func _send_player_information(player_info:Dictionary):
	if multiplayer.is_server():
		if  player_info["name"] in _disconnected_players.keys():
			var id = player_info["id"]
			player_info = _disconnected_players[player_info["name"]]
			player_info["id"]= id
			PlayersManager.add_player(player_info)
			ConnectionManager.StartGame.rpc_id(id)
			await get_tree().create_timer(.2).timeout
			#to do: catch up reconnected peer
			missing_players_count-=1
			if missing_players_count==0:
				%MultiplayerAdapter._resume.rpc()
		else:
			_kick.rpc_id(player_info["id"])

@rpc("authority")
func _send_server_player_dict(player_dict):
	PlayersManager.set_player_dict(player_dict)

extends Node


var player_info:Dictionary = {}
var game_settings:Settings = preload("uid://c38ae5w4kl8td")

var previous_ip := ""
var was_server:bool = false
var kicked:bool = false


@rpc("authority","call_local")
func StartGame():
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")

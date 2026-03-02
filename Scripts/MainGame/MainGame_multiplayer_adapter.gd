extends Node


signal pause_game
signal resume_game


func _ready():
	pause_game.connect(_on_pause_game)
	resume_game.connect(_on_resume_game)

func _on_pause_game():
	print("Game Paused: - ",ConnectionManager.player_info["name"])
	
func _on_resume_game():
	
	print("Game Resumed: - ",ConnectionManager.player_info["name"])

@rpc("authority","call_local")
func _pause():
	pause_game.emit()
	
@rpc("authority","call_local")
func _resume():
	resume_game.emit()

extends VBoxContainer


@onready var player_row := $PlayerRow
func _gen_player(pname):
	var new_row:PlayerRow = player_row.duplicate()
	add_child(new_row)
	new_row.name=pname
	new_row.effects.text = ""
	if %DayNightController._effect_tracker.has(pname):
		for effect in %DayNightController._effect_tracker[pname]:
			new_row.effects.text+= str(%DayNightController.Effects.find_key(effect))
			new_row.effects.text +=", "
	new_row.player.text = pname
	new_row.role.text = str(RoleController.Roles.find_key(PlayersManager.get_players_by_name()[pname]["role"]))
	
	
func genarate(alive_list):
	var deca := get_children()
	deca.pop_front()
	for dete in deca:
		dete.queue_free()
	if multiplayer.is_server():
		for pname in alive_list:
			_gen_player(pname["name"])

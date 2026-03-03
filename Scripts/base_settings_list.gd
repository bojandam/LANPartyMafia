extends VBoxContainer


var _base_child:SettingContainer
func _ready():
	_base_child = $SettingContainer
	remove_child(_base_child)
	for setting in ConnectionManager.game_settings.game_message.keys():
		var new_node = _base_child.duplicate()
		new_node.set_setting(setting)
		add_child(new_node)

 

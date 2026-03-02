extends HBoxContainer
class_name SettingContainer

var setting:Settings.Flags

 
func set_setting(val:Settings.Flags):
	setting = val
	$SettingText.text = ConnectionManager.game_settings.game_message[val]
	$SettingCheckBox.set_pressed_no_signal(ConnectionManager.game_settings.get_flag(val))

func _ready():
	$SettingCheckBox.toggled.connect(_on_checkbox_pressed)

func _on_checkbox_pressed(val):
	if val:
		ConnectionManager.game_settings.set_flag(setting)
	else:
		ConnectionManager.game_settings.clear_flag(setting)

extends VBoxContainer


@onready var effect_text:Label = %EffectText
@onready var role_hint:Label = %EffectHint

func load_role(role:RoleController.Roles):
	var role_info:RoleInfo = RoleController.role_info[role]["role info"]
	effect_text.text = role_info.effect_label
	role_hint.text = role_info.short_info

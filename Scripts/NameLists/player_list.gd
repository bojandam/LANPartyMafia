extends GridContainer
class_name NameList

signal name_added(node:Node)
signal player_added(node:Node,player_info:Dictionary)
signal name_removed
signal refreshed

var _base_children:Array

func _ready():
	_base_children = get_children()
	for child in get_children():
		remove_child(child)

func add_name(player_info:Dictionary, base_node:Node): #Abstracted
	var new_item:= base_node.duplicate() 
	new_item.text = player_info["name"] 
	new_item.name = player_info["name"] 
	#print(new_item.name)
	new_item.show()
	add_child(new_item)
	name_added.emit(new_item)
	player_added.emit(new_item,player_info)
	return new_item

func remove_name(id:int):
	var children:Array = get_children()
	for child in children:
		if child.name == str(id):
			child.queue_free()
			name_removed.emit()
			return

func refresh(player_list:Array):
	for child:Node in get_children():
		child.queue_free()
	for player_info:Dictionary in player_list:
		add_name(player_info,_base_children[0])
	refreshed.emit()

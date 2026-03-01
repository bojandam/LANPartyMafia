extends GridContainer
class_name NameList

signal name_added(node:Node)
signal name_removed
signal refreshed

var _base_children:Array
func _ready():
	_base_children = get_children()
	for child in get_children():
		remove_child(child)

func add_name(player_info:Dictionary, base_node:Node): #Abstracted
	var new_item:= base_node.duplicate() 
	new_item.text = player_info["name"] #get_text		Ok
	new_item.name = str(player_info["id"]) #get_id		Ok
	#print(new_item.name)
	new_item.show()
	add_child(new_item)
	name_added.emit(new_item)
	return new_item

func remove_name(id:int):
	var children:Array = get_children()
	for child in children:
		if child.name == str(id):
			child.queue_free()
			name_removed.emit()
			return

func refresh(player_list:Dictionary[int,Dictionary]):
	var children_list:Array = get_children()
	for child:Node in children_list:
		child.queue_free()
	for player_info:Dictionary in player_list.values():
		add_name(player_info,_base_children[0])
	refreshed.emit()

@tool
extends Sprite2D
class_name Sprite2DVaRes

@export_group("VaRes Number")
@export var num:VaRNumber :
	set(new):
		if num and num.changed.is_connected(on_changed_num):
			num.changed.disconnect(on_changed_num)
		num = new
		if new: num.changed.connect(on_changed_num)
		update_sprite()
@export var num_is_texture:Array[Texture] : 
	set(new):
		num_is_texture = new
		update_sprite()
@export_group("VaRes Bool")

func on_changed_num():
	update_sprite()

func update_sprite():
	if !num_is_texture.is_empty() and num_is_texture.size()-1 >= num.get_value():
		texture = num_is_texture.get(num.get_value())

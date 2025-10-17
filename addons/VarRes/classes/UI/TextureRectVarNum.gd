@tool
extends TextureRect
class_name TextureRectVaRNum

@export var num:VaRNumber : 
	set(new):
		if num and num.changed.is_connected(on_changed_num):
			num.changed.disconnect(on_changed_num)
		num = new
		if new: num.changed.connect(on_changed_num)
		update_texture_rect()
## Попробует применить текстуру из массива по индексу num.[br]
## Если не получится - применит default_texture.[br]
@export var num_is:Array[Texture]
## Применяется эта текстура если не получится применить из num_is.[br]
## Если текстура не указана - ничего не будет делать.
@export var default_texture:Texture

func on_changed_num():
	update_texture_rect()

func update_texture_rect():
	if !num_is.is_empty() and num_is.size()-1 >= num.get_value():
		texture = num_is.get(num.get_value())
	elif default_texture:
		texture = default_texture

func _ready() -> void:
	update_texture_rect()

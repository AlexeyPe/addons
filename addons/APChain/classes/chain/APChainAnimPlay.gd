@tool
extends APChain
class_name APChainAnimPlay

@export var animation_player:AnimationPlayer : set = set_animation_player
@export var speed:float = 1.0
@export var from_end:bool = false
var _anims:PackedStringArray
var _anim_name:int

func set_animation_player(new:AnimationPlayer):
	animation_player = new
	_anims = animation_player.get_animation_list()
	notify_property_list_changed()

func _get_property_list():
	var properties = []
	properties.append({
		"name": "anim_name",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(_anims),
	})
	return properties

func _set(property: StringName, value: Variant) -> bool:
	if property == "anim_name":
		_anim_name = value
		return true
	return false

func _get(property: StringName) -> Variant:
	if property == "anim_name": return _anim_name
	return null

func _ready() -> void:
	super._ready()
	if not Engine.is_editor_hint():
		assert(animation_player != null, "animation_player is null, %s"%[self.get_path()])
		pass

func _execute(...args:Array):
	if from_end:
		#prints("play from_end anim:", _anims[_anim_name], "speed:", speed)
		animation_player.play_backwards(_anims[_anim_name])
		animation_player.speed_scale = speed
	else:
		#prints("play anim:", _anims[_anim_name], "speed:", speed)
		animation_player.play(_anims[_anim_name], -1, speed)
		animation_player.seek(0)

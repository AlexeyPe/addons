@tool
extends APChain
class_name chain_collision

## К примеру red = red_field
#@export var meta_to_field: Dictionary[String, PackedScene]
@export var meta_to_field_id: Dictionary[String, int]
## К примеру ball из red войска буде делать field red
@export var unit_type: String = ""

func _ready() -> void:
	super._ready()
	assert(not unit_type.is_empty(), "unit_type is empty %s"%[self.get_path()])

func _execute(...args:Array):
	var node = args[0]
	if node is CollisionObject2D:
		match node.get_meta("field_type", "__null"):
			"__null": return
			"free":
				var tilemap:TileMapLayer = node.get_parent()
				#print("collision with %s"%[node.get_meta("field_type")])
				tilemap.set_cell(
					tilemap.local_to_map(tilemap.to_local(node.position)), 
					0, 
					Vector2i.ZERO,
					meta_to_field_id[unit_type]
				)
			_: 
				var area:Area2D = node.get_node("Area2D")
				for body in area.get_overlapping_bodies():
					var ball_chain:chain_collision = body.get_node("chain_ball")
					if unit_type != ball_chain.unit_type:
						var die:VaRBool = body.get_meta("is_die")
						die.value = true
				
				var tilemap:TileMapLayer = node.get_parent()
				tilemap.set_cell(
					tilemap.local_to_map(tilemap.to_local(node.position)), 
					0, 
					Vector2i.ZERO,
					meta_to_field_id[unit_type]
				)

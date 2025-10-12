@tool
extends APChain
class_name APChainNumOp

enum OPERATION {ADD}

@export var vares_target:VaRNumber
@export var vares_b:VaRNumber
@export var operation:OPERATION = OPERATION.ADD

func _execute(...args:Array):
	if Engine.is_editor_hint(): return
	match operation:
		OPERATION.ADD:
			vares_target.set_value(vares_target.get_value()+vares_b.get_value())

func _ready() -> void:
	#super._ready()
	if not Engine.is_editor_hint():
		assert(vares_target != null, "vares_target is null | %s"%[self.get_path()])
		assert(vares_b != null, "vares_b is null | %s"%[self.get_path()])

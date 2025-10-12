@tool 
@abstract
@icon("res://addons/APChain/imgs_required/fa7-solid--chain.svg")
extends Node
class_name APChain

## Абстрактный класс цепочки [br]
## Цепочка акивируется с помощью [APChainActivator]

## Цепочка начала выполнение [method _execute]
signal execution_started
## Цепочка выполнила [method _execute] 
signal executed
## Цепочка успешно выполнила [method _execute]
signal executed_good
## Цепочка неуспешно выполнила [method _execute]
signal executed_failed

@export var enable: bool = true : 
	set(new):
		enable = new
		if not enable:
			if node_emitter and not _execute.is_null() and\
				node_emitter.is_connected(signals[_watch_signal], _execute):
				node_emitter.disconnect(signals[_watch_signal], _execute)
			return
		if node_emitter and not _execute.is_null() and\
			node_emitter.has_signal(signals[_watch_signal]) and\
			not node_emitter.is_connected(signals[_watch_signal], _execute):
			node_emitter.connect(signals[_watch_signal], _execute)
@export var node_emitter:Node : 
	set(new):
		if node_emitter and not _execute.is_null() and\
			node_emitter.is_connected(signals[_watch_signal], _execute):
			node_emitter.disconnect(signals[_watch_signal], _execute)
		node_emitter = new
		signals.clear()
		notify_property_list_changed()
		if !node_emitter: return
		for _signal in node_emitter.get_signal_list():
			signals.append(_signal.name)
		notify_property_list_changed()
		if enable and node_emitter and\
			node_emitter.has_signal(signals[_watch_signal]):
			node_emitter.connect(signals[_watch_signal], _execute)

var signals:Array[String]
var _watch_signal:int

## Логика цепочки
@abstract func _execute(...args:Array) -> void

func _ready() -> void:
	if not enable: return
	if node_emitter  and\
		node_emitter.has_signal(signals[_watch_signal]) and\
		not node_emitter.is_connected(signals[_watch_signal], _execute):
		node_emitter.connect(signals[_watch_signal], _execute)

func _get_property_list():
	var properties = []
	if signals:
		properties.append({
			"name": "watch_signal",
			"type": TYPE_INT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": ",".join(signals),
		})
	return properties

func _set(property: StringName, value: Variant) -> bool:
	match property:
		"watch_signal": _watch_signal = value
		_: return false
	return true

func _get(property: StringName) -> Variant:
	match property:
		"watch_signal": return _watch_signal
		_: return null

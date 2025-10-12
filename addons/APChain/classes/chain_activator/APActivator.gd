@tool
@abstract
@icon("res://addons/APChain/imgs_required/material-symbols--nest-remote-comfort-sensor-rounded.svg")
extends Node
class_name APActivator

## Абстрактный класс активатора[br]
## Используется для запуска [APChain]

## Выдаётся для запуска [APChain]
signal activated

func emit_activated(...args:Array) -> void: 
	activated.emit()

## Переключает работу активатора
@export var enable:bool = true :
	set(new):
		enable = new
		_change_enable()

## Вызывается при переключении [param enable]
@abstract func _change_enable()

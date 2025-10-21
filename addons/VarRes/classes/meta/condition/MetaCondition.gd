@abstract
extends VarRes
class_name MetaCondition

signal if_true
signal if_false

@export var meta_name:String
@export var meta_execute:MetaExecute

@abstract func check(node:Node) -> bool

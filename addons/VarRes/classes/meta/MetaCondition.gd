@abstract
extends VarRes
class_name MetaCondition

@export var meta_name:String
@export var meta_execute:MetaExecute

@abstract func check(node:Node)

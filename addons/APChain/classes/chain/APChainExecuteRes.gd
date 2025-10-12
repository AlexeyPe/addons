@tool
extends APChain
class_name APChainExecuteRes

@export var res:Resource : 
	set(new):
		res = new
		if res:
			for method in res.get_method_list():
				print("id:%s, method:%s"%[method.id, method.name])

func _execute(...args:Array):
	
	pass

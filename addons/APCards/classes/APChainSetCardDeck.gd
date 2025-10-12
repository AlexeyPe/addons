extends APChain
class_name APChainSetCardDeck

@export var deck:APDeckContainer
@export var set_alignment:bool = true
@export var new_alignment:APDeckContainer.ALIGNMENT
@export var set_transition:bool = true
@export var new_transition:Tween.TransitionType

func _execute(...args:Array) -> void:
	if !deck: return
	if set_alignment:
		deck.alignment = new_alignment
	if set_transition:
		deck.transition_type = new_transition

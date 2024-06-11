extends Node2D


#editor variables
@export var movingbeatsNode : Node2D
@export var TargetBox : Node
@export var eventName : StringName

#signals
signal beatConsumed(percent:float)

func _input(event) -> void:
	if event.is_action_pressed(eventName):
		movingbeatsNode.queueConsume()

func getDelay() -> float:
	return movingbeatsNode.timeStartDelay()

func emitBoxCrossed():
	pass

func Consume_on_button_2_pressed() -> void:
	movingbeatsNode.queueConsume()


func _on_target_point_beat_consumed(percent: float) -> void:
	beatConsumed.emit(percent)

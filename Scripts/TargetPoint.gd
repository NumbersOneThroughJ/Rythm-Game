extends Node2D

#editorVariables
@export var Hitbox : ColorRect
@export var goodSound : AudioStreamPlayer
@export var badSound : AudioStreamPlayer

#variables
var distanceThreshold : int

#signals
signal beatConsumed(percent : float)

func getHalfHeight()->float:
	return float(Hitbox.size.y)/2.0

func globalCenterY()->float:
	return float(Hitbox.global_position.y)+getHalfHeight()

func getDistancePercentOfHitbox(target : Node2D) -> float:
	var distance = abs(globalCenterY() - float(target.global_position.y))
	var percent:float =1-(distance/getHalfHeight()) #perecent being 1 is 100 on point
	return max(0, min(percent, 1))
	
func consumeBeat(target : Node2D) -> float:
	var scorePercent = getDistancePercentOfHitbox(target)
	if scorePercent<.3:
		badSound.pitch_scale = randf_range(.5,1.5)
		badSound.play()
	else:
		goodSound.play()
	beatConsumed.emit(scorePercent)
	return scorePercent

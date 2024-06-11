extends Node2D

#editor varibles
@export var particles : GPUParticles2D
@export var feedback : Label

func setFeedback(phrase : String) -> void:
	feedback.text = phrase

func go() ->void:
	particles.restart()

func isEmitting() -> bool :
	return particles.emitting

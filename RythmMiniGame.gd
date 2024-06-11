extends Node2D

#editor variables
@export var BeatPointValue : float
@export var ScoreLabel : Label

#variables
var percentFloat : float

func _ready() -> void:
	percentFloat = 0
	setScoreLabel()

func getScore() -> float:
	return int(percentFloat*BeatPointValue)

func setScoreLabel() -> void:
	ScoreLabel.text = str("Score: ",getScore())

func _on_rythm_path_beat_consumed(percent: float) -> void:
	percentFloat+=percent
	setScoreLabel()

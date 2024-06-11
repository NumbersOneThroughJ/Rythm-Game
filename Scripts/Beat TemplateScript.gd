extends Node2D

#editor variables
@export var sprite : Sprite2D
@export var spriteTexture : Texture2D
@export var feedback : Label
@export var Phrases : Array

#variables
var consume : bool = false
var Score : float

func _ready() -> void:
	sprite.texture = spriteTexture

func _process(delta: float) -> void:
	if !feedback.isFeedbacking() and consume:
		queue_free()
	pass

func queueConsume() -> void:
	consume = true
	sprite.visible = false
	feedback.setTime(.5)

func setScore(score1 : float) -> void:
	Score = score1
	feedback.text = choosePhrase()

func choosePhrase() -> String:
	for phrasePair : Array in Phrases:
		if Score > phrasePair[1]:
			return phrasePair[0]
	return "Bad"

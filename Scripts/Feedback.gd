extends Label

#editor variables
@export var scaleChangeMin:float
@export var scaleChangeMax:float
@export var scaleSpeed:float

#variables
var increaseScale:bool
var scaleChange : float
var baseScale : float
var time : float

func _ready() -> void:
	increaseScale = true
	baseScale = scale.x
	scaleChange = 0

func _process(delta: float) -> void:
	if(isFeedbacking()):
		var scaleChangeChange:float = scaleSpeed * delta
		scaleChangeChange *= 1 if increaseScale else -1
		scaleChange += scaleChangeChange
		
		if increaseScale and scaleChange>=scaleChangeMax:
			increaseScale = false
		elif !increaseScale and scaleChange<=scaleChangeMin:
			increaseScale = true
		scale.x =baseScale+scaleChange
		scale.y =baseScale+scaleChange
		
		time -= delta

func setTime(seconds : float):
	visible = true
	time = seconds

func isFeedbacking()->bool:
	return time>0

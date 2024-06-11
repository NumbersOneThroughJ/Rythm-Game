extends AudioStreamPlayer2D

#editor variabls
@export var RythmPath : Node2D

#variables
var playQueued : bool
var startDelay : float

func _ready() -> void:
	doStartDelay()
	pass

func _process(delta: float) -> void:
	if(startDelay > 0):
		startDelay -= delta
	elif playQueued:
		doPlay()
		playQueued = false

func doPlay()->void:
	if not playing:
		play()

func _on_button_pressed() -> void:
	doPlay()

func doStartDelay() -> void:
	startDelay = RythmPath.getDelay()
	playQueued = true

extends Node2D

const beatTemplate = preload("res://Prefabs/BeatTemplatePrefab.tscn")

#editor variables
@export var spawnPoint : Node2D
@export var targetPoint : Node2D
@export var delayLabel : Label
@export_range(.1, 500) var speed : float
@export var subbeat_intervals : Array
@export var bpm : float = 10

#variables
var MovingBeat_arr : Array

#variables for song
var bps : float
var nextDelay : float
var beatIndex : int
var done : bool
var consumeQueue : int

#signals
signal consumed(globalLocationX : float, globalLocationY : float)

func _ready() -> void:
	done = false
	beatIndex = 0
	bps = bpm/60
	nextDelay = secondsToNextBeat()

func _process(delta: float) -> void:
	nextDelay -= delta
	while consumeQueue>0:
		consumeBeat()
		consumeQueue-=1
	if(nextDelay<=0 and !done):
		addNode()
		done = nextBeat()
		if(!done):
			nextDelay = secondsToNextBeat()
	delayLabel.text = str(nextDelay)
	for node:Node2D in MovingBeat_arr:
		node.position.y -= delta*speed

func setNodeSpawnPoint(addedNode : Node2D) -> void:
	addedNode.position = spawnPoint.position

func addNode()->void:
	var addedNode = beatTemplate.instantiate()
	setNodeSpawnPoint(addedNode)
	add_child(addedNode)
	addedNode.visible = true
	MovingBeat_arr.append(addedNode)

func secondsToNextBeat() -> float:
	var beatLength = subbeat_intervals[beatIndex]
	return (beatLength/4.0)/bps

#returns true when done
func nextBeat() -> bool:
	beatIndex+=1
	return beatIndex == subbeat_intervals.size()

#returns how long it would take for the first beat to reach the target point
func timeStartDelay() -> float:
	var ydistance = spawnPoint.position.y - targetPoint.position.y
	return ydistance/speed

func consumeBeat() -> void:
	var consumedNote = MovingBeat_arr.pop_front()
	#var distance : float = abs(consumedNote.position.y - targetPoint.position.y)
	consumedNote.queueConsume()
	var score = targetPoint.consumeBeat(consumedNote)
	consumedNote.setScore(score)

func queueConsume() -> void:
	consumeQueue+=1

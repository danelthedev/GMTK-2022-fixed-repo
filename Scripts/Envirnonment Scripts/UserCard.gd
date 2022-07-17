extends KinematicBody

onready var moved = false

var originalPos
var newPos
onready var isHovered = false

func _ready():
	originalPos = global_transform.origin
	newPos = global_transform.origin + Vector3(0,0,2)
	translation = Vector3(0, -1, 0)

func drag():
	# use tweens they are much better than animations!!!!
	if moved:
		$Tween.interpolate_property(self, "translation", originalPos, newPos, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	else: 
		$Tween.interpolate_property(self, "translation", newPos, originalPos, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		
	$Tween.start()


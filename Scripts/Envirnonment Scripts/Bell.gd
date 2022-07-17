extends StaticBody

onready var pressed = false
onready var clientGenerator = get_parent().get_parent()

onready var dingSound = preload('res://Assets/Sounds/SFX/bell.wav')

func _process(delta):
	if pressed:
		clientGenerator.dinged = true
		pressed = false
		if !$AudioStreamPlayer.is_playing():
			$AudioStreamPlayer.stream = dingSound
			$AudioStreamPlayer.play()

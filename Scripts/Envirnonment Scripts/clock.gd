extends StaticBody

onready var label = get_node("Viewport/Label")

var currentHour = 18
var currentMinute = 0

var passedTime = 0
var time_mult = .75

func getCurrentTime():
	#passedTime = minute
	var hoursPassed = passedTime / 60
	var minutesPassed = int(passedTime) % 60
	
	currentHour = int(18 + hoursPassed) % 24
	currentMinute = minutesPassed
	
	var timeString:String = '   '
	if currentHour < 10:
		timeString += '0' + str(currentHour) + ':'
	else:
		timeString +=  str(currentHour) + ':'
	
	if currentMinute < 10:
		timeString += '0' + str(currentMinute)
	else:
		timeString +=  str(currentMinute)
	
	label.text = timeString
	

func _process(delta):
	passedTime += delta * time_mult
	getCurrentTime()
	
	

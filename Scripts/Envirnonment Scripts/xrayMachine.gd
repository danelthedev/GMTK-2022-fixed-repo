extends StaticBody

#export(NodePath) var monitorPath 
#onready var monitor = get_node(monitorPath)
onready var monitor = get_node('../../Monitor')

onready var status = 'insert dice'
onready var pressed = false

onready var diceInArea = false
onready var dice = null

var proccessingTimer = 0

func _process(delta):
	get_node("../Viewport/Label").text = status
	
	if diceInArea == false:
		status = 'insert dice'	
	elif diceInArea and dice.mode == RigidBody.MODE_RIGID && status != 'done':
		status = 'waiting'
	
	if pressed == true:
		print("PRESSED")
		if status == 'waiting':
			proccessingTimer = 900
		pressed = false

	if proccessingTimer > 0:
		status = 'processing'
		proccessingTimer -= 1
		if proccessingTimer == 0:
			status = 'done'
			if dice.rigged == false:
				monitor.setTex(0)
			else:
				monitor.setTex(1)
			

func _on_DiceArea_body_entered(body):
	if body.name == 'Dice':
		diceInArea = true
		dice = body

func _on_DiceArea_body_exited(body):
	if body.name == 'Dice':
		diceInArea = false
		dice = null

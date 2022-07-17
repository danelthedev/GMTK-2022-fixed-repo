extends Node

onready var client = get_node("Client")

onready var userCard = get_node("Interactables/UserCard")
onready var cardInfo = userCard.get_node("Viewport/Label")

onready var dice = get_node("Interactables/Dice")

onready var ledger = get_node("Interactables/Ledger")
onready var ledgerInfo = ledger.get_node("Viewport/Label")

onready var tray = get_node("Interactables/Tray")

onready var bin = get_node("Interactables/Bin")

onready var player = get_node("Player")
onready var ui = get_node("Player/Pivot/Camera/Obj")
onready var result = get_node("Player/Pivot/Camera/ResultMsg")

onready var npcBasePath = 'res://Assets/Sprites/characters'

onready var bossPath = npcBasePath + '/boss'
onready var man1Path = npcBasePath + '/char1'
onready var man2Path = npcBasePath + '/man'
onready var policePath = npcBasePath + '/police'

onready var woman1Path = npcBasePath + '/woman'
onready var woman2Path = npcBasePath + '/woman2'
onready var kidsPath = npcBasePath + '/kids'


var genders = ['Male', 'Female']

var maleFirstNames = ['Michael', 'John', 'Bob', 'Jeff', 'Walter', 'Jessi', 'Ted', 'Mike', 'Fred']
var femaleFirstNames = ['Evelyn', 'Joane', 'Amy', 'Anne', 'Mary']

var lastNames = ['Marley', 'Bolsa', 'Johansen', 'Corsa', 'Bobson', 'White', 'Mocanu']

var additionalNotes = ['Big spender', 'Suspected of cheating', 'Trouble maker', 'Generous gambler']

class userData:
	
	var gen: String
	var firstName: String
	var lastName: String
	var dateOfBirth: String
	var userNumber: String
	var notes: String
	
	var cheater:bool
	
	func _init(gen, firstName, lastName, userNumber, dateOfBirth, notes, cheater):
		self.gen = gen
		self.firstName = firstName
		self.lastName = lastName
		
		self.userNumber = userNumber
		self.dateOfBirth = dateOfBirth
		
		self.notes = notes
		
		self.cheater = cheater
				
	func getUserCard():
		var string:String
		string = self.firstName + ' ' + self.lastName + '\n        ' + self.userNumber + '\n        ' + self.dateOfBirth
		return string
	
	func getLedgerInfo():
		var string:String
		string = ''
		string = 'Name: ' + self.firstName + ' ' + self.lastName + '\nUser number:' + self.userNumber + '\nDate of birth:' + self.dateOfBirth
		return string
	
	func generateDate():
		var date:String = ''
		date += str(randi() % 31 + 1) + '/' + str(randi() % 12 + 1) + '/' + str(randi() % 30 + 1970)
		return date
	
	func getFakeLedgerInfo():
		var string:String
		string = ''
		
		var wrongType = randi() % 4
		
		match wrongType:
			0:
				var firstname
				var maleFirstNames = ['Michael', 'John', 'Bob', 'Jeff', 'Walter', 'Jessi', 'Ted', 'Mike', 'Fred']
				var femaleFirstNames = ['Evelyn', 'Joane', 'Amy', 'Anne', 'Mary']
				
				if self.gen == 'Male':
					firstName = maleFirstNames[randi() % maleFirstNames.size()]
				else:
					firstName = femaleFirstNames[randi() % femaleFirstNames.size()]	
					
				string = 'Name: ' + firstName + ' ' + self.lastName + '\nUser number:' + self.userNumber + '\nDate of birth:' + self.dateOfBirth
			
			1:
				
				var lastNames = ['Marley', 'Bolsa', 'Johansen', 'Corsa', 'Bobson', 'White', 'Mocanu']
				var lastName = lastNames[randi() % lastNames.size()]
				string = 'Name: ' + self.firstName + ' ' + lastName + '\nUser number:' + self.userNumber + '\nDate of birth:' + self.dateOfBirth
			
			2:
				var userNumber = str(randi() % 10000)
				string = 'Name: ' + self.firstName + ' ' + self.lastName + '\nUser number:' + userNumber + '\nDate of birth:' + self.dateOfBirth
			
			3:
				var dateOfBirth = generateDate()
				string = 'Name: ' + self.firstName + ' ' + self.lastName + '\nUser number:' + self.userNumber + '\nDate of birth:' + dateOfBirth
			
			
		return string


func generateDate():
	var date:String = ''
	date += str(randi() % 31 + 1) + '/' + str(randi() % 12 + 1) + '/' + str(randi() % 30 + 1970)
	return date

func generateUser():
	var index = randi() % 10
	var gender
	if index > 7:
		gender = 'Female'
	else:
		gender = 'Male'
	
	
	if gender == 'Female':
		var skin = randi() % 2
		match skin:
			0:
				client.get_node("Sprite3D").texture = load(woman1Path + '/woman1_neutral.png')
			1:
				client.get_node("Sprite3D").texture = load(woman2Path + '/woman2_neutral.png')	
			
	else:
		var skin = randi() % 5
		match skin:
			0:
				client.get_node("Sprite3D").texture = load(bossPath + '/boss_neutral.png')
			1:
				client.get_node("Sprite3D").texture = load(man1Path + '/char1_neutral.png')
			2:
				client.get_node("Sprite3D").texture = load(man2Path + '/man1_neutral.png')
			3:
				client.get_node("Sprite3D").texture = load(policePath + '/police_neutral.png')
			4:
				client.get_node("Sprite3D").texture = load(kidsPath + '/kids_neutral.png')
		
			
	var firstName
	if gender == 'Male':
		firstName = maleFirstNames[randi() % maleFirstNames.size()]
	else:
		firstName = femaleFirstNames[randi() % femaleFirstNames.size()]		
		
	var lastName = lastNames[randi() % lastNames.size()]
	
	var userNumber = str(randi() % 10000)
	var birthday = generateDate()

	var notes = additionalNotes[randi() % additionalNotes.size()]
	
	#cheater status
	var cheaterChance = randf()
	var cheaterStatus
	if cheaterChance > 0.7:
		cheaterStatus = true
	else:
		cheaterStatus = false
	
	var user = userData.new(gender, firstName, lastName, userNumber, birthday, notes, cheaterStatus)
	
	return user

var clientStatus = 0
var dinged = false

func createNewClient():
	#get client data
	var newUser = generateUser()
	var userCard = newUser.getUserCard()
	var ledgerData = newUser.getLedgerInfo()
	
	cardInfo.text = userCard
	ledgerInfo.text = ledgerData
	
	if newUser.cheater == true:
		isCheater = true
		print("ChEATER")
		
		var cheaterType = randf()
		
		if cheaterType > 0.8:
			ledgerData = newUser.getFakeLedgerInfo()
			ledgerInfo.text = ledgerData
		else:
			dice.rigged = newUser.cheater
	else:
		isCheater = false
		dice.rigged = false
		
	client.resetPos()
	client.comeIn()

var isCheater = false
var hadFirstClient = false

func _ready():
	ui.bbcode_text = "Current objective:\nDing the bell to call next client"
	result.bbcode_text = ""
	

func _process(delta):
	randomize()
	
	#print(clientStatus)
	
	if dinged:
		#client enters
		if clientStatus == 0:
			hadFirstClient = true
			
			ui.bbcode_text = "Current objective:\nInspect the dice and the card"
			result.bbcode_text = ""
			createNewClient()
			clientStatus = 1
			
			var diceMesh = dice.get_node("MeshInstance")
			diceMesh.set_surface_material(0, dice.diceMats[randi() % 4])
			diceMesh.get_surface_material(0).set_next_pass(dice.outline)
			
			
			bin.hasDice = false
			dice.translation = dice.originalPos
			userCard.translation = userCard.originalPos
			
		#client leaves
		elif clientStatus == 1 && userCard.moved == false && ((tray.moved == false && tray.hasDice == true) or bin.hasDice == true):
			ui.bbcode_text = "Current objective:\nDing the bell to call next client"
			client.leave()
			clientStatus = 0
			
			if hadFirstClient:
				if isCheater && tray.hasDice:
					result.bbcode_text = "You let a cheater through"
				elif isCheater && !tray.hasDice:
					result.bbcode_text = "You cought a cheater"
				elif !isCheater && tray.hasDice:
					result.bbcode_text = "You let a legit customer in"
				elif !isCheater && !tray.hasDice:
					result.bbcode_text = "You denied a legit customer"
					
			
			bin.hasDice = false
				
			dice.translation = Vector3(0, -3, 0)
			userCard.translation = Vector3(0, -3, 0)
			userCard.moved = false
			
			
		else:
			ui.bbcode_text = "To continue, the user card must be near the client\nand the dice on the tray near him\nor in the bin"
					

		dinged = false

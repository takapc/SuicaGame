extends Node2D

@export var AllCards: Array[PackedScene]
var nowIndex
var nextIndex = randi_range(0,3)
var totalScore = 0

func change_image():
	
	nowIndex = nextIndex
	nextIndex = randi_range(0,3)
	
	var texture = load("res://Drops/Card"+str(nowIndex)+".png")
	$SelectCard.texture = texture
	$SelectCard.show()
	
	texture = load("res://Drops/Card"+str(nextIndex)+".png")
	$NextCard.texture = texture

func _ready():
	change_image()
	
func _process(delta):
	$SelectCard.position = $Player.position
	$SelectCard.position.y += 60
	
	$Score.text = str(totalScore)
	
	if Input.is_action_just_pressed("drop",true) and $SelectCard.visible and not $GameOver.visible:
		drop()
		await get_tree().create_timer(1.0).timeout
		change_image()

func drop():
	var dropCard = AllCards[nowIndex].instantiate()
	add_child(dropCard)
	dropCard.position = $SelectCard.position
	
	$SelectCard.hide()
	
func add_score(amount):
	totalScore += amount

func  game_over():
	$SelectCard.hide()
	$GameOver.show()
	$Limit.get_node("CollisionShape2D").call_deferred("disabled", true)
	get_tree().call_group("Cards", "jump_out")
	
	$GameOver.visible = true


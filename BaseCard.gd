extends RigidBody2D

@export var NextCard: PackedScene
@export var GroupName = "Card0s"
@export var score = 0
var isChecked = false

func _ready():
	add_to_group(GroupName)

func getChecked():
	return isChecked

func setChecked():
	isChecked = true
	
func _on_body_entered(body):
	if NextCard and body.is_in_group(GroupName) and body.position >= position and not body.isChecked:
		
		isChecked = true
		body.setChecked()
		
		var popCard = NextCard.instantiate()
		var popPos = (body.position + position) / 2
		popCard.position = popPos
		get_parent().call_deferred("add_child", popCard)
		get_parent().call_deferred("add_score", score)
	
		body.queue_free()
		queue_free()
	if body.name == "Limit":
		get_parent().call_deferred("game_over")

func jump_out():
	var center = Vector2(455,400)
	var foreceDirecton = (position - center).normalized()
	
	var shootSpeed = 500
	var shootForce = foreceDirecton * shootSpeed
	apply_central_force(shootForce)
	$CollisionShape2D.set_deferred("disabled",true)

extends Sprite2D

var speed = 5

func _process(delta):
	var input := Vector2.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	
	position.x += input.x * speed
	
	var width = 120
	
	if position.x > 450+width:
		position.x = 450+width
	if position.x < 450-width:
		position.x = 450-width

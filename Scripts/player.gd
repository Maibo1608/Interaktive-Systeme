extends CharacterBody2D


@export var speed = 400
var screen_size 


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()

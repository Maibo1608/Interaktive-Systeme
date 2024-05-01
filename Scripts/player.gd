extends CharacterBody2D

@onready var visuals = $visuals

@export var speed = 400
var screen_size 


func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		visuals.play()
		visuals.animation = "Run"
	else:
		visuals.animation = "Idle"
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	move_and_slide()
	if velocity.x != 0:
		visuals.flip_v = false
	# See the note below about boolean assignment.
		visuals.flip_h = velocity.x < 0


func _on_area_2d_body_entered(body):
	body.queue_free()

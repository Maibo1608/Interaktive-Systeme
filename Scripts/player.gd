extends CharacterBody2D
@onready var animation_player := $visuals/AnimationPlayer
@onready var visuals = $visuals
@onready var healthbar = $Healthbar
@onready var melee_attack_1 = $visuals/melee_attack1

 

const MAX_HEALTH = 100

var health = 100

@export var speed = 400

var is_attacking := false

func _ready():
	healthbar.max_value = MAX_HEALTH
	healthbar.value = health
	
func set_health_bar () -> void:
	healthbar.value = health

func _physics_process(delta):
	var velocity = Vector2.ZERO
	if not is_attacking:
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
	move_and_slide()
	if velocity.x != 0:
		visuals.flip_v = false
	# See the note below about boolean assignment.
		visuals.flip_h = velocity.x < 0
		if velocity.x < 0:
			melee_attack_1.rotation_degrees = 180
		else:
			melee_attack_1.rotation_degrees = 0
	if Input.is_action_just_pressed("attack"):
		print("attack")
		is_attacking = true
		melee_attack_1.monitoring = true
		visuals.animation = "melee_attack1"
		visuals.play()
		


func damage(value) -> void:
	health -= value
	set_health_bar()
	print("damage", value)
	if health <= 0:
		print("dead")
	

func _on_area_2d_body_entered(body):
	damage(body.dam)
	body.queue_free()



func _on_visuals_animation_finished():
	if is_attacking:
		is_attacking = false
		melee_attack_1.monitoring = false


func _on_melee_attack_1_body_entered(body):
	body.take_damage(1)

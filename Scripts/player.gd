extends CharacterBody2D

signal dying
signal lvlup

@onready var visuals = $visuals
@onready var healthbar = $Healthbar
@onready var animation_player = $AnimationPlayer
@onready var silhouette = $silhouette

 
#Player Stats
var max_health = 100
var current_xp = 0
var xp_threshold = 100
var current_lvl = 1
var health = 100
var speed = 400

#Ability Levels
var attack1_lvl = 1
var attack2_lvl = 1
var heart_lvl = 0
var boots_lvl = 0

func _ready():
	healthbar.max_value = max_health
	healthbar.value = health
	
func set_health_bar () -> void:
	healthbar.value = health

func _process(delta):
	if current_xp >= xp_threshold:
		current_xp -= xp_threshold
		current_lvl += 1
		xp_threshold+=100
		lvlup.emit()
func _physics_process(delta):
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
		visuals.play("Run")
		
	else:
		visuals.play("Idle")
	position += velocity * delta
	move_and_slide()
	if velocity.x != 0:
		visuals.flip_v = false
	# See the note below about boolean assignment.
		visuals.flip_h = velocity.x < 0
	
	silhouette.animation = visuals.animation
	silhouette.frame = visuals.frame
	silhouette.flip_v = visuals.flip_v
	silhouette.flip_h = visuals.flip_h


func damage(value) -> void:
	health -= value
	set_health_bar()
	print("damage", value)
	if health <= 0:
		dying.emit()
		print("dead")
	

func _on_area_2d_body_entered(body):
	if body.is_dying == false:
		damage(body.dam)
		body.queue_free()
	if body.is_dying == true:
		pass





func _on_melee_attack_1_body_entered(body):
	body.take_damage(1)
	print("hit")


func attack1():
	animation_player.play("attack1")


func attack2():
	var fireball = preload("res://Scenes/attacks/fireball.tscn").instantiate()
	fireball.global_position = global_position
	get_parent().add_child(fireball)
	

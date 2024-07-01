extends CharacterBody2D

signal dying
signal lvlup

@onready var visuals = $visuals
@onready var healthbar = $Healthbar
@onready var animation_player = $AnimationPlayer
@onready var silhouette = $silhouette
@onready var hit = $Hit
@onready var damage_sound = $Damage
@onready var health_label = $Healthbar/health_label
@onready var normal_attack = $normal_attack
@onready var normal_attack_hitbox = $normal_attack/hitbox
@onready var normal_attack_visual = $normal_attack/attack_visual

var is_attacking := false

#Player Stats
var max_health = 100
var current_xp = 0
var xp_threshold = 100
var current_lvl = 1
var health = 100
var speed = 400

#Ability Levels
var attack1_lvl = 0
var attack2_lvl = 0
var heart_lvl = 0
var boots_lvl = 0

func _ready():
	healthbar.max_value = max_health
	healthbar.value = health
	

func _process(delta):
	health_label.text = "%d / %d" % [health, max_health]
	if current_xp >= xp_threshold:
		current_xp -= xp_threshold
		current_lvl += 1
		xp_threshold+=100
		lvlup.emit()
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
			visuals.play("Run")
			
		else:
			visuals.play("Idle")
		position += velocity * delta
	move_and_slide()
	if velocity.x != 0:
		visuals.flip_v = false
	# See the note below about boolean assignment.d
		visuals.flip_h = velocity.x < 0
		
		if velocity.x < 0:
			normal_attack.rotation_degrees = 180
		else:
			normal_attack.rotation_degrees = 0
	if Input.is_action_pressed("attack"):
		normal_attack_hitbox.monitoring = true
		normal_attack_visual.visible = true
		visuals.play("melee_attack1")
		normal_attack_visual.play("default")
		is_attacking = true
		
	
	
	silhouette.animation = visuals.animation
	silhouette.frame = visuals.frame
	silhouette.flip_v = visuals.flip_v
	silhouette.flip_h = visuals.flip_h



func damage(value) -> void:
	health -= value
	healthbar.value -= value
	print("damage", value)
	if health <= 0:
		dying.emit()
		print("dead")
	

func _on_area_2d_body_entered(body):
	if body.is_dying == false:
		damage(body.dam)
		damage_sound.play()
		
	if body.is_dying == true:
		pass






func _on_melee_attack_1_body_entered(body):
	body.take_damage(attack1_lvl)
	hit.play()
	print("hit")


func attack1():
	if attack1_lvl >= 1:
		animation_player.play("attack1")


func attack2():
	if attack2_lvl >= 1:
		var fireball = preload("res://Scenes/attacks/fireball.tscn").instantiate()
		fireball.global_position = global_position
		fireball.dmg = attack2_lvl
		get_parent().add_child(fireball)
	


func _on_visuals_animation_finished():
	if is_attacking:
		is_attacking = false
		normal_attack_hitbox.monitoring = false


func _on_normal_attack_body_entered(body):
	body.take_damage(1)
	hit.play()


func _on_attack_visual_animation_finished():
	normal_attack_visual.visible = false

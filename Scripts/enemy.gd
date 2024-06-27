extends RigidBody2D

@onready var visuals = $visuals
@onready var silhouette = $silhouette
@onready var healthbar = $Healthbar
@onready var player = get_tree().get_first_node_in_group("player")

signal killed(points, xp)

var is_dying = false
var got_hit = false
@export var health:= 1
@export var max_health:= 1
@export var dam: = 10.0
@export var points = 100
@export var spawn_time = 10;
@export var xp = 50
@export var showHealthbar = false;

@export var speed := 100.0
#var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	visuals.animation = "idle2"
	visuals.play()
	
	if (showHealthbar == true):
		healthbar.visible = true
		healthbar.max_value = max_health
		healthbar.value = health
			

func set_health_bar () -> void:
	healthbar.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_dying:
		if (global_position.direction_to(player.global_position)).x < 0:
			visuals.flip_h = true
		else:
			visuals.flip_h = false
		position = position + (global_position.direction_to(player.global_position) * speed * delta)
	silhouette.animation = visuals.animation
	silhouette.frame = visuals.frame
	silhouette.flip_v = visuals.flip_v
	silhouette.flip_h = visuals.flip_h


func take_damage(amount: int)-> void:
	
	health = health-amount
	if (showHealthbar == true):
		set_health_bar()
	
	
	if health <= 0:
		print("got hit, current health: ", health)
		print("dead body")
		is_dying = true
		visuals.play("die")
		killed.emit(points, xp)
	if health > 0: 
		print("got hit, current health: ", health)
		got_hit = true
		visuals.play("hurt")
			
		
		

#
#func _on_hitbox_area_entered(area):
	#pass # Replace with function body.


func _on_visuals_animation_finished():
	if got_hit:
		_ready()
		got_hit = false
	if is_dying:
		queue_free()

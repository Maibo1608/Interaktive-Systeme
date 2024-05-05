extends RigidBody2D

@onready var visuals = $visuals


signal killed(points)

var flag = false
var health:= 1
var dam: = 10.0
@export var points = 100

var speed := 100.0
var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	visuals.animation = "idle2"
	visuals.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = position + (global_position.direction_to(player.global_position) * speed * delta)


func take_damage(amount: int)-> void:
	
	health = health-amount
	print("current health: ", health)
	
	if health <= 0:
		print("dead body")
		visuals.play("die")
		killed.emit(points)
		if visuals.is_playing() == false:
			queue_free()
		


func _on_hitbox_area_entered(area):
	pass # Replace with function body.




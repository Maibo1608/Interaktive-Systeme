extends RigidBody2D

var speed := 100.0
var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = position + (global_position.direction_to(player.global_position) * speed * delta)

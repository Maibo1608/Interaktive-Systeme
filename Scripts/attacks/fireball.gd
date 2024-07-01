extends Node2D

@onready var animation = $animation

var dmg = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = randf_range(0,360)
	animation.play("attack")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += Vector2(5,0).rotated(rotation)


func _on_hitbox_body_entered(body):
	body.take_damage(dmg)
	queue_free()

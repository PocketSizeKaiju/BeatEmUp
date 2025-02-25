extends RigidBody2D

var tirada = true
var summoner: Vector2

func _ready() -> void:
	self.global_position = summoner

func _physics_process(delta: float) -> void:
	if tirada:
		apply_impulse(Vector2(90, -10), Vector2(90, -10))
		tirada = false

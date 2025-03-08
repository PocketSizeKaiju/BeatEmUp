extends RigidBody2D

var tirada = true
var summoner: Vector2
var direccion_cardinal: Vector2

@onready var timer: Timer = $Timer as Timer

func _ready() -> void:
	self.global_position = summoner

func _physics_process(delta: float) -> void:
	if tirada:
		apply_impulse((direccion_cardinal*100), Vector2(90, -10))
		tirada = false
		timer.start()

func _cuando_se_acabo() -> void:
	self.queue_free()

func _cuando_atrapar_poke(body: Node2D) -> void:
	print(body)

extends Marker2D

const POKE_BOLA = preload("res://PokeBola/Escenas/poke_bola.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and Input.is_action_just_pressed("especial"):
		var poke_bola_instance = POKE_BOLA.instantiate()
		poke_bola_instance.summoner = self.global_position
		add_child(poke_bola_instance)

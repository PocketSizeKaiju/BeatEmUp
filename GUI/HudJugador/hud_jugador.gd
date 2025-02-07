extends CanvasLayer

@onready var hp_bar: ProgressBar = $Control/HPBar

func _ready() -> void:
	pass

func actualizar_hp(_hp: int, _max_hp: int) -> void:
	hp_bar.value = _hp
	hp_bar.max_value = _max_hp

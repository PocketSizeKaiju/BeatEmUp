class_name PokeBola
extends RigidBody2D

var tirada = true
var summoner: Vector2
var direccion_cardinal: Vector2
var poke
var poke_pos

@onready var timer: Timer = $Timer as Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

signal pokeAtrapado(poke:Enemigo)

func _ready() -> void:
	self.global_position = summoner

func _physics_process(_delta: float) -> void:
	if tirada:
		apply_impulse((direccion_cardinal*100), Vector2(90, -10))
		tirada = false
		timer.start()
	if poke:
		poke.global_position = poke_pos

func _cuando_se_acabo() -> void:
	self.queue_free()

func _cuando_toca_poke(pokemon: Enemigo) -> void:
	if pokemon.hp:
		poke = pokemon
		poke_pos = poke.global_position
		animation_player.play("AtraparPoke")
		poke.visible = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "AtraparPoke"):
		animation_player.play("wiggle")
	elif(anim_name == "wiggle"):
		var hp_percentage = poke.hp / poke.hp_maximo
		var catch_chance = 1.0 - hp_percentage
		catch_chance *= 0.35 
		if randf() < catch_chance:
			print("Pokémon caught!")
			emit_signal("pokeAtrapado", poke)
			poke.queue_free()
			self.queue_free()
		else:
			print("Pokémon escaped!")
			poke.visible = true
			poke = null
			self.queue_free()

class_name MaquinaDeEstadoEnemigo
extends Node

var estados : Array [EstadoEnemigo]
var estado_anterior : EstadoEnemigo
var estado_actual : EstadoEnemigo

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	cambiarEstado(estado_actual.proceso(delta))

func _physics_process(delta: float) -> void:
	cambiarEstado(estado_actual.fisica(delta))

func inicializar(_enemigo: Enemigo) -> void:
	estados = []
	
	for estado in get_children():
		if estado is EstadoEnemigo:
			estados.append(estado)
	
	for estado in estados:
		estado.enemigo = _enemigo
		estado.maquina_estado = self
		estado.init()
	
	if estados.size() > 0:
		cambiarEstado(estados[0])
		process_mode = Node.PROCESS_MODE_INHERIT
		
func cambiarEstado(estado_nuevo : EstadoEnemigo) -> void:
	if estado_nuevo == null || estado_nuevo == estado_actual:
		return
	
	if estado_actual: 
		estado_actual.salir() 
	
	estado_anterior = estado_actual
	estado_actual = estado_nuevo
	estado_actual.entrar()

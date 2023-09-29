extends CharacterBody2D
class_name Player

#variables
var speed := 120
var direccion := 0.0
var jum := 250

#constantes
const gravity := 9

#cuando inicia
@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
@onready var frutaslabel := $PlayerGUI/HBoxContainer/FrutasLabel

func _ready():
	Global.player = self

#fisica
func _physics_process(delta):
	
	#Movimiento izquierda y derecha
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
	
	#Direccion
	if direccion != 0:
		anim.play("walk")
		
	else:
		anim.play("idle")
	
	#Posicion del sprite
	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	
	#Salto
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -= jum
		
	if !is_on_floor():
		velocity.y += 9
	
	#Funcion de movimiento
	move_and_slide()
	
func actualizarInterfazFrutas():
		frutaslabel.text = str(Global.frutas)

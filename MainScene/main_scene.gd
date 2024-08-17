class_name MainScene
extends Node2D
const gameover_scene : PackedScene = preload ("res://menuUI/game_over.tscn")
const pausemenu_scene : PackedScene = preload("res://menuUI/paused.tscn")
var pause_menu : Paused
var gameover_menu : GameOver

@onready var snake_head = $SnakeHead as SnakeHead
@onready var bounds: Bounds = $Bounds as Bounds
@onready var spawner: Spawner = $Spawner as Spawner
@onready var score_ui = $ScoreUI




var time_between_moves: float = 300.0
var time_since_last_move: float = 0 
var speed: float = 2000.0
var snake_parts: Array[SnakePart] = []
var score : int :
	get:
		return score
	set(value):
		score = value 
		score_ui.update_score(value)


var moveDirection : Vector2 = Vector2.RIGHT #Vector2(1,0)

func _ready() -> void:
	snake_head.food_eaten.connect(_on_food_eaten)
	snake_head.collided_with_tail.connect(_on_collided_with_tail)
	spawner.tail_added.connect(_on_tail_added)
	spawner.spawn_food()
	snake_parts.push_back(snake_head)
	time_since_last_move = time_between_moves
	
func _process(_delta: float) -> void:
	var newDirection: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		newDirection = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		newDirection = Vector2.RIGHT
	elif Input.is_action_pressed("ui_up"):
		newDirection = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		newDirection = Vector2.DOWN
		
	if newDirection + moveDirection != Vector2.ZERO and newDirection != Vector2.ZERO:
		moveDirection = newDirection
	
	if Input.is_action_pressed("ui_cancel"):
		pause_game()
	
func _physics_process(delta: float) -> void: 
	time_since_last_move = time_since_last_move + delta * speed 
	if time_since_last_move >= time_between_moves:
		update_snake()
		time_since_last_move = 0 


func update_snake():
	var new_pos: Vector2 = snake_head.position + moveDirection * Globals.GRID_SIZE
	new_pos = bounds.wrap_vector(new_pos)
	snake_head.move_to(new_pos)
	for i in range(1, snake_parts.size(), 1):
		snake_parts[i].move_to(snake_parts[i-1].last_position)
	
func _on_food_eaten():
	spawner.call_deferred("spawn_food")
	spawner.call_deferred("spawn_tail", snake_parts[snake_parts.size()- 1].last_position)
	speed += 250
	score += 1
	print("food eaten")
	
func _on_tail_added(tail:Tail):
	snake_parts.push_back(tail)

func _on_collided_with_tail():
	print("gg")
	if not gameover_menu: 
		gameover_menu = gameover_scene.instantiate()
		add_child(gameover_menu)
		gameover_menu.set_score(score)

func _notification(what):
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		pause_game()
		
func pause_game():
	if not pause_menu:
		pause_menu = pausemenu_scene.instantiate() as Paused
		add_child(pause_menu)
















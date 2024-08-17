class_name Spawner
extends Node2D
signal tail_added(tail: Tail)
@export var bounds: Bounds
@export var food_scene : PackedScene
@export var tail_scene : PackedScene

func spawn_food():
	var spawn_point: Vector2 = Vector2.ZERO
	spawn_point.x = randf_range(bounds.x_min + Globals.GRID_SIZE, bounds.x_max - Globals.GRID_SIZE)
	spawn_point.y = randf_range(bounds.y_min + Globals.GRID_SIZE, bounds.y_max - Globals.GRID_SIZE)
	spawn_point.x = floorf(spawn_point.x / Globals.GRID_SIZE) * Globals.GRID_SIZE
	spawn_point.y = floorf(spawn_point.y / Globals.GRID_SIZE) * Globals.GRID_SIZE
	var food = food_scene.instantiate()
	food.position = spawn_point
	get_parent().add_child(food)

func spawn_tail(pos:Vector2):
	var tail: Tail = tail_scene.instantiate() as Tail
	tail.position = pos 
	get_parent().add_child(tail)
	tail_added.emit(tail)

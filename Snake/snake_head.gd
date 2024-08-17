class_name SnakeHead
extends SnakePart

signal food_eaten
signal collided_with_tail

func _on_area_entered(area):
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		collided_with_tail.emit()
		

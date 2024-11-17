extends Node2D


@onready var title: Sprite2D = $Title
@onready var start_y := title.position.y

var timer := 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	
	title.position.y = start_y + 5 * sin(timer * 2)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")

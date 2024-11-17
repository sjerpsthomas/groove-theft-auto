class_name Car
extends Node2D

@onready var cars := get_parent()
@onready var world := cars.get_parent()

var active := true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not active: return
	
	var player := body as Player
	if player == null: return
	
	if world.selected_car != null:
		world.selected_car.deselect()
	
	select()

func select() -> void:
	world.selected_car = self

func _on_area_2d_body_exited(body: Node2D) -> void:
	if not active: return
	
	var player := body as Player
	if player == null: return
	
	deselect()

func deselect() -> void:
	world.selected_car = null

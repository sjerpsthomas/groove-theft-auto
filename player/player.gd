class_name Player
extends CharacterBody2D

@onready var world := get_parent()

var left: bool
var right: bool
var up: bool
var down: bool

var mounted_car: Car


func _physics_process(delta: float) -> void:
	var h := float(right) - float(left)
	var v := float(down) - float(up)
	
	var speed := 100 if mounted_car != null else 40
	
	velocity += Vector2(h, v).normalized() * speed
	velocity /= 1.4
	
	move_and_slide()
	
	if mounted_car != null:
		if velocity.length() > 0:
			mounted_car.update_sprite(velocity.angle())


func _unhandled_input(event: InputEvent) -> void:
	var handled := true
	
	if event.is_action("player_left"): left = event.is_pressed()
	elif event.is_action("player_right"): right = event.is_pressed()
	elif event.is_action("player_up"): up = event.is_pressed()
	elif event.is_action("player_down"): down = event.is_pressed()
	elif event.is_action_pressed("player_mount"): handled = try_toggle_mount()
	
	else: handled = false
	
	if handled: get_viewport().set_input_as_handled()


func try_toggle_mount() -> bool:
	if mounted_car != null:
		return try_unmount()
	else:
		return try_mount()


func try_unmount() -> bool:
	remove_child(mounted_car)
	world.cars.add_child(mounted_car)
	mounted_car.active = true
	mounted_car.global_position = global_position
	
	mounted_car = null
	
	return true

func try_mount() -> bool:
	var selected_car: Car = world.selected_car
	if selected_car == null: return false
	
	world.selected_car = null
	selected_car.active = false
	selected_car.get_parent().remove_child(selected_car)
	add_child(selected_car)
	selected_car.position = Vector2.ZERO
	
	mounted_car = selected_car
	
	return true

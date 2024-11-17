class_name Car
extends CharacterBody2D

@onready var cars := get_parent()
@onready var world := cars.get_parent()

var active := true:
	set(new_active):
		active = new_active
		$Shape.disabled = not active

var rot := 0.0


func _physics_process(delta: float) -> void:
	velocity = velocity * exp(-2.2 * delta)
	
	move_and_slide()


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


func update_sprite(angle: float) -> void:
	rot = lerp_angle(rot, angle, 0.15)
	
	var angle_deg := fposmod(rad_to_deg(rot), 360.0)
	if angle_deg > 180: angle_deg -= 360
	
	var effective_angle := angle_deg
	
	var sprite: int
	
	if angle_deg >=  -45 and angle_deg <=   45:
		sprite = 0
		effective_angle -= 0
	if angle_deg >=   45 and angle_deg <=  135:
		sprite = 1
		effective_angle -= 90
	if angle_deg >=  135 or  angle_deg <= -135:
		sprite = 2
		effective_angle -= 180
	if angle_deg >= -135 and angle_deg <=  -45:
		sprite = 3
		effective_angle -= 270
	
	for s: Sprite2D in $Sprite.get_children(): s.visible = false
	var sprite2d: Sprite2D = $Sprite.get_child(sprite)
	
	sprite2d.visible = true
	sprite2d.rotation_degrees = effective_angle

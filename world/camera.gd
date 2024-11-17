extends Camera2D


@export var player: Player


func _process(delta: float) -> void:
	var pos := player.global_position
	pos += player.velocity * 0.5
	
	global_position = global_position.lerp(pos, 0.04)
	
	var target_zoom := 1.0 if player.mounted_car == null else 0.7
	zoom = Vector2.ONE * lerp(zoom.x, target_zoom, 0.15)
	

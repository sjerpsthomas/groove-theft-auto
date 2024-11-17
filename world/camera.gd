extends Camera2D


@export var player: Player

var timer := 0.0


func _process(delta: float) -> void:
	var pos := player.global_position
	pos += player.velocity * 0.5
	
	if player.mounted_car != null:
		timer += delta
	
	var shake_offset := Vector2(sin(6.7 * timer + 2), sin(5.592 * timer)) * (2 + player.velocity.length() * .1)
	pos += shake_offset
	
	global_position = global_position.lerp(pos, 0.04)
	
	var target_zoom := 1.0 if player.mounted_car == null else 0.7
	zoom = Vector2.ONE * lerp(zoom.x, target_zoom, 0.15)
	

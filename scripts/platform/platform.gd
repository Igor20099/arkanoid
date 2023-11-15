extends Node2D


func _physics_process(delta):
	position.x = clamp(get_global_mouse_position().x,74,540) 
	


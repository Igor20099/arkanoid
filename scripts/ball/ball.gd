extends KinematicBody2D


var speed = 600
var velocity = Vector2(0,1)


func _physics_process(delta):
	var coll_object = move_and_collide(velocity * speed * delta)
	if coll_object:
		velocity = velocity.bounce(coll_object.normal)


func _on_Area2D_body_entered(body):
	if body.is_in_group('block'):
		Global.scores +=100
		Events.emit_signal("change_scores")
		var parent = body.get_parent()
		body.queue_free()
		print(parent.get_child(1))
		parent.get_child(2).play()
		parent.get_child(1).set_emitting(true) 
		yield(get_tree().create_timer(0.5),"timeout")
		parent.queue_free()


func _on_VisibilityEnabler2D_screen_exited():
	Events.emit_signal("game_over")
	yield(get_tree().create_timer(2),"timeout")
	get_tree().reload_current_scene()
	Global.scores = 0

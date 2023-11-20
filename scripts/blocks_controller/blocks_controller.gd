extends Node2D



onready var block_destroy_sound = $BlockDestroySound
var pos_x = 8
var pos_y = 65
var pos_x_offset = 120
var block_preload
var block


func _ready():
	Events.connect("change_scores",self,'play_sound')
	block_preload = preload("res://game_objects/block.tscn")

func play_sound():
	 block_destroy_sound.play()
	 print(block_destroy_sound.volume_db)
	
func generate_block():
	block = block_preload.instance()
	block.position= Vector2(pos_x,pos_y)
	add_child(block)
	pos_x += pos_x_offset
	
func generate_blocks(rows,count):
	 for i in range(rows):
		 for j in range(count):
				generate_block()
		 pos_x = 8
		 pos_y += 48
	 
func _on_BlocksGenerate_timeout():
	var blocks = get_tree().get_nodes_in_group('block')
	for block in blocks:
				block.get_parent().position.y += 48
	pos_y = 65
	for i in range(5):
			generate_block()	
	pos_x = 8
	

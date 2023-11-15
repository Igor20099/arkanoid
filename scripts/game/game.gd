extends Node2D

var block_preload
var pos_x = 8
var pos_y = 65
var block
var score = 0
onready var label = $CanvasLayer/Label
onready var scores_text = $CanvasLayer/ScoresText
onready var tween = $CanvasLayer/ScoresText/Tween
onready var blocks = $Blocks
onready var game_over_sound = $game_over_sound


func _ready():
	block_preload = preload("res://game_objects/block.tscn")
	generate_blocks()
	get_tree().paused = true
	Events.connect("change_scores",self,'change_scores')
	Events.connect('game_over',self,'game_over')

func _input(event):
	 if Input.is_action_just_pressed("left_mouse"):
			get_tree().paused = false
			label.visible = false

func generate_blocks():
	 for i in range(4):
		 for j in range(5):
				block = block_preload.instance()
				block.position= Vector2(pos_x,pos_y)
				get_node("Blocks").add_child(block)
				pos_x += 120
		 pos_x = 8
		 pos_y += 48
		
		
func set_text(text):
	scores_text.text = "SCORE: "  + var2str(int(text))
		
func change_scores():
	tween.interpolate_method(self,"set_text",score,Global.scores,0.5,4,1,0)
	tween.start()
	score = Global.scores
	
		 


func _on_Timer_timeout():
	 var bl = blocks.get_children()
	 for b in bl:
		 b.position.y +=48
	
	 for i in range(5):
			block = block_preload.instance()
			block.position= Vector2(pos_x,65)
			get_node("Blocks").add_child(block)
			pos_x += 120		
	 pos_x = 8
	
func game_over():
	game_over_sound.play()

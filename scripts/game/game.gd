extends Node2D



onready var label = $CanvasLayer/Label
onready var scores_text = $CanvasLayer/ScoresText
onready var tween = $CanvasLayer/ScoresText/Tween
onready var blocks = $Blocks
onready var game_over_sound = $GameOverSound
var start_score = 0

func _ready():
	Events.connect("change_scores",self,'change_scores')
	Events.connect('game_over',self,'game_over')
	get_tree().paused = true
	blocks.generate_blocks(4,5)
	
func _input(event):
	 if Input.is_action_just_pressed("left_mouse"):
			get_tree().paused = false
			label.visible = false
		
func set_text(text):
	scores_text.text = "SCORE: "  + var2str(int(text))
		
func change_scores():
	Global.scores +=100
	tween.interpolate_method(self,"set_text",start_score,Global.scores,0.5,4,1,0)
	tween.start()
	start_score = Global.scores
	
func game_over():
	get_tree().paused = true
	game_over_sound.play()
	yield(get_tree().create_timer(2),"timeout")
	get_tree().reload_current_scene()
	Global.scores = 0

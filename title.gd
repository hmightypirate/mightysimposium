extends Node

const aliennames = ["red_alien", "grey_alien", "yellow_alien", "green_alien", "blue_alien"]
const PERIOD = 3
const sequence = [["stand",false], ["stand",true], ["climb",false]]

var timer = 0
var index = 0

func all_aliens_do(move, flip):
	for alienname in aliennames:
		var alien = get_node(alienname)
		alien.get_node("Sprite").set_animation(move)
		alien.get_node("Sprite").set_flip_h(flip)
		alien.get_node("Sprite").play()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	for alienname in aliennames:
		var alien = get_node(alienname)
		alien.set_script(null)
		alien.get_node("Sprite").stop()
	all_aliens_do("stand",false)
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	timer += delta
	
	if (int(floor(timer)) == PERIOD):
		timer = 0
		index = (index + 1) % sequence.size()
		all_aliens_do(sequence[index][0], sequence[index][1])

func _on_TextureButton_pressed():
	get_tree().change_scene("main.tscn")

func _input(event):
	if (Input.is_action_pressed("ui_accept")):
		_on_TextureButton_pressed()

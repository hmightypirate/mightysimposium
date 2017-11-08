extends Node2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const my_alien = "blue_alien"

# obtain the area nodes
onready var left_area = get_node("leftArea2D")
onready var right_area = get_node("rightArea2D")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	left_area.connect("body_enter", self, "_on_leftArea2D_body_enter")
	left_area.connect("body_exit", self, "_on_leftArea2D_body_exit")
	right_area.connect("body_enter", self, "_on_rightArea2D_body_enter")
	right_area.connect("body_exit", self, "_on_rightArea2D_body_exit")

	set_fixed_process(false)
	
func _fixed_process(delta):
	print ("LEFTI ", left_area.get_overlapping_bodies())
	
func _on_leftArea2D_body_enter( body ):
	print("Chan!")
	if body.is_in_group(my_alien):
		# Check if it overlaps with the right area
		if right_area.overlaps_body(body):
			print ("Do the magic here ")
			fade_out_alien(body)

	
	pass # replace with function body


func _on_leftArea2D_body_exit( body ):
	pass # replace with function body


func _on_rightArea2D_body_enter( body ):
	if body.is_in_group(my_alien):
		# Check if it overlaps with the left area
		if left_area.overlaps_body(body):
			print ("Do the magic here ")
			fade_out_alien(body)
			self.get_node("KinematicBody2D/AnimatedSprite").play("full")
	
	pass # replace with function body

func _on_rightArea2D_body_exit( body ):
	pass # replace with function body

func fade_out_alien(body):
	var sprite = body
	var fade_effect = body.get_node("fade_effect")
	fade_effect.start()

extends Node2D
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var my_alien = "blue_alien"

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
	
	print ("IS MONITOR ", left_area.is_monitoring_enabled())
	
	set_fixed_process(true)
	
func _fixed_process(delta):
	print ("LEFTI ", left_area.get_overlapping_bodies())
	
func _on_leftArea2D_body_enter( body ):
	print ("BODY ", body)
	pass # replace with function body


func _on_leftArea2D_body_exit( body ):
	print ("BODY ", body)
	pass # replace with function body


func _on_rightArea2D_body_enter( body ):
	print ("BODY ", body)
	pass # replace with function body

func _on_rightArea2D_body_exit( body ):
	print ("BODY ", body)
	pass # replace with function body


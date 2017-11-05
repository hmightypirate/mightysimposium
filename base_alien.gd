extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY = 2000
const SPEED = 50
const JUMP_SPEED = -1000
const NEAR_ZERO = 10

var acc = Vector2()
var vel = Vector2()

var movement = "stand"

# obtain the collsion node
onready var right_foot = get_node("right_foot")
onready var fade_effect = get_node("fade_effect")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	acc.y = GRAVITY
	
	# Adding fade effect in alien nodes
	if fade_effect:
		fade_effect.interpolate_property(self, 'transform/scale',
			self.get_scale(), Vector2(2.0, 2.0), 0.3,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
		fade_effect.interpolate_property(self, 'visibility/opacity',
			1, 0, 0.3,
			Tween.TRANS_QUAD, Tween.EASE_OUT)

func _input(event):
	if event.is_action_pressed("ui_up") and right_foot.is_colliding():
		vel.y = JUMP_SPEED
	
func _fixed_process(delta):
	var movement = "stand"
	
	vel.x = SPEED * (Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left"))
	vel.y += acc.y * delta
	
	if (abs(vel.y) < NEAR_ZERO):
		vel.y = 0
		
	# move if you can, muahahah
	# motion returns the vector with the desired movement blocked by the collision
	var motion = move(vel * delta)
	
	if (right_foot.is_colliding()):
		if (right_foot.get_collider().is_in_group("bouncy")):
			vel.y = 2 * JUMP_SPEED
	
	if (self.is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		# force to collide with the platform
		vel = n.slide(vel)
		move(motion)
	
	# Set animation
	if ((vel.y != 0) and (not right_foot.is_colliding())):
		movement = "jump"
	elif (vel.x != 0):
		movement = "walk"
	
	# Set flip. If vel.x = 0, do not change
	if (vel.x < 0):
		self.get_node("sprite").set_flip_h(true)
	if (vel.x > 0):
		self.get_node("sprite").set_flip_h(false)

	if (self.get_node("player").get_current_animation() != movement):
		self.get_node("player").play(movement)
		
func _on_fade_effect_tween_complete( object, key ):
	queue_free()

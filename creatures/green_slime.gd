extends Node2D

const GRAVITY = 2000
const SPEED = 100
const MIN_SPEED = 10
const NEAR_ZERO = 10

var orientation = 1

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var acc = Vector2()
var vel = Vector2()

# obtain the collsion node
onready var mysprite = get_node("AnimatedSprite")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	
	acc.y = GRAVITY
	vel.x = SPEED
	

func _fixed_process(delta):
	
	vel.x = SPEED * orientation 
	vel.y += acc.y * delta
	
	if (abs(vel.y) < NEAR_ZERO):
		vel.y = 0
		
	# move if you can, muahahah
	# motion returns the vector with the desired movement blocked by the collision
	var motion = self.move(vel * delta)
	
	if (self.is_colliding()):
		var n = self.get_collision_normal()
		motion = n.slide(motion)
		# force to collide with the platform
		vel = n.slide(vel)
		
		if abs(vel.x) < MIN_SPEED:
			orientation = orientation * -1
		
		self.move(motion)
		
	# FLIP sprite
	if vel.x > 0:
		mysprite.set_flip_h(true)
	else:
		mysprite.set_flip_h(false)



extends KinematicBody

var speed = 60
var jump_power = 40
var gravity = 90
var velocity = Vector3.ZERO
var direction = Vector2.ZERO
var jump_count = 0

var dashing = false
var dash_time = 0.15
var dash_timer = 0
var dash_speed = 100
var can_dash = false
var y_dash_factor = 0.7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_direction():
	direction = Vector2.ZERO
	if Input.is_action_pressed("left"):
		direction.x += 1
	if Input.is_action_pressed("right"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.y -= 1
	if Input.is_action_pressed("up"):
		direction.y += 1

func dash_pressed():
	dashing = true
	can_dash = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("dash") and can_dash and dashing == false and (direction.x != 0 or direction.y != 0):
		dash_pressed()
	
	if !dashing:
		get_direction()
		
		velocity.y -= gravity * delta
		
		print(speed)
		velocity.z = direction.x * speed
		
		if is_on_floor():
			jump_count = 2
			can_dash = true
		
		if is_on_floor() or is_on_ceiling():
			velocity.y = 0
		
		if Input.is_action_just_pressed("jump") and jump_count > 0:
			velocity.y = jump_power
			jump_count -= 1
		
		move_and_slide(velocity, Vector3.UP)
	else:
		var move = Vector3()
		move.z = direction.x
		move.y = direction.y * y_dash_factor
		move = move.normalized() * dash_speed
		move_and_slide(move, Vector3.UP)
		velocity = move * 0.3
		dash_timer += delta
		
		if dash_timer > dash_time:
			dashing = false
			dash_timer = 0.0
	
	$MirrorMesh.transform.origin.y = self.transform.origin.y * -2
	self.get_parent().get_node("PlayerGround").transform.origin = self.transform.origin
	self.get_parent().get_node("PlayerGround").transform.origin.y = 0

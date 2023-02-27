extends KinematicBody

export var speed: float
export var jump_power: float
var gravity: float = 30
var velocity = Vector3.ZERO
var direction = Vector2.ZERO
var jump_count = 0

var dashing = false
export var dash_time: float
var dash_timer = 0
export var dash_speed: float
var can_dash = false
export var y_dash_factor: float

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
	velocity = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("dash") and can_dash and dashing == false and (direction.x != 0 or direction.y != 0):
		dash_pressed()
	
	if !dashing:
		get_direction()
		
		velocity.y -= gravity
		
		velocity.z = direction.x * speed
		
		if is_on_floor():
			jump_count = 2
			can_dash = true
		
		if is_on_floor() or is_on_ceiling():
			velocity.y = 0
		
		if Input.is_action_just_pressed("jump") and jump_count > 0:
			velocity.y = jump_power
			jump_count -= 1
		
		move_and_slide(velocity * delta, Vector3.UP)
	else:
		var move = Vector3()
		move.z = direction.x
		move.y = direction.y * y_dash_factor
		move = move.normalized() * dash_speed
		move_and_slide(move * delta, Vector3.UP)
		dash_timer += delta
		
		if dash_timer > dash_time:
			dashing = false
			dash_timer = 0.0
	
	$MirrorMesh.transform.origin.y = self.transform.origin.y * -2

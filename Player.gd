extends KinematicBody

export var speed: float
export var jump_power: float
var gravity: float = 30
var velocity: Vector3
var direction = 0
var jump_count = 0

var dashing = false
export var dash_time: float
var dash_timer = 0
export var dash_speed = 5
var can_dash = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("dash") and can_dash and dashing == false:
		dashing = true
		can_dash = false
		velocity = Vector3.ZERO
	
	if !dashing:
		velocity.y -= gravity * delta
		
		var move = 0
		if Input.is_action_pressed("left"):
			move += speed
			direction = 1
		if Input.is_action_pressed("right"):
			move -= speed
			direction = -1
		
		velocity.z = move
		
		if is_on_floor():
			jump_count = 2
			can_dash = true
			velocity.y = 0
		
		if Input.is_action_just_pressed("jump") and jump_count > 0:
			velocity.y = jump_power
			jump_count -= 1
		
		move_and_slide(velocity, Vector3.UP)
	else:
		var move = Vector3()
		move.z = dash_speed * direction
		move_and_slide(move, Vector3.UP)
		dash_timer += delta
		
		if dash_timer > dash_time:
			dashing = false
			dash_timer = 0.0

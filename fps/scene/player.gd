extends KinematicBody

# Constants
const MOUSE_SENSITIVITY = 0.1
const SPEED = 10
const SPRINT_SPEED = 20
const ACCEL = 15.0

const GRAVITY = -40.0
const JUMP_SPEED = 15
var jump_counter = 0
const AIR_ACCEL = 9.8

# Variables
onready var camera = $cam/Camera
var velocity = Vector3.ZERO
var current_vel = Vector3.ZERO
var dir = Vector3.ZERO

func _process(delta):
	window_activity()

func _physics_process(delta):
	dir = Vector3.ZERO
	
	# Determine movement direction based on input
	if Input.is_action_pressed("forward"):
		dir -= camera.global_transform.basis.z
	if Input.is_action_pressed("backward"):
		dir += camera.global_transform.basis.z
	if Input.is_action_pressed("right"):
		dir += camera.global_transform.basis.x
	if Input.is_action_pressed("left"):
		dir -= camera.global_transform.basis.x
	dir.y = 0  # Ignore vertical movement
	
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		jump_counter = 0
	
	# Jumping logic
	if Input.is_action_just_pressed("jump") and jump_counter < 2:  # Allow double jump
		velocity.y = JUMP_SPEED
		jump_counter += 1
		
	# Determine target velocity based on movement direction and speed
	var speed = SPEED
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	var target_vel = dir.normalized() * speed
	
	# Smoothly interpolate current velocity towards target velocity
	var accel = ACCEL if is_on_floor() else AIR_ACCEL
	current_vel = current_vel.linear_interpolate(target_vel, accel * delta)
	velocity.x = current_vel.x
	velocity.z = current_vel.z
	
	# Apply velocity to the player, ensuring collision detection
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(45))

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		# Rotate the camera vertically
		$cam.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		$cam.rotation_degrees.x = clamp($cam.rotation_degrees.x, -90, 90)
		
		# Rotate the player horizontally
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

func window_activity():
	# Toggle mouse mode between captured and visible
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

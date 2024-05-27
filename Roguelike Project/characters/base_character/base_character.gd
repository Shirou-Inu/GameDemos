extends CharacterBody2D

# Character stats
@export var movement_speed := 100.0 
@export var primary_cooldown := 1.0
@export var secondary_cooldown := 0.2
@export var dash_cooldown := 1.0

# Flags
var primary_available = true
var secondary_available = true
var dash_available = true
var dash_multipler = 1.0

func _ready():
	# Setup timers
	%PrimaryCooldownTimer.wait_time = primary_cooldown
	%SecondaryCooldownTimer.wait_time = secondary_cooldown
	%DashCooldownTimer.wait_time = dash_cooldown

func _physics_process(delta):
	# Get input vector
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Get dash input
	if Input.is_action_just_pressed("shift") and dash_available and direction != Vector2.ZERO:
		print("Dash")
		dash_multipler = 15.0
		
		# Start dash cooldown timer
		dash_available = false
		%DashCooldownTimer.start()
	
	# Calculate velocity
	velocity = direction * movement_speed * dash_multipler
	
	# Reduce dash multiplier to normal
	if dash_multipler > 1:
		dash_multipler -= 0.5
	else:
		dash_multipler = 1.0
	
	# Apply velocity
	move_and_slide()
	
	# Rotate attack towards cursor
	%AttackPivot.look_at(get_global_mouse_position())
	
	# Check primary attack input
	if Input.get_action_strength("primary") and primary_available:
		%Sword.play_attack()
		
		# Start primary cooldown timer
		primary_available = false
		%PrimaryCooldownTimer.start()
	
	# Check secondary attack input
	if Input.get_action_strength("secondary") and secondary_available:
		%SpellCastPoint.cast_spell()
		
		# Start secondary cooldown timer
		secondary_available = false
		%SecondaryCooldownTimer.start()

func _on_primary_cooldown_timer_timeout():
	# Set primary flag
	primary_available = true

func _on_secondary_cooldown_timer_timeout():
	# Set secondary flag
	secondary_available = true

func _on_dash_cooldown_timer_timeout():
	# Set dash flag
	dash_available = true

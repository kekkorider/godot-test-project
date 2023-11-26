extends Sprite2D

signal custom_toggle

var speed = 200
var angular_speed = PI
var click_count = 0

func _ready():
	if has_node_and_resource('Timer'):
		var timer = get_node("Timer")
		timer.timeout.connect(_on_timer_timeout)
		
	custom_toggle.connect(_on_custom_toggle)

func _process(delta):
	var direction = 0
	
	if Input.is_action_pressed("ui_left"):
		direction = -1
		
	if Input.is_action_pressed("ui_right"):
		direction = 1
		
	rotation += angular_speed * delta * direction
	
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed('ui_up'):
		velocity = Vector2.UP.rotated(rotation) * speed
		
	if Input.is_action_pressed('ui_down'):
		velocity = Vector2.DOWN.rotated(rotation) * speed
		
	position += velocity * delta


func _on_button_pressed():
	set_process(not is_processing())
	custom_toggle.emit(click_count)

func _on_timer_timeout():
	visible = not visible

func _on_custom_toggle(count):
	print("_on_custom_toggle()")
	click_count += 1
	print(count, '->', click_count)

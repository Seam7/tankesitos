extends CharacterBody2D

# Composition the shit out of this

const SPEED = 150
@onready var sprite_2d = $Sprite2D
# Con raycast podemos saber si disparar o nel
@onready var raycast = $RayCast2D
#@onready var main = get_tree().get_root().get_node("main")
@onready var projectile = preload("res://scenes/projectile.tscn")
#const JUMP_VELOCITY = -400.0
const PROJECTILE_SPEED = 1000
const PROJECTILE_FIRE_RATE = 1

var can_fire = true
var should_change_direction = true
var direction = Vector2()

# speed in pixels/sec

#func shoot():
	#var instance = projectile.instatiate()
	#instance.dir = rotation
	#instance.spawnPos = global_position
	#instance.spawnRot = rotation
	#main.add_child.call_deferred(instance) 
func evaluate_targets(body):
	return body and (body.is_in_group("breakable") or body.is_in_group("player"))
func fire():
	var projectile_instance = projectile.instantiate()
	# Why global position?
	#projectile_instance.position = position
	projectile_instance.position = $Cannon.get_global_position() 
	projectile_instance.rotation_degrees = rotation_degrees
	projectile_instance.apply_impulse(Vector2(0, -PROJECTILE_SPEED).rotated(global_rotation))
	get_tree().get_root().add_child(projectile_instance)
	can_fire = false
	await get_tree().create_timer(PROJECTILE_FIRE_RATE).timeout
	can_fire = true
	
func _process(delta: float):
	if(should_change_direction):
		should_change_direction = false
		var random_direction = RandomNumberGenerator.new().randi_range(1, 4)
		print(random_direction % 2 == 0)
		if(random_direction == 1):
			direction = move("right")
		elif(random_direction == 2):
			direction = move("up")
		elif(random_direction == 3):
			direction = move("left")
		else:
			print("in else")
			direction = move("down")
		await get_tree().create_timer(1.3).timeout
		should_change_direction = true
	
func move(vector: String) -> Vector2:
	var direction = Vector2()
	if(vector == "left"):
		rotation_degrees = 270
		direction.x -= 1
	elif(vector == "right"):
		rotation_degrees = 90
		direction.x += 1
	elif(vector == "down"):
		rotation_degrees = 180
		direction.y += 1
	else:
		rotation_degrees = 0
		direction.y -= 1
	return direction
	
func _physics_process(delta):
	if raycast.is_colliding():
		var body = raycast.get_collider()
		if evaluate_targets(body) and can_fire:
			fire()
	#var direction = Vector2()
	#if Input.is_action_pressed("ui_up"):
		#rotation_degrees = 0
		#direction.y -= 1
	#elif Input.is_action_pressed("ui_down"):
		#rotation_degrees = 180
		#direction.y += 1
	#elif Input.is_action_pressed("ui_left"):
		#rotation_degrees = 270
		#direction.x -= 1
	#elif Input.is_action_pressed("ui_right"):
		#rotation_degrees = 90
		#direction.x += 1
	#var direction = move("right")
	
# normalize the directional movement
	direction = direction.normalized()
# setup the actual movement
	velocity = (direction * SPEED)
	move_and_slide()

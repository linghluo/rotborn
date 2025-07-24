extends CharacterBody2D

var speed = 100.0
var dir_idle = "down"

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta):
    var input_vector = Vector2.ZERO
    input_vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
    input_vector.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
    input_vector = input_vector.normalized()
    
    velocity = input_vector * speed
    move_and_slide()

    # 八向动画
    if input_vector != Vector2.ZERO:
        var dir = get_direction_name(input_vector)
        anim_sprite.play("walk_" + dir)
        dir_idle = get_direction_name(input_vector)
    else:
        # 停止时对应方向的待机动画
        anim_sprite.play("idle_" + dir_idle)

func get_direction_name(direction: Vector2) -> String:
    if abs(direction.x) > abs(direction.y):
        return "right" if direction.x > 0 else "left"
    else:
        return "down" if direction.y > 0 else "up"

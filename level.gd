extends Node2D

@onready var timer_label: Label = $CanvasLayer/TimerLabel
@onready var player: Player = $Player

var time: = 0.0
var is_timer_running: = true

func _ready() -> void:
	player.level_finished.connect(finish_level)

func _process(delta: float) -> void:
	if is_timer_running:
		time += delta
		timer_label.text = "%.2f" % time
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()

func finish_level() -> void:
	player.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	is_timer_running = false

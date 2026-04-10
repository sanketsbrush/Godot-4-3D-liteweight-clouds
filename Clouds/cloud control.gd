@tool
extends Node3D

@export var endless_mode:=true
@export var shadows:=true
@export var Hide_shadow_mesh:=true

@export var cloud_height:=2000
@export var cloud_elivation:=6000

@export_range(1.0,1000.0) var wind_resistance:=500.0

@onready var cloud_shadows: MeshInstance3D = $"Cloud Canvas/Cloud Shadows"
@onready var cloud_canvas: MeshInstance3D = $"Cloud Canvas"

func _ready() -> void:
	self.top_level=true


func _process(_delta: float) -> void: if visible: if Engine.is_editor_hint():
	
	if endless_mode:
		global_position.x=cam_location().x
		global_position.z=cam_location().z
	
	cloud_shadows.visible=shadows
	cloud_shadows.cast_shadow=int(Hide_shadow_mesh)+2
	cloud_shadows.set_instance_shader_parameter("wind_resistance",wind_resistance)
	
	cloud_canvas.position.y=cloud_elivation
	cloud_canvas.scale.y=cloud_height*10
	cloud_shadows.set_instance_shader_parameter("wind_resistance",wind_resistance)


func cam_location():
	if Engine.is_editor_hint():return (EditorInterface.get_editor_viewport_3d(0).get_camera_3d().global_position)
	else: return (get_viewport().get_camera_3d().global_position)

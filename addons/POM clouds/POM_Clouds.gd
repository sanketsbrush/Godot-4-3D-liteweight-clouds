@icon ("./icon.svg")
@tool

class_name POM_Clouds extends MultiMeshInstance3D

##This handles instance count of mesh. Keep it on lower count for better performance.
@export_range(1,100) var POM_layers := 20
var current_POM_layers : int

@export var _scale := 100000.0
@export var height := 6000.0


func _ready() -> void:
	cast_shadow = 0
	top_level = true
	do_POM()
	

func _process(delta) : 
	
	position = Vector3(cam_location().x,height,cam_location().z)
	
	if Engine.is_editor_hint() :
		if current_POM_layers != POM_layers:
			do_POM()
			current_POM_layers = POM_layers
		if multimesh == null : do_POM()
		if material_override == null : material_override=load("res://addons/POM clouds/POM_Clouds_shader_material.tres").duplicate()
		material_override.set_shader_parameter("mesh_scale",_scale)
		cast_shadow = 0
		rotation = Vector3.ZERO
		scale = Vector3(_scale,_scale,_scale)
	



func do_POM():
	
	multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.use_colors = true
	multimesh.mesh = PlaneMesh.new()
	multimesh.mesh.set_size(Vector2(1,1))
	multimesh.mesh.set_subdivide_width(10)
	multimesh.mesh.set_subdivide_depth(10)
	multimesh.instance_count = POM_layers
	
	for i in POM_layers :
		multimesh.set_instance_transform(i,Transform3D(Basis(),Vector3()))
		var instance_alpha = float(i)/float(POM_layers)
		multimesh.set_instance_color( i,Color(instance_alpha,instance_alpha,instance_alpha,instance_alpha))


func cam_location():
	if Engine.is_editor_hint() : return (EditorInterface.get_editor_viewport_3d(0).get_camera_3d().global_position)
	else : return (get_viewport().get_camera_3d().global_position)

@tool
extends "base_modifier.gd"


@export var rotation := Vector3.ZERO


func _init() -> void:
	display_name = "Offset Rotation"
	category = "Offset"
	can_use_global_and_local_space = true
	can_restrict_height = false


func _process_transforms(transforms, domain, _seed : int) -> void:
	var rotation_rad := Vector3.ZERO
	rotation_rad.x = deg2rad(rotation.x)
	rotation_rad.y = deg2rad(rotation.y)
	rotation_rad.z = deg2rad(rotation.z)

	var basis: Basis
	var axis: Vector3
	for t in transforms.list.size():
		basis = transforms.list[t].basis

		axis = (float(use_local_space) * basis.x + float(!use_local_space) * Vector3(1, 0, 0)).normalized()
		basis = basis.rotated(axis, rotation_rad.x)

		axis = (float(use_local_space) * basis.y + float(!use_local_space) * Vector3(0, 1, 0)).normalized()
		basis = basis.rotated(axis, rotation_rad.y)

		axis = (float(use_local_space) * basis.z + float(!use_local_space) * Vector3(0, 0, 1)).normalized()
		basis = basis.rotated(axis, rotation_rad.z)

		transforms.list[t].basis = basis

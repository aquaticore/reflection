extends Node

export var cube: PackedScene

var wallSizeZ = 100
var wallSizeY = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	for z in range(wallSizeZ):
		for y in range(wallSizeY):
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			
			# create clone
			var clonedCube: MeshInstance = cube.instance()
			self.add_child(clonedCube)
			
			# set position
			clonedCube.transform.origin.x = -10
			clonedCube.transform.origin.y = y
			clonedCube.transform.origin.z = z - (wallSizeZ/2)
			
			# set rotation
			clonedCube.rotation_degrees.x = rng.randf_range(0, 90)
			clonedCube.rotation_degrees.y = rng.randf_range(0, 90)
			clonedCube.rotation_degrees.z = rng.randf_range(0, 90)
			
			# set size
			clonedCube.transform = clonedCube.transform.scaled(Vector3(
				rng.randf_range(2, 3.5),
				rng.randf_range(2, 3.5),
				rng.randf_range(2, 3.5)
			))

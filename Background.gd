extends Node

export var cube: PackedScene

var wallSize = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	for z in range(wallSize):
		for y in range(wallSize):
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			
			# create clone
			var clonedCube: MeshInstance = cube.instance()
			self.add_child(clonedCube)
			
			# set position
			clonedCube.transform.origin.z = z
			clonedCube.transform.origin.y = y
			
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

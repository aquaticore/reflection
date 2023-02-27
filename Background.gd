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
			var clonedCube = cube.instance()
			self.add_child(clonedCube)
			
			# set position
			clonedCube.transform.origin.z = z
			clonedCube.transform.origin.y = y
			
			# set rotation
			clonedCube.transform = clonedCube.transform.rotated(
				Vector3(1, 0, 0),
				rng.randf_range(0, 90)
			)
			clonedCube.transform = clonedCube.transform.rotated(
				Vector3(0, 1, 0),
				rng.randf_range(0, 90)
			)
			clonedCube.transform = clonedCube.transform.rotated(
				Vector3(0, 0, 1),
				rng.randf_range(0, 90)
			)
			
			# set size
			clonedCube.transform = clonedCube.transform.scaled(Vector3(
				rng.randf_range(2, 3.5),
				rng.randf_range(2, 3.5),
				rng.randf_range(2, 3.5)
			))

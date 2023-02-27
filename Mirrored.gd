extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in self.get_children():
		var duplicate: Node = child.duplicate()
		
		self.add_child(duplicate)
		duplicate.transform.origin.y *= -1

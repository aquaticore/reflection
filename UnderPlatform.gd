extends StaticBody

export var player_path: NodePath
onready var player := get_node(player_path) as Node
export var play: PackedScene
func _process(delta):
	self.transform.origin = player.transform.origin
	
	self.transform.origin.y = 0

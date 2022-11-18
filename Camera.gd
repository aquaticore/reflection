extends Camera

var player
export var smooth = 0.1
export var y_offset = 1

func _process(delta):
	player = get_parent().get_node("Player")
	
	transform.origin.z = player.transform.origin.z

	transform.origin.y -= y_offset
	transform.origin.y += (player.transform.origin.y - transform.origin.y) * smooth
	transform.origin.y += y_offset

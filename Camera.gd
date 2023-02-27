extends Camera

var player

func _process(delta):
	player = get_parent().get_node("Player")
	
	transform.origin.z = player.transform.origin.z

extends EditorScript

func _run():
	var dir = DirAccess.open("res://")
	var scene_paths = []
	_scan_dir(dir, scene_paths)
	
	for path in scene_paths:
		print("Saving: ", path)
		var scene = ResourceLoader.load(path)
		if scene and scene is PackedScene:
			ResourceSaver.save(path, scene)
	
	print("All .tscn files saved.")

func _scan_dir(dir: DirAccess, out_paths: Array):
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if dir.current_is_dir():
			if file != "." and file != "..":
				_scan_dir(DirAccess.open(dir.get_current_dir() + "/" + file), out_paths)
		elif file.ends_with(".tscn"):
			out_paths.append(dir.get_current_dir() + "/" + file)
		file = dir.get_next()
	dir.list_dir_end()

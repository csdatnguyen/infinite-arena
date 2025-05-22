@tool
extends EditorScript

func _run():
	var dir = DirAccess.open("res://")
	var scene_paths = []
	_scan_dir(dir, scene_paths)

	for path in scene_paths:
		print("Saving: ", path)
		var scene_res := ResourceLoader.load(path, "PackedScene")
		if scene_res and scene_res is PackedScene:
			var err = ResourceSaver.save(scene_res, path, 0)
			if err != OK:
				print("Failed to save: ", path)
		else:
			print("Skipped invalid or non-packed scene: ", path)

	print("All valid .tscn scenes saved.")

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

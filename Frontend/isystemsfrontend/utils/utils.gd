extends Node
class_name Utils

static func load_json_file(path: String):
	if not FileAccess.file_exists(path):
		push_error("File doesn't exist: " + path)
		return null
	
	var file = FileAccess.open(path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	
	if typeof(data) == TYPE_NIL:
		push_error("Failed to parse JSON")
		return null
	
	return data

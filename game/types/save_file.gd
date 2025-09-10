extends Resource

class_name SaveFile

# For now only global data is saved. Change if local data must be saved

@export_group("Save File")
@export var is_empty: bool = true
@export var path: String = ""

@export_group("Player Stats")
@export var hp: int = PlayerAL.hp

func save() -> void:
	PlayerAL.save(self)
	self.is_empty = false

func restore_save() -> void:
	PlayerAL.restore_save(self)
	SaveFile.current_save_file = self.path

static var current_save_file: String = ""

static func read(read_path: String) -> SaveFile:
	if ResourceLoader.exists(read_path):
		return ResourceLoader.load(read_path, "", ResourceLoader.CacheMode.CACHE_MODE_IGNORE) as SaveFile
	else:
		print("WARNING: Save file not found, returning empty save")
		var save_file = SaveFile.new()
		save_file.path = read_path
		return save_file

static func erase(read_path: String) -> void:
	if !ResourceLoader.exists(read_path):
		return

	var save_file = SaveFile.new()
	save_file.path = read_path
	SaveFile.write(save_file, read_path)

static func write(save_file: SaveFile, file_path: String) -> Error:
	save_file.path = file_path
	var dir_path_array: PackedStringArray = save_file.path.split("/")
	dir_path_array.remove_at(dir_path_array.size() -1)
	var dir_path: String = "/".join(dir_path_array)

	if !DirAccess.dir_exists_absolute(dir_path):
		DirAccess.make_dir_recursive_absolute(dir_path)
	return ResourceSaver.save(save_file, save_file.path)

extends Node

var _leaderboard = []

const lb_file = "user://lb.dat"
var f = File.new()


func load_leaderboard():
	if(f.file_exists(lb_file)):
		f.open(lb_file, File.READ_WRITE)
		var lb_temp = f.get_var(true)
		f.close()
		if(lb_temp != null):
			_leaderboard = lb_temp
		else:
			_leaderboard = []
		_clean_board()

func save_leaderboard():
	var err = f.open(lb_file, File.WRITE)
	print("Save: ", err)
	f.store_var(_leaderboard, true)
	f.close()

func add_new_record(name:String, depth:int):
	var data = {"name": name, "depth": depth}
	_leaderboard.append(data)
	_clean_board()

func delete_leaderboard():
	var dir = Directory.new()
	dir.remove(lb_file)

func _clean_board():
	_leaderboard.sort_custom(DepthSorter, "sort_depth")
	while(_leaderboard.size() > 10):
		_leaderboard.pop_back()

func get_leaderboard():
	return _leaderboard

class DepthSorter:
	static func sort_depth(a, b):
		if a["depth"] > b["depth"]:
			return true
		return false

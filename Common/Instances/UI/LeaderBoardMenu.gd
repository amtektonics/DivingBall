extends Control

onready var GameWorld = get_parent().get_parent()

onready var IndexColumn = $Center/Panel/HBoxContainer/Index
onready var NameColumn = $Center/Panel/HBoxContainer/Name
onready var ScoreColumn = $Center/Panel/HBoxContainer/Score

func load_leaderboard():
	var lb = LeaderBoardManager.get_leaderboard()
	for i in range(lb.size()):
		add_row(i + 1, lb[i]["name"], lb[i]["depth"])


func update_leaderboard():
	clear_leaderboard()
	load_leaderboard()

func clear_leaderboard():
	for i in range(1, IndexColumn.get_child_count()):
		IndexColumn.get_child(i).queue_free()
		NameColumn.get_child(i).queue_free()
		ScoreColumn.get_child(i).queue_free()


func add_row(index:int, name:String, score:int):
	var indexLabel = Label.new()
	indexLabel.text = "# " + str(index)
	indexLabel.set_name("index_" + str(index))
	indexLabel.align = Label.ALIGN_CENTER
	
	var nameLabel = Label.new()
	nameLabel.text = name
	nameLabel.set_name("name_" + str(index))
	nameLabel.align = Label.ALIGN_CENTER
	
	var scoreLabel = Label.new()
	scoreLabel.text = str(score) + " meters"
	scoreLabel.set_name("score_" + str(index))
	scoreLabel.align = Label.ALIGN_CENTER

	
	IndexColumn.add_child(indexLabel)
	NameColumn.add_child(nameLabel)
	ScoreColumn.add_child(scoreLabel)
	
func awake():
	pass


func _on_BackBtn_pressed():
	self.visible = false
	GameWorld.show_main_menu()


func _on_ClearBtn_pressed():
	LeaderBoardManager.delete_leaderboard()
	LeaderBoardManager.load_leaderboard()
	update_leaderboard()
	

extends ColorRect

export(String, FILE) var dialogPath
export(float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()

func _process(_delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
	
	finished = false
	var text = dialog[phraseNum]["Text"]
	$Text.bbcode_text = text
	
	$Tween.interpolate_property(
		$Text, "visible_characters", 0, text.length(), 3)
	$Tween.start()
	
	yield($Tween, "tween_all_completed")
	
	finished = true
	phraseNum += 1
	return

extends Node

const SteamAppID = "480"

func _init() -> void:
	OS.set_environment("SteamAppID", SteamAppID)
	OS.set_environment("SteamGameID", SteamAppID)

func _ready() -> void:
	Steam.steamInit()
	if !Steam.isSteamRunning():
		print("_ready(), Steam.isSteamRunning() == false, main.gd")
		return
	print("_ready(), Steam.isSteamRunning() == true, main.gd")
	#var id = 
	var steam_name = Steam.getFriendPersonaName(Steam.getSteamID())
	print("steam player name: ", steam_name)
	

func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

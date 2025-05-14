extends Node

var word_to_article: Dictionary

func _ready():
	word_to_article = Utils.load_json_file("res://data/german_nouns.json")
	print("Loaded %d words." % len(word_to_article))

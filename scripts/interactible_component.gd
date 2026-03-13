class_name InteractibleComponent extends Node

signal interacted(CharacterBody3D)

func interact(player: Player):
	interacted.emit(player)

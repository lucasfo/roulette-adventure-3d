extends Node3D

class_name PlayerAvatar

@export var template: PlayerTemplate
@onready var player: Player = Player.new(self.template)

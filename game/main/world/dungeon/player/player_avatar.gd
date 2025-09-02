extends Node3D

@export var template: PlayerTemplate
@onready var player: Player = Player.new(self.template)

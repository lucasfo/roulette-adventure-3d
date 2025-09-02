extends RefCounted

class_name Player

var melee: int = 0
var ranged: int = 0
var magic: int = 0

func _init(template: PlayerTemplate) -> void:
	self.melee = template.melee
	self.ranged = template.ranged
	self.magic = template.magic

func to_template() -> PlayerTemplate:
	var template: PlayerTemplate = PlayerTemplate.new()
	template.melee = self.melee
	template.ranged = self.ranged
	template.magic = self.magic

	return template

func attr_power(attribute: Enums.Attribute) -> int:
	match attribute:
		Enums.Attribute.MELEE:
			return self.melee
		Enums.Attribute.RANGED:
			return self.ranged
		Enums.Attribute.MAGIC:
			return self.magic
	return 0



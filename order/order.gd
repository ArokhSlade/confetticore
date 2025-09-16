extends Node
class_name Order

const Hex = HexMap.Hex

enum Type {
	NONE,
	STAY,
	MOVE,
	ATTACK
}

var type : Type
var executor : Mech
var attack_target : Mech
var move_target : Hex

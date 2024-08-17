extends Area3D
class_name Interaction

enum INTERACTION_TYPE { ITEM, PROBLEM }
enum ITEM_TYPE { NULL, BLOWTORCH, GUN, DUCT_TAPE }

@export var type : INTERACTION_TYPE

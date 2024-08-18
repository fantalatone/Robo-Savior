extends Area3D
class_name Interaction

enum INTERACTION_TYPE { ITEM, PROBLEM }
enum ITEM_TYPE { NULL, EXTINGUISHER, HAMMER, BLOWTORCH }

@export var type : INTERACTION_TYPE

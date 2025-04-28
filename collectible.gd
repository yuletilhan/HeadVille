extends Area2D

@export var itemRes: InventoryItem

func collect(inventory: Inventory):
    if inventory == null:
        return
    if itemRes == null:
        return
    inventory.insert(itemRes)
    queue_free()

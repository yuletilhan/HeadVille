# inventory.gd
extends Node

signal inventory_updated(inventory)
var inventory = {}

func add_item(item_id):
    if inventory.has(item_id):
        inventory[item_id] += 1
    else:
        inventory[item_id] = 1
    
    emit_signal("inventory_updated", inventory)

func remove_item(item_id, amount := 1):
    if inventory.has(item_id):
        inventory[item_id] -= amount
        if inventory[item_id] <= 0:
            inventory.erase(item_id)
        
        emit_signal("inventory_updated", inventory)
        return true
    return false

func get_inventory():
    return inventory

extends Node
class_name Stack

var _data: Array = []

#添加元素
func push(value: Variant) -> void:
	_data.append(value)

#回退栈
func pop() -> Variant:
	if _data.is_empty():
		push_error("Stack is empty")
		return null
	return _data.pop_back()

#判空
func is_empty() -> bool:
	return _data.is_empty()

#清除栈队列
func clear() -> void:
	_data.clear()
	
func size() -> int:
	return _data.size()
	
func getTop() -> Variant:
	if _data.is_empty():
		push_error("Stack is empty")
		return null
	return _data[_data.size() - 1]

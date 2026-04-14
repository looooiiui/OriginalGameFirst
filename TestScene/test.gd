##全局类(也就是可以其他脚本调用的全局类)
##需要注意的是这个class_name只需要存在在项目文件里面就能使用
##不许要运行场景把脚本调用进来
#创建一个Test全局类
class_name Test

#这是节点自带的(Node2D)
extends Node2D

#单例静态(一个类型是自己的静态数据)
static var instance : Test

#静态数据
static var test_data : int

#启动部分对单例进行初始化
func _ready() -> void:
	
	#类内部本身可以直接调用静态数据
	if instance == null:
		instance = self
	
	#单例只能存在一个(其他的要释放)
	else:
		queue_free()
		
	#这种是外面脚本调用类的方式(用来实现一种数据获取方法)
	Test.instance
	Test.test_data = 10
	
	##这里是全局类外脚本创建(这个建议不要和单例一起用)
	##创建多个对象
	var new_Test = Test.new()
	
	##也可以通过对象访问，但是不属于对象
	##这个对象改变其他本类型的对象也会改变这个静态变量
	##不建议这样写，直接 类名.变量 更好
	new_Test.instance
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

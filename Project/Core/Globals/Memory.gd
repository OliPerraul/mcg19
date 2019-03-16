extends Node



func safe_free(instance):
	if is_instance_valid(instance) :
		instance.queue_free()
		
func safe_queue_free(instance):
	if is_instance_valid(instance) && not instance.is_queued_for_deletion() :
		instance.queue_free()
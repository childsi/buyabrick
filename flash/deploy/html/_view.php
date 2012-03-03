<?
	require_once('_include.php');
	require_once('objects/core/mysmarty.class.php');
	
	$view_object_name = 'view_' . $_GET['view'];
	$view_method_name = $_GET['method'];
	if ($view_method_name=='') $view_method_name = 'index';
	
	require_once('views/' . $view_object_name . '.class.php');
	$view_object = new $view_object_name;
	$view_object->run( $view_method_name );
	print $view_object->render();
	
	exit();
	
?>
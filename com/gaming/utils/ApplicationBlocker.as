package com.gaming.utils {
	
	import flash.display.Loader;
	import flash.net.URLRequest;
		
	public class ApplicationBlocker {
		
		public static var loader:Loader = new Loader();
		
		//loader.load(new URLRequest("logo/logo.png"));
		
		public static const information:String = "Infelizmente, você não pode acessar este aplicativo.";
	}
}
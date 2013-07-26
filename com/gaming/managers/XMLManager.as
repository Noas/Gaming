package com.gaming.managers {
	
	import com.gaming.core.Galery;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class XMLManager extends Galery {
		
		/**
		 * Constructor
		 */
		public function XMLManager() {}
		
		/**
		 * Loads the objects
		 * @param	path
		 * @param	names
		 */
		public function load(path:String, names:Array):void {
			
			total = names.length;
			
			for (var i:uint = 0; i < names.length; i++) {
				
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, completeHandler);
				loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loader.load(new URLRequest(path + names[i] + ".xml"));
				
				galery[names[i]] = loader;
			}
		}
		
		/**
		 * Returns a XML through a name
		 * @param	name	String
		 * @return	XML
		 */
		public function getXMLByName(name:String):XML {
			
			return XML(galery[name].data);
		}
	}
}
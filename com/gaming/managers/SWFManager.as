package com.gaming.managers {
	
	import com.gaming.core.Galery;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class SWFManager extends Galery {
		
		/**
		 * Constructor
		 */
		public function SWFManager() {
			super();
		}
		
		/**
		 * Loads the objects
		 * @param	path
		 * @param	names
		 */
		public function load(path:String, names:Array):void {
			
			total = names.length;
			
			var loader:Loader;
			
			for (var i:uint = 0; i < total; i++) {
				
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loader.load(new URLRequest(path + names[i] + ".swf"));
				
				galery[names[i]] = loader;
			}
		}
		
		/**
		 * Returns a SWF through a name
		 * @param	name	String
		 * @return	SWF
		 */
		public function getSWFByName(name:String):MovieClip {
			
			return galery[name].content;
		}
	}
}
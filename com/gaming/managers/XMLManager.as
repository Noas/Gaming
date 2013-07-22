package com.gaming.managers {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class XMLManager extends MovieClip {
		
		public static const LOAD_COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		
		private var _progress:Number;
		
		private var xmlLoaded:int = 0;
		private var xmlTotal:int;
		private var list:Dictionary = new Dictionary();
		
		public function XMLManager() {}
		
		public function load(path:String, names:Array):void {
			
			xmlTotal = names.length;
			
			for (var i:uint = 0; i < names.length; i++) {
				
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, completeXMLHandler);
				loader.addEventListener(ProgressEvent.PROGRESS, progressXMLHandler);
				loader.load(new URLRequest(path + names[i] + ".xml"));
				
				list[names[i]] = loader;
			}
		}
		
		private function progressXMLHandler(e:ProgressEvent):void {
			
			_progress = Math.floor((e.bytesLoaded / e.bytesTotal) * 100);
			
			dispatchEvent(new Event(PROGRESS));
		}
		
		private function completeXMLHandler(e:Event):void {
			
			xmlLoaded++;
			
			if (xmlTotal == xmlLoaded)				
				dispatchEvent(new Event(LOAD_COMPLETE));
		}
		
		/* PUBLIC METHODS */
		
		public function getXMLByName(name:String):XML {
			
			return XML(list[name].data);
		}
		
		public function getList():Dictionary {
			
			return list;
		}
		
		public function get progress():Number {
			return _progress;
		}
		
		public function set progress(value:Number):void {
			_progress = value;
		}
	}
}
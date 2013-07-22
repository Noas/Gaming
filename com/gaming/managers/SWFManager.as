package com.gaming.managers {
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class SWFManager extends MovieClip {
		
		public static const LOAD_COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		
		private var _progress:Number;
		
		private var swfLoaded:int = 0;
		private var swfTotal:int;
		private var list:Dictionary = new Dictionary();
		
		public function SWFManager() {
			super();
		}
		
		public function load(path:String, names:Array):void {
			
			swfTotal = names.length;
			
			var loader:Loader;
			
			for (var i:uint = 0; i < swfTotal; i++) {
				
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeSWFHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressSWFHandler);
				loader.load(new URLRequest(path + names[i] + ".swf"));
				
				list[names[i]] = loader;
			}
		}
		
		private function progressSWFHandler(e:Event):void {
			
			_progress = Math.floor((e.target.bytesLoaded / e.target.bytesTotal) * 100);
			
			dispatchEvent(new Event(PROGRESS));
		}
		
		private function completeSWFHandler(e:Event):void {
			
			swfLoaded++;
			
			if (swfTotal == swfLoaded)				
				dispatchEvent(new Event(LOAD_COMPLETE));
		}
		
		/* PUBLIC METHODS */
		
		public function getSWFByName(name:String):MovieClip {
			
			return list[name].content;
		}
		
		public function getList():Dictionary {
			
			return list;
		}
		
		/* GETTERS E SETTERS */
		
		public function get progress():Number {
			return _progress;
		}
		
		public function set progress(value:Number):void {
			_progress = value;
		}
	}
}
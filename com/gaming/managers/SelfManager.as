package com.gaming.managers {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * Responsável pelo carregamento do conteúdo do swf
	 * @author Marcos Cardoso
	 */
	
	public class SelfManager extends MovieClip {
		
		/**
		 * A Number that store the progress of the loading
		 */
		private var _progress:Number;
		
		/**
		 * Used to record of the complete event dispatched when the loading is finished
		 */
		public static const SELF_COMPLETE:String = "self_complete";
		
		/**
		 * Used to record of the progress event dispatched when the loading of any asset is in progress
		 */
		public static const PROGRESS:String = "progress";
		
		/**
		 * Construtor
		 */
		public function SelfManager() {
			super();
		}
		
		/**
		 * Loads the application itself
		 * @param	container	Represents the application to be loaded
		 */
		public function loadGame(container:DisplayObjectContainer = null):void {
			
			container.addEventListener(Event.ENTER_FRAME, loadingTheGame);
		}
		
		/**
		 * Enterframe used to check the application's loading status
		 * @param	e	Event
		 */
		private function loadingTheGame(e:Event):void {
			
			_progress = Math.floor(( e.target.loaderInfo.bytesLoaded / e.target.loaderInfo.bytesTotal) * 100);
			
			if (e.target.loaderInfo.bytesTotal == e.target.loaderInfo.bytesLoaded) {
				
				e.target.removeEventListener(Event.ENTER_FRAME, loadingTheGame);
				dispatchEvent(new Event(SELF_COMPLETE));
			}
			
			dispatchEvent(new Event(PROGRESS));
		}
		
		/**
		 * Returns a number that represents the current loading progress
		 */
		public function get progress():Number {
			return _progress;
		}
	}
}
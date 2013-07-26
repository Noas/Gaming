package com.gaming.events {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class LoadingEvent extends Event {
		
		/**
		 * Used to record of the complete event dispatched when the loading is finished
		 */
		public static const LOAD_COMPLETE:String = "complete";
		
		/**
		 * Used to record of the progress event dispatched when the loading of any asset is in progress
		 */
		public static const PROGRESS:String = "progress";
		
		/**
		 * Constructor
		 * @param	type			String
		 * @param	bubbles			Boolean
		 * @param	cancelable		Boolean
		 */
		public function LoadingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}
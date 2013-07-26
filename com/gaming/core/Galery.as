package com.gaming.core {
	
	import com.gaming.events.LoadingEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	public class Galery extends Sprite {
		
		/**
		 * A Number that store the progress of the loading
		 */
		protected var _progress:Number;
		
		/**
		 * Stores the objects
		 */
		protected var galery:Dictionary = new Dictionary();
		
		/**
		 * The number of objects loaded
		 */
		protected var loaded:int = 0;
		
		/**
		 * The total of objects to be loaded
		 */
		protected var total:int;
		
		public function Galery() { }
		
		/**
		 * 
		 * @return the galery
		 */
		public function getGalery():Dictionary {
			return galery;
		}
		
		/**
		 * 
		 * @return an Array with the galery's objects as Strings
		 * Retorna um Array com os objetos da galeria como Strings
		 */
		public function getGaleryItens():Array {
			
			var arr:Array = new Array();
			for (var object:Object  in galery) 
				arr.push(object);
				
			return arr;
		}
		
		/**
		 * 
		 * @param	str	:	String
		 * @return	An Array with the elements that matches with the pattern
		 */
		public function getItensByPattern(str:String):Array {
			
			var arr:Array = getGaleryItens();
			var itens:Array = new Array();
			
			for (var i:int = 0; i < arr.length; i++) {
				
				if (arr[i].search(str) != -1) {
					itens.push(arr[i]);
				}
			}
			
			return itens;
		}
		
		/**
		 * Calculate the progresse of the loading
		 * @param	e	:	Event
		 */
		public function progressHandler(e:Event):void {
			
			_progress = Math.floor((e.target.bytesLoaded / e.target.bytesTotal) * 100);
			dispatchEvent(new Event(LoadingEvent.PROGRESS));
		}
		
		/**
		 * Dispatch de end of the loading
		 * @param	e	:	Event
		 */
		public function completeHandler(e:Event):void {
			
			loaded++;
			if (total == loaded)
				dispatchEvent(new Event(LoadingEvent.LOAD_COMPLETE));
		}
		
		/**
		 * Return the current progress
		 */
		public function get progress():Number {
			return _progress;
		}
		
		/**
		 * Set the current progress
		 */
		public function set progress(value:Number):void {
			_progress = value;
		}
	}
}
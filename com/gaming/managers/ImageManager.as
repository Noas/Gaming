package com.gaming.managers {
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class ImageManager extends Sprite {
		
		public static const LOAD_COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		
		private var _progress:Number;
		
		private var imageLoaded:int = 0;
		private var imageTotal:int;
		private var galery:Dictionary = new Dictionary();
		
		public function ImageManager() {
			super();
		}
		
		public function load(path:*, names:Array, ext:String = ".jpg"):void {
			
			imageTotal = names.length;
			
			var loader:Loader;
			
			for (var i:uint = 0; i < imageTotal; i++) {
				
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeImageHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressImageHandler);
				loader.load(new URLRequest((path is Array ? path[i] : path) + names[i] + ext));
				
				galery[names[i]] = loader;
			}
		}
		
		private function progressImageHandler(e:Event):void {
			
			_progress = Math.floor((e.target.bytesLoaded / e.target.bytesTotal) * 100);
			
			dispatchEvent(new Event(PROGRESS));
		}
		
		private function completeImageHandler(e:Event):void {
			
			imageLoaded++;
			//trace(imageLoaded);
			if (imageTotal == imageLoaded)				
				dispatchEvent(new Event(LOAD_COMPLETE));
		}
		
		/* PUBLIC METHODS */
		
		public function getImageByName(nome:String):Bitmap {
			
			var img:Bitmap = new Bitmap(galery[nome].content.bitmapData);
			return img;
			
			//return galery[nome].content;
		}
		
		public function getGalery():Dictionary {
			
			return galery;
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
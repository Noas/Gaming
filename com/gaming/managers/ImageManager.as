package com.gaming.managers {
	
	import com.gaming.core.Galery;
	import com.gaming.events.LoadingEvent;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class ImageManager extends Galery {
		
		/**
		 * Constructor
		 */
		public function ImageManager() {
			super();
		}
		
		/**
		 * Loads the objects
		 * @param	path	:	Object with the assets' paths
		 * @param	names	:	Array with the assets' names
		 * @param	ext		:	String	with the extension
		 */
		public function load(path:*, names:Array, ext:String = ".jpg"):void {
			
			total = names.length;
			
			var loader:Loader;
			
			for (var i:uint = 0; i < total; i++) {
				
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loader.load(new URLRequest((path is Array ? path[i] : path) + names[i] + ext));
				
				galery[names[i]] = loader;
			}
		}
		
		/**
		 * 
		 * @param	nome	:	String	with the object's name
		 * @return	A Bitmap
		 */
		public function getImageByName(nome:String):Bitmap {
			
			var img:Bitmap = new Bitmap(galery[nome].content.bitmapData);
			return img;
		}
		
		/**
		 * 
		 * @param	names	:	Array with the names
		 * @return	An Array with Bitmaps
		 */
		public function getImagesByName(names:Array):Array {
			
			var images:Array = new Array();
			for (var i:int = 0; i < names.length; i++) 
				images.push(getImageByName(names[i]));
		}
	}
}
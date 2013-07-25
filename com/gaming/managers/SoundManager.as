package com.gaming.managers {
	
	import com.gaming.settings.MouseSettings;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class SoundManager extends Sprite {
		
		public static const LOAD_COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		
		private var _progress:Number;
		
		private var soundLoaded:int = 0;
		private var soundTotal:int;
		private var playlist:Dictionary = new Dictionary();
		
		private var allowSound:Boolean = true;
		private var container:MovieClip;
		private var scope:DisplayObjectContainer;
		
		public function SoundManager() { }
		
		public function load(path:String, names:Array):void {
			
			soundTotal = names.length;
			
			var sound:Sound;
			
			for (var i:uint = 0; i < names.length; i++) {
				
				sound = new Sound(new URLRequest(path + names[i] + ".mp3"));
				sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				sound.addEventListener(Event.COMPLETE, completeHandler);
				
				playlist[names[i]] = sound;
			}
		}
		
		private function progressHandler(e:ProgressEvent):void {
			
			_progress = Math.floor((e.bytesLoaded / e.bytesTotal) * 100);
			
			dispatchEvent(new Event(PROGRESS));
		}
		
		private function completeHandler(e:Event):void {
			
			soundLoaded++;
			
			if (soundTotal == soundLoaded)				
				dispatchEvent(new Event(LOAD_COMPLETE));
		}
		
		/* PUBLIC METHODS */
		
		public function setContainer(container:MovieClip):void {
			
			this.container = container;
			this.scope = container.parent.parent;
			
			MouseSettings.settings(container, "none");
			container.addEventListener(MouseEvent.CLICK, toggleSound);
		}
		
		private function toggleSound(e:MouseEvent = null):void {
			
			if (container.currentFrame == 1) {
				container.gotoAndStop(2);
				allowSound = false;
			} else {
				container.gotoAndStop(1);
				allowSound = true;
			}
		}
		
		public function playSoundByName(name:String):void {
			
			if (allowSound)
				playlist[name].play();
		}
		
		public function getSoundByName(name:String):Sound {
			
			return playlist[name];
		}
		
		public function getPlaylist():Dictionary {
			
			return playlist;
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
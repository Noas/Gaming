package com.gaming.managers {
	
	import com.gaming.core.Galery;
	import com.gaming.settings.MouseSettings;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class SoundManager extends Galery {
		
		private var allowSound:Boolean = true;
		private var container:MovieClip;
		private var scope:DisplayObjectContainer;
		
		/**
		 * Constructor
		 */
		public function SoundManager() { }
		
		/**
		 * Loads the objects
		 * @param	path
		 * @param	names
		 */
		public function load(path:String, names:Array):void {
			
			total = names.length;
			
			var sound:Sound;
			
			for (var i:uint = 0; i < names.length; i++) {
				
				sound = new Sound(new URLRequest(path + names[i] + ".mp3"));
				sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				sound.addEventListener(Event.COMPLETE, completeHandler);
				
				galery[names[i]] = sound;
			}
		}
		
		/**
		 * Informs the MovieClip that will be responsible for the manipulation of the sounds
		 * @param	container
		 */
		public function setContainer(container:MovieClip):void {
			
			this.container = container;
			this.scope = container.parent.parent;
			
			MouseSettings.settings(container, "none");
			container.addEventListener(MouseEvent.CLICK, toggleSound);
		}
		
		/**
		 * Changes the state of the button
		 * @param	e
		 */
		private function toggleSound(e:MouseEvent = null):void {
			
			if (container.currentFrame == 1) {
				container.gotoAndStop(2);
				allowSound = false;
			} else {
				container.gotoAndStop(1);
				allowSound = true;
			}
		}
		
		/**
		 * Allow to perform a sound
		 * @param	name
		 */
		public function playSoundByName(name:String, blocSound:Boolean=false):void {
			
			if (allowSound || blocSound)
				galery[name].play();
		}
		
		/**
		 * Returns a Sound through a name
		 * @param	name	String
		 * @return	Sound
		 */
		public function getSoundByName(name:String):Sound {
			return galery[name];
		}
	}
}
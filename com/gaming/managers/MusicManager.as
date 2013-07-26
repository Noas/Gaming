package com.gaming.managers {
	
	import caurina.transitions.properties.SoundShortcuts;
	import caurina.transitions.Tweener;
	import com.gaming.settings.MouseSettings;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class MusicManager extends MovieClip {
		
		private var container:MovieClip;
		private var music:Sound;
		private var valueToFade:Number = 1;
		private var musicTransform:SoundTransform;
		private var scope:DisplayObjectContainer;
		private var channel:SoundChannel;
		
		public var volume:Number = 0;
		public var minVolume:Number = 0.5;
		public var started:Boolean = false;
		
		/**
		 * Constructor
		 * @param	container	MovieClip with two frames that represent on/off
		 */
		public function MusicManager(container:MovieClip) {
			
			super();
			
			this.container = container;
			this.scope = container.parent.parent;
		}
		
		/**
		 * Should be called when the user click the button play
		 */
		public function start():void {
			
			if (getVolume() >= minVolume) 
				setVolume(minVolume);
			started = true;
		}
		
		/**
		 * Should be called when the user restart the application
		 */
		public function reStart():void {
			
			if (getVolume() >= minVolume) 
				setVolume(volume);
			started = false;
		}
		
		/**
		 * Starts the application's music
		 * @param	music		Sound. The music
		 * @param	volume		Number. The inicial volume
		 */
		public function startMusicBySound(music:Sound, volume:Number = 1):void {
			
			this.volume = volume;
			this.music = music;
			init();
		}
		
		/**
		 * Loads the music
		 * @param	url	:	String with the music's path
		 */
		public function loadMusic(url:String):void {
			
			music = new Sound(new URLRequest(url));
			music.addEventListener(Event.COMPLETE, completeHandler);
		}
		
		/**
		 * Dispatched when the music is loaded
		 * @param	e	Event
		 */
		private function completeHandler(e:Event):void {
			
			init();
		}
		
		/**
		 * Inits the musics' manager
		 */
		private function init():void {
			
			SoundShortcuts.init();
			
			channel = new SoundChannel();
			musicTransform = new SoundTransform(volume);
			channel = music.play(0, int.MAX_VALUE);
			
			MouseSettings.settings(container, "none");
			container.addEventListener(MouseEvent.CLICK, toggleMusic);
		}
		
		/**
		 * Dispatched when the user switch the music's button
		 * @param	e	MouseEvent
		 */
		private function toggleMusic(e:MouseEvent = null):void {
			
			if (container.currentFrame == 1) {
				container.gotoAndStop(2);
				setVolume(0);
			} else {
				container.gotoAndStop(1);
				started ? setVolume(minVolume) : setVolume(volume);
			}
		}
		
		/**
		 * Changes the volume
		 * @param	volume	Number
		 */
		private function changeVolume(volume:Number):void {
			
			musicTransform.volume = volume;
			fade(volume);
		}
		
		/**
		 * Makes the volume's transition 
		 * @param	volume	Number
		 */
		private function fade(volume:Number):void {
			
			Tweener.addTween(channel, {_sound_volume:volume, time:1, transition: "easeInOutQuad"});
		}
		
		/**
		 * Returns the volume
		 * @return	volume	:	Number
		 */
		public function getVolume():Number {
			
			return musicTransform.volume;
		}
		
		/**
		 * Changes the music's default volume
		 * @param	value
		 */
		public function setVolume(value:Number = 0.5):void {
			
			changeVolume(value);
		}
		
		/**
		 * Stops the current music
		 */
		public function stopCurrentMusic():void {
			
			channel.stop();
			music = null;
		}
		
		/**
		 * Changes the music while the application is running
		 * @param	s	Sound
		 * @param	v	Number volume
		 */
		public function changeCurrentMusic(s:Sound, v:Number = 0.5):void {
			
			this.volume = v;
			
			Tweener.addTween(channel, { _sound_volume:0, time:1, transition: "easeInOutQuad", onComplete:removeSound, onCompleteParams:[s, v] } );
		}
		
		/**
		 * Called at the end of the transition from the method changeCurrentMusic
		 * Removes the old music and add a new one
		 * @param	s	Sound
		 * @param	v	Number volume
		 */
		private function removeSound(s:Sound, v:Number):void {
			
			music = s;
			channel = music.play(0, int.MAX_VALUE);
			
			if (container.currentFrame == 2)
				musicTransform.volume = 0;
			else
				musicTransform.volume = v;
				
			channel.soundTransform = musicTransform;
		}
	}
}
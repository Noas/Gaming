package com.gaming.audio {
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class Audio {
		
		//private static var isAudio:Boolean = true; //music is ON when we start
		private static var myChannel:SoundChannel = new SoundChannel();
		//private static var myTransform:SoundTransform;
		
		private static var sndGood:Sound;
		private static var sndClick:Sound; 
		private static var sndBad:Sound;
		private static var sndKey:Sound;
		
		public static const GOOD:String = "good";
		public static const CLICK:String = "click";
		public static const ERROR:String = "error";
		public static const KEY:String = "key";
		
		public function Audio() { 
			
			//sndMusic = new Sound(new URLRequest("../../assets/sounds/music.mp3"));
			sndGood = new Sound(new URLRequest("assets/sounds/chimes.mp3"));
			//sndDrop = new Sound(new URLRequest("assets/sounds/drop.mp3"));
			sndClick = new Sound(new URLRequest("assets/sounds/click.mp3"));
			sndBad = new Sound(new URLRequest("assets/sounds/error.mp3"));
			sndKey = new Sound(new URLRequest("assets/sounds/keypress.mp3"));
		}
		
		public function play(type:String):void {
			
			/*if (type == "music") 		{	myChannel = sndMusic.play();	}
			else */if (type == "good") 	{	myChannel = sndGood.play();		}
			//else if (type == "drop") 	{	myChannel = sndDrop.play();	}
			else if (type == "click") 	{	myChannel = sndClick.play();	}
			else if (type == "error") 	{	myChannel = sndBad.play();		}
			else if (type == "key") 	{	myChannel = sndKey.play();		}
		}
	}
}
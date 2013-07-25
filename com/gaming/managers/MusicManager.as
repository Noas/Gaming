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
		 * Construtor da classe
		 * @param	container	MovieClip com dois frames que representem on/off
		 */
		public function MusicManager(container:MovieClip) {
			
			super();
			
			this.container = container;
			this.scope = container.parent.parent;
		}
		
		/**
		 * Método que deve ser chamado quando o usuário clicar em jogar
		 */
		public function start():void {
			
			if (getVolume() >= minVolume) 
				setVolume(minVolume);
			started = true;
		}
		
		/**
		 * Método que deve ser chamado quando o usuário reiniciar a aplicação, ou seja, quando ela for reencaminhada para o 1º frame.
		 */
		public function reStart():void {
			
			if (getVolume() >= minVolume) 
				setVolume(volume);
			started = false;
		}
		
		/**
		 * Método utilizado para iniciar a música do aplicativo
		 * @param	music		Sound. A música da aplicação
		 * @param	volume		Number. Representa o volume que a música terá
		 */
		public function startMusicBySound(music:Sound, volume:Number = 1):void {
			
			this.volume = volume;
			this.music = music;
			init();
		}
		
		public function loadMusic(url:String):void {
			
			music = new Sound(new URLRequest(url));
			music.addEventListener(Event.COMPLETE, completeHandler);
		}
		
		private function completeHandler(e:Event):void {
			
			init();
		}
		
		/**
		 * Inicializa o objeto gerenciador de músicas
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
		 * Evento disparado quando o usuário clica sobre o botão para ligar ou desligar a música
		 * @param	e
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
		 * Método utilizado para mudar o volume
		 * @param	volume	Number
		 */
		private function changeVolume(volume:Number):void {
			
			musicTransform.volume = volume;
			fade(volume);
		}
		
		/**
		 * Método que realiza a transição de volume de uma música
		 * @param	volume
		 */
		private function fade(volume:Number):void {
			
			Tweener.addTween(channel, {_sound_volume:volume, time:1, transition: "easeInOutQuad"});
		}
		
		/**
		 * Método que retorna o volume do objeto musicTransform
		 * @return
		 */
		public function getVolume():Number {
			
			return musicTransform.volume;
		}
		
		/**
		 * Método responsável pela mudança do volume padrão da música
		 * @param	value
		 */
		public function setVolume(value:Number = 0.5):void {
			
			changeVolume(value);
		}
		
		/**
		 * Método que pára a música atual. 
		 * Pouco utilizado.
		 */
		public function stopCurrentMusic():void {
			
			channel.stop();
			music = null;
		}
		
		/**
		 * Método utilizado para trocar músicas durante a execução do aplicativo
		 * @param	s	Sound
		 * @param	v	Number volume
		 */
		public function changeCurrentMusic(s:Sound, v:Number = 0.5):void {
			
			this.volume = v;
			
			Tweener.addTween(channel, { _sound_volume:0, time:1, transition: "easeInOutQuad", onComplete:removeSound, onCompleteParams:[s, v] } );
		}
		
		/**
		 * Método chamado ao final da transição decorrente do método changeCurrentMusic.
		 * Remove a música antiga e adiciona a nova.
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
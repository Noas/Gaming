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
		 * Variável do tipo Number que guarda o progresso dos carregamentos
		 */
		private var _progress:Number;
		
		/**
		 * Utilizado para o registro do evento complete disparado quando 
		 * o carregamento da aplicação é finalizado
		 */
		public static const SELF_COMPLETE:String = "self_complete";
		
		/**
		 * Utilizado para o registro do evento progress disparado enquanto 
		 * o carregamento de algum dos assets está em andamento
		 */
		public static const PROGRESS:String = "progress";
		
		/**
		 * Construtor
		 */
		public function SelfManager() {
			super();
		}
		
		/**
		 * Função utilizada para o carregamento da aplicação em si
		 * @param	container	Geralmente this que representa a aplicação a ser carregada
		 */
		public function loadGame(container:DisplayObjectContainer = null):void {
			
			container.addEventListener(Event.ENTER_FRAME, loadingTheGame);
		}
		
		/**
		 * Enterframe utilizado para checar o status do carregamento da aplicação
		 * @param	e	Evento do tipo Event
		 */
		private function loadingTheGame(e:Event):void {
			
			_progress = Math.floor(( e.target.loaderInfo.bytesLoaded / e.target.loaderInfo.bytesTotal) * 100);
			
			if (e.target.loaderInfo.bytesTotal == e.target.loaderInfo.bytesLoaded) {
				
				e.target.removeEventListener(Event.ENTER_FRAME, loadingTheGame);
				dispatchEvent(new Event(SELF_COMPLETE));
			}
			
			dispatchEvent(new Event(PROGRESS));
		}
		
		public function get progress():Number {
			return _progress;
		}
	}
}
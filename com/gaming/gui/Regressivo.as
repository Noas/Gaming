package com.gaming.gui {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class Regressivo {
		
		private var statusObject:MovieClip;
		private var seconds:int;
		private var timer:Timer;
		
		/**
		 * O construtor recebe um movieclip que contém o campo de texto utilizado como relógio
		 * @param	statusObject : movieclip que contém o campo que mostra o tempo
		 */
		public function Regressivo(statusObject:MovieClip) {
			
			this.statusObject = statusObject;
		}
		
		/**
		 * Função pública chamada para disparar o relógio. Recebe a quantidade de segundos.
		 * @param	s : número que representa o total de segundos inicial
		 */
		public function startTime(s:Number):void {
			
			seconds = s;
			timer = new Timer(1000);
			startTimer();
		}
		
		/**
		 * Função responsável pelos cálculos do tempo
		 * @param	e : timer event
		 */
		private function timerHandler(e:TimerEvent):void {
			
			if (seconds > 0) {
				
				seconds--;
				
				var min:Number = Math.floor(seconds / 60);
				var sec:Number = Math.round(seconds % 60);
				
				var secStr:String = ((sec < 10) ? "0" : "") + sec.toString();
				var minStr:String = ((min < 10) ? "0" : "") + min.toString();
				
				statusObject.timerTxt.text = minStr + ":" + secStr;
				
			} else {
				
				stopTimer();
			}
		}
		
		/**
		 * Função que inicia o timer se ele não estiver rodando
		 */
		public function startTimer():void {
			
			if (!timer.running) {
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
				timer.start();
			}
		}
		
		/**
		 * Função que para o timer
		 * @param	reset : se true reseta o timer também
		 */
		public function stopTimer(reset:Boolean = true):void {
			
			if (timer.running) {
				
				timer.stop();
				
				if (reset) 
					resetTimer();
			}
		}
		
		/**
		 * Função que reseta o timer e remove o event listener
		 */
		private function resetTimer():void {
			
			if (timer.running) {
				timer.reset();
				timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			}
		}
		
		/**
		 * Função que verifica se o timer está rodando
		 * @return boolean
		 */
		public function isRunning():Boolean {
			
			//return timer.running;
			return seconds < 1 ? false : true;
		}
		
		/**
		 * Retorna o conteúdo do campo onde o tempo é mostrado
		 * @return string
		 */
		public function getTime():String {
			
			return statusObject.timerTxt.text;
		}
		
		public function getSeconds():int {
			
			return seconds;
		}
	}
}
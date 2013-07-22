package com.gaming.gui {
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class Cronometro {
		
		public var statusObject:MovieClip;
		private var seconds:int;
		public static var timer:Timer;
		
		public function Cronometro(statusObject:MovieClip) {
			
			this.statusObject = statusObject;
			
			startTimer();
		}
		
		private function startTimer():void {
			
			seconds = 0;
			
			timer = new Timer(1000);
			start();
		}
		
		private function timerHandler(e:TimerEvent):void {
			
			seconds++;
			
			var min:Number = Math.floor(seconds / 60);
			var sec:Number = Math.round(seconds % 60);
			
			var secStr:String = ((sec < 10) ? "0" : "") + sec.toString();
			var minStr:String = ((min < 10) ? "0" : "") + min.toString();
			
			statusObject.timerTxt.text = minStr + ":" + secStr;
		}
		
		public function start():void {
			
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
		}
		
		public function stopTimer():void {
			
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		public function getTime():String {
			
			return statusObject.timerTxt.text;
		}
		
		public function updateFase(fase:String):void {
			
			statusObject.faseTxt.text = fase;
		}
		
		public function updatePontos(pontos:String):void {
			
			statusObject.pointsTxt.text = pontos;
		}
	}	
}
package com.gaming.settings {
	
	/**
	 * Author: Marcos Cardoso Martins
	 * Data: 16/12/2011
	 * Empresa: Colégio Cenecista Dr. José Ferreira
	 */

	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class MouseSettings extends MovieClip {
		
		public function MouseSettings() {
			
			super();
		}
		
		public static function settings(movie:MovieClip, kind:String = "normal", dragable:Boolean = false):void {
			
			movie.buttonMode = true;
			movie.mouseChildren = false;
			
			if (kind == "label") {
				
				movie.addEventListener(MouseEvent.ROLL_OVER, approachWithLabel);
				movie.addEventListener(MouseEvent.ROLL_OUT, moveBackWithLabel);
				
			} else if (kind == "normal") {
				
				movie.addEventListener(MouseEvent.ROLL_OVER, approach);
				movie.addEventListener(MouseEvent.ROLL_OUT, moveBack);
				
			} 
			
			if (dragable) 
			{	
				movie.a = movie.x;
				movie.b = movie.y;
			}
		}
		
		public static function removeSettings(movie:MovieClip, kind:String = "normal"):void {
			
			movie.buttonMode = false;
			movie.removeEventListener(MouseEvent.ROLL_OVER, kind == "label" ? approachWithLabel : approach);
			movie.removeEventListener(MouseEvent.ROLL_OUT, kind == "label" ? moveBackWithLabel : moveBack);
		}
		
		public static function approach(event:MouseEvent):void {
			
			Tweener.addTween(event.target as MovieClip, { time:0.3, scaleX:1.1, scaleY:1.1});
		}
		
		public static function moveBack(event:MouseEvent):void {
			
			Tweener.addTween(event.target as MovieClip, { time:0.3, scaleX:1, scaleY:1});
		}
		
		public static function approachWithLabel(event:MouseEvent):void {
			
			event.target.gotoAndPlay("s1");
		}
		
		public static function moveBackWithLabel(event:MouseEvent):void {
			
			event.target.gotoAndPlay("s2");
		}
	}
}
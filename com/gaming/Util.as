package com.gaming {
	
	/**
	 * Author: Marcos Cardoso Martins
	 * Data: 09/2011
	 * Empresa: Colégio Cenecista Dr. José Ferreira
	 */
	
	import caurina.transitions.Tweener;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	
	import flash.display.MovieClip;
	
    public class Util {
		
		private var array:Array;
		private var aux:int;
		private var number:int;
		
        public function Util() {
			
            return;
        }
		
		public static function removeFilhos(mc:MovieClip):void {
			
			var qtd:uint = mc.numChildren;
			
			for (var i:uint = 0; i < qtd; i++) {
				
				mc.removeChildAt(0);
			}
		}
		
		public static function adicionaImagem(str:String):Loader {
			
			var imageLoader:Loader;
			var imageURL:URLRequest;
			
			imageURL = new URLRequest(str);
			
			imageLoader = new Loader();		
			imageLoader.load(imageURL);
			imageLoader.x -= imageLoader.width * 0.5;
			imageLoader.y -= imageLoader.height * 0.5;
			return imageLoader;
		}
		
		public static function createObjectFromString(obj:String):MovieClip {

			var symbolName:String = obj;
			var symbolClass:Class = getDefinitionByName(symbolName) as Class;

			var _mc:MovieClip = new symbolClass();
			_mc.name = obj;

			return _mc;
		}
		
		public static function _move(_mc:MovieClip, a:Number, b:Number, duration:Number = 0.5):void {
			
			Tweener.addTween(_mc, { time:duration, x:a, y:b, transition:"easeOutQuart" } );
		}
		
		public static function _random(_arr:Array):void {
			
			_arr.sort(randOrder);
		}
		
		public static function randOrder(a:*, b:*):int {
			
			return Math.random() > .5 ? 1 : -1;
		}
	
		public function _randomiza(n:Number):Array {
	
			array = new Array();
	
			for (var i:Number = 0; i < n; i++) {
	
				aux = Math.random() * n;
	
				if (array.length == 0) {
	
					array.push(aux);
	
				} else {
	
					number = _verifica(aux);
	
					if (number == -1) {
	
						i -= 1;
	
					} else {
	
						array.push(number);
					}
				}
			}
			return array;
		}
	
		public function _verifica(num:int):int {
	
			for (var j:Number = 0; j <= array.length; j++) {
	
				if (array[j] == num) {
				
					return -1;
	
				} 
			}
			return num;
		}
		
		public function _substr(str:String, a:Number, b:Number):String {
		
			str = str.substr(a, b);
			
			return str;
		}
		
		public function _appear(_mc:MovieClip, end:Number, duration:Number = 0.5):void {
			
			Tweener.addTween(_mc, {time:duration, alpha:end, transition:"easeOutQuart"} );
		}
    }
}
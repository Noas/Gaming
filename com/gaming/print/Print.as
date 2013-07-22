package com.gaming.print {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.printing.PrintJob;
	
	/**
	 * ...
	 * @author Marcos Cardoso
	 */
	
	public class Print extends MovieClip {
		
		private var printJob:PrintJob = new PrintJob(); 
        private var sprite:Sprite = new Sprite();
		
		public function Print() {
			
		}
		
		public function printLandscape(displayObject:MovieClip):void {
			
			
		}
		
		public function printPortrait(displayObject:MovieClip):void {
			
			if (printJob.start()) {
				
				try {
					printJob.addPage(displayObject);
				} catch(e:Error) {
					// handle error
				}
				
				printJob.send();
			}
		}
	}
}
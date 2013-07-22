package com.gaming.settings {
	
	import flash.display.MovieClip;
	
	/**
	 * Author: Marcos Cardoso Martins
	 * Data: 16/12/2011
	 * Empresa: Colégio Cenecista Dr. José Ferreira
	 */
	
	public class InformationSettings {
		
		private var help:MovieClip;
		private var informations:MovieClip;
		private var xml:XML;
		
		public function InformationSettings(help:MovieClip, informations:MovieClip, xml:XML) {
			
			this.help = help;
			this.informations = informations;
			this.xml = xml;
			
			setHelp();
			setInformation();
		}
		
		private function setHelp():void {
			
			help.tituloTxt.text = xml.help.@title;
			help.ajudaTxt.text = xml.help.text;
		}
		
		private function setInformation():void {
			
			informations.tituloTxt.text = xml.about.@title;
			informations.labelProfessorTxt.text = xml.about.teacher.@label;
			informations.professorTxt.text = xml.about.teacher.@txt;
			if (informations.labelDesenvTxt) {
				informations.labelDesenvTxt.text = xml.about.desenv.@label;
				informations.desenvTxt.text = xml.about.desenv.@txt;
			}
			informations.labelAreaTxt.text = xml.about.area.@label;
			informations.areaTxt.text = xml.about.area.@txt;
			informations.labelAnosTxt.text = xml.about.years.@label;
			informations.anosTxt.text = xml.about.years.@txt;
			informations.labelDescricaoTxt.text = xml.about.description.@label;
			informations.descricaoTxt.text = xml.about.description.@txt;
			informations.labelProporcionaTxt.text = xml.about.provide.@label;
			informations.proporcionaTxt.text = xml.about.provide.@txt;
		}
	}	
}
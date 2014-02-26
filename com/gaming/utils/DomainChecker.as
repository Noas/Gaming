package com.gaming.utils
{
	import flash.display.DisplayObject;

	public class DomainChecker
	{
		public static function isDomainAllowed(displayObject:DisplayObject):Boolean
		{
			//return displayObject.loaderInfo.loaderURL.match(/http:\/\/((www\.|wf\.)?noas\.com\.br|localhost|172\.16)/) != null;
			//return displayObject.loaderInfo.loaderURL.match(/http:\/\/((\w+\.)?noas\.com\.br|localhost|172\.16|cnec\.edu)/) != null;
			return displayObject.loaderInfo.loaderURL.match(/http:\/\/((\w+\.)?(noas\.com\.br|cnec\.edu(cacional)?(\.br)?)|localhost|172\.16)/) != null;
		}
	}
}
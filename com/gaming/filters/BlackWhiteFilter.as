package com.gaming.filters
{
	import flash.display.Shader;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;

	public class BlackWhiteFilter
	{
		[Embed("blackwhite.pbj", mimeType="application/octet-stream")]
		static public var filter:Class;	
		
		static public function getFilter():ShaderFilter
		{
			var shader:Shader = new Shader(new filter() as ByteArray);
			return new ShaderFilter(shader);
		}
	}
}
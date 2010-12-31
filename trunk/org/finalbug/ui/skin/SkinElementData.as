//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui.skin
{
	import flash.geom.Rectangle;
	
	/**
	 * SkinElementData
	 * 
	 * @author Tang Bin
	 * @since 2010
	 */	
	public class SkinElementData
	{
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		public static const FILL_TYPE:String = "fillType";
		/**
		 * 
		 * @default 
		 */
		public static const VECTORIAL_TYPE:String = "vectorialType";
		/**
		 * 
		 * @default 
		 */
		public static const BITMAP_TYPE:String = "bitmapType";
		
		private var _status:String;
		private var _type:String;
		private var _data:*;
		private var _asDefalut:Boolean = false;
		
		// used for scale9Grid for vectorial and bitmap type.
		// if null, it will be set as from topLeft to bottomRight.
		/**
		 * 
		 * @default 
		 */
		public var scale9:Rectangle;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get status():String
		{
			return _status;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get type():String
		{
			return _type;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get data():*
		{
			return _data;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get asDefault():Boolean
		{
			return _asDefalut;
		}
		
		//#######################################
		// CONSTRUCTOR.
		//#######################################
		
		/**
		 * 
		 * @param status
		 * @param type
		 * @param data
		 * @param asDefault
		 */
		public function SkinElementData(status:String, type:String, data:*, asDefault:Boolean = false)
		{
			this._status = status;
			this._type = type;
			this._data = data;
			this._asDefalut = asDefault;
		}
		
		//#######################################
		// OVERRIDE
		// Whit out getter, setter and handler
		// include public, protected and private.
		//#######################################
		
		//#######################################
		// PUBLIC
		//#######################################
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}
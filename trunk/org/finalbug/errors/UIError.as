/******************************************************
 * ___________.__              .__ ___.                 
 * \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____  
 *  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\ 
 *  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
 *  \__ |     |__|___|  (____  /____/___  /____/\___  / 
 *     \/             \/     \/         \/     /_____/  
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 *****************************************************/
package org.finalbug.errors
{
	/**
	 * UIError
	 * 
	 * @author Tang Bin
	 * @since 2010.8
	 */	
	public class UIError extends Error
	{
		/**
		 * 
		 * @default 
		 */
		public static const WRONG_SCROLLBAR_TYPE:String = "ScrollBar component type error.";
		/**
		 * 
		 * @default 
		 */
		public static const CONTROL_NULL:String = "Must register status before effect.";
		/**
		 * 
		 * @default 
		 */
		public static const DISPLAY_OBJECT_NULL:String = "Target displayObject not exist.";
		
		/**
		 * 
		 * @default 
		 */
		public static const WRONG_TYPE:String = "Type Error.";
		
		/**
		 * 
		 * @param message
		 * @param id
		 */
		public function UIError(message:String = "", id:int = 0)
		{
			super(message, id);
		}
	}
}
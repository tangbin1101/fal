// ##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__|     |__|___|__(______/____/_____/____/\___  /
// /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
// ##########################################################
package org.finalbug.utils
{
	/******************************************************
	 * utils.DataUtil
	 *
	 * @author Tang Bin
	 * @since old version
	 *****************************************************/
	public class DataUtil
	{
		/**
		 * Check out if the given parameter's value is contained in a group of values.
		 * 
		 * @param value Given parameter.
		 * @param arg A group of values.
		 * @return 
		 */
		public static function included(value:*, ...arg):Boolean
		{
			for (var i:Number = arg.length ; --i >= 0 ;)
			{
				if (value == arg[i])
				{
					return true;
				}
				else if (arg[i] is Array)
				{
					for each (var subValue:* in arg[i])
					{
						if (subValue == value) return true;
					}
				}
			}
			return false;
		}

		/**
		 * check if the value target is in the list of values.
		 * 
		 * @param target
		 * @param args
		 * @return Return the index of values in array list if target is found, or -1 if is not found
		 * 
		 */
		public static function match(target:*, values:Array):int
		{
			for (var i:uint = values.length ; --i >= 0 ; )
			{
				if (values[i] == target) return i;
			}
			return -1;
		}
	}
}
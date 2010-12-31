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
package org.finalbug.events
{
	import flash.events.Event;
	import org.finalbug.events.LoadEvent;
	
	/**
	 * Event class for net operations. mostly are load files and connect to server.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class LoadEvent extends Event
	{
		/* event for load */
		/**
		 * @eventType loadSuccess
		 */		
		public static const LOAD_SUCCESS:String = "loadSuccess";
		
		/**
		 * @eventType loadFailed
		 */		
		public static const LOAD_FAILED:String = "loadFailed";
		
		/**
		 * @eventType loading
		 */		
		public static const LOADING:String = "loading";
		
		/* event for connection */
		
		/* event for all kings of net operation */
		/**
		 * @eventType timeout
		 */		
		public static const TIMEOUT:String = "timeout";
		
		/* event variates */
		/**
		 * The name of the object that dispatch this event.
		 */		
		public var name:String = "";
		
		/**
		* total bytes that will be loaded.
		*/		
		public var bytesTotal:Number = 0;
		
		/**
		 * bytes thet is loaded.
		 */		
		public var bytesLoaded:Number = 0;
		
		/**
		 * current percent of loaded bytes in total bytes.
		 */		
		public var loadedRate:Number = 0;
		
		/**
		 * 
		 * @default 
		 */
		public var totalNum:uint = 0;
		/**
		 * 
		 * @default 
		 */
		public var loadedNum:uint = 0;
		/**
		 * 
		 * @default 
		 */
		public var errorNum:uint = 0;
		
		/**
		 * A data object can be any object.
		 */		
		public var data:*;
		
		/**
		 * 
		 * @default 
		 */
		public var targetName:String = "";
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 */
		public function LoadEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var newEvent:LoadEvent = new LoadEvent(this.type, this.bubbles, this.cancelable);
			newEvent.name = this.name;
			newEvent.bytesTotal = this.bytesTotal;
			newEvent.bytesLoaded = this.bytesLoaded;
			newEvent.loadedRate = this.loadedRate;
			newEvent.data = this.data;
			return newEvent;
		}
	}
}
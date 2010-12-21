/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
  *****************************************************/  
package org.finalbug.utils.motion
{
	import org.finalbug.data.DataModel;
	import org.finalbug.data.SetType;
	import org.finalbug.errors.DataError;
	import org.finalbug.events.MotionEvent;
	import org.finalbug.utils.DataUtil;
	
	/**
	 * Motion queue list. Run more motions in the same time or one by one.
	 *
	 * @author Tang Bin
	 * @since 2010.10
	 */
	public class MotionQueue extends DataModel
	{
		private var list:Array = new Array();
		private var currentIndex:uint = 0;
		private var _type:String = "orderly";
		private var _running:Boolean = false;
		
		public function MotionQueue()
		{
			super();
		}
		
		public function addMotion(motion:Motion):void
		{
			if(motion != null)
			{
				list.push(motion);
			}
		}
		
		public function removeMotion(motion:Motion):void
		{
			if(_running)
			{
				throw new Error("Cannot remove motion when running");
			}
			else
			{
				for(var i:uint = list.length ; --i >= 0 ; )
				{
					if(list[i] == motion)
					{
						list.splice(i, 1);
					}
				}
			}
		}
		
		public function clear():void
		{
			stop();
			list = new Array();
			this.currentIndex = 0;
		}
		
		public function start(type:String = "orderly"):void
		{
			if(!DataUtil.included(type, SetType.ORDERLY, SetType.CONCURRENT))
			{
				throw new DataError(DataError.TYPE_ERROR);
			}
			currentIndex = 0;
			_running = true;
			_type = type;
			if(type == SetType.ORDERLY)
			{
				startMotion();
			}
			else
			{
				startAllMotion();
			}
		}
		
		public function stop():void
		{
			if(_running)
			{
				if(_type == SetType.ORDERLY)
				{
					var motion:Motion = list[currentIndex] as Motion;
					if(motion != null) motion.stop();
				}
				else
				{
					for each(var motion2:Motion in list)
					{
						if(motion2 != null) motion2.stop();
					}
				}
				_running = false;
			}
		}
		
		private function startMotion():void
		{
			var motion:Motion = list[currentIndex] as Motion;
			if(motion != null)
			{
				motion.addEventListener(MotionEvent.MOTION_STOP, motionStopHandler);
				motion.start();
			}
			else
			{
				nextMotion();
			}
		}
		
		private function startAllMotion():void
		{
			for each(var motion:Motion in list)
			{
				if(motion != null)
				{
					motion.addEventListener(MotionEvent.MOTION_STOP, motionStopHandler);
					motion.start();
				}
			}
		}
		
		private function nextMotion():void
		{
			if(currentIndex < list.length - 1)
			{
				currentIndex++;
				startMotion();
			}
			else
			{
				endMotion();
			}
		}
		
		private function endMotion():void
		{
			var ee:MotionEvent = new MotionEvent(MotionEvent.MOTION_STOP);
			this.dispatchEvent(ee);
		}
		
		private function motionStopHandler(e:MotionEvent):void
		{
			if(_type == SetType.ORDERLY)
			{
				e.motion.removeEventListener(MotionEvent.MOTION_STOP, motionStopHandler);
				nextMotion();
			}
			else
			{
				if(++this.currentIndex == list.length - 1)
				{
					endMotion();
				}
			}
		}
	}
}
package fal.motion
{
	import fal.errors.UIError;
	
	public class MoveMotion extends Motion
	{
		/**
		 * x coordinate that target object will move start.
		 * if not set, current target object's x coordinate will be taken as this value.
		 */		
		public var xFrom:Number;
		
		/**
		 * y coordinate that target object will move start.
		 * if not set, target object's current x coordinate will be taken as this value.  
		 */		
		public var yFrom:Number;
		
		/**
		 * x coordinate value that object will move to.
		 */		
		public var xTo:Number;
		/**
		 * y coordinate value that object will move to.
		 */		
		public var yTo:Number;
		
		public function MoveMotion(target:Object)
		{
			super(target);
		}
		
		/**
		 * account target object's position which will be used during moting effect.
		 * 
		 * @param target
		 */		
		override protected function account(target:Object):void
		{
			try
			{
				if(time >= 1)
				{
					/* account x values */
					var x0:Number = isNaN(xFrom) ? target["x"] : xFrom; // x from
					var x1:Number = isNaN(xTo) ? target["x"] : xTo; // x to
					var xSteps:Array = getStepList(x0, x1);
					/* account y values */
					var y0:Number = isNaN(yFrom) ? target["y"] : yFrom;
					var y1:Number = isNaN(yTo) ? target["y"] : yTo;
					var ySteps:Array = getStepList(y0, y1);
					// register moting to runner.
					registeredMotions.push(MotionRunner.instance.register(target, "x", xSteps, this.time, this));
					registeredMotions.push(MotionRunner.instance.register(target, "y", ySteps, this.time));
				}
			}
			catch(e:Error)
			{
				throw new UIError(UIError.NO_IUI);
			}
		}
	}
}
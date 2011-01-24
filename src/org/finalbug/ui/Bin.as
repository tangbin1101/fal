//##########################################################
// __________.__              .__ ___.
// \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__|     |__|___|__(______/____/_____/____/\___  /
//                                            /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.finalbug.data.Position;
	import org.finalbug.events.DisplayEvent;
	import org.finalbug.events.MotionEvent;
	import org.finalbug.events.UIEvent;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.style.FillStyle;
	import org.finalbug.ui.style.LayoutStyle;
	import org.finalbug.utils.MathUtil;
	import org.finalbug.utils.motion.MoveMotion;
	import org.finalbug.utils.motion.SizeMotion;
	
	/**
	 * Bin is the basic class for all other display object used in fb-aslib.
	 * This class will override displayObjec's width and height.
	 * Inside class/subclasses, use width and height as object's
	 * width and height values.
	 *
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class Bin extends Sprite
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		/**
		 * @default 0
		 */
		override public function get width():Number
		{
			return _layoutStyle.width;
		}
		
		/**
		 * Set Bin's width.
		 * Class Bin's width is overrided, change width value will not change the
		 * display direct, instead, the width value in layoutStyle will be changed and
		 * updateSize() will be invoked.
		 *
		 * @param value
		 */
		override public function set width(value:Number):void
		{
			var newWidth:Number = MathUtil.getNumArea(value, minWidth, maxWidth);
			if(newWidth != this.width)
			{
				_layoutStyle.setValue("width", newWidth);
				if(this.stage != null)
				{
					this.updateSize();
					this.dispatchSizeChanged();
					sizeChanged = false;
				}
				else
				{
					sizeChanged = true;
				}
			}
		}
		
		/**
		 * @default 0
		 */
		override public function get height():Number
		{
			return _layoutStyle.height;
		}
		
		/**
		 * Set Bin's height.
		 * Class Bin's height is overrided, change height value will not change the
		 * display direct, instead, the height value in layoutStyle will be changed and
		 * updateSize() will be invoked.
		 *
		 * @param value
		 */
		override public function set height(value:Number):void
		{
			var newHeight:Number = MathUtil.getNumArea(value, minHeight, maxHeight);
			if(newHeight != this.height)
			{
				_layoutStyle.setValue("height", newHeight);
				if(this.stage != null)
				{
					this.updateSize();
					this.dispatchSizeChanged();	
					sizeChanged = false;
				}
				else
				{
					sizeChanged = true;
				}
			}
		}
		
		/**
		 * 
		 * @param value
		 */
		override public function set x(value:Number):void
		{
			var oldWidth:Number = _layoutStyle.width;
			var oldHeight:Number = _layoutStyle.height;
			//
			_layoutStyle.setValue("left", value);
			var newX:Number = _layoutStyle.x;
			if (!isNaN(newX)) super.x = newX;
			//
			if(oldWidth != _layoutStyle.width || oldHeight != _layoutStyle.height)
			{
				// if object's x coordinate is changed, 
				// call updateSize only if size is changed too.
				if(this.stage != null)
				{
					this.updateSize();
					sizeChanged = false;
				}
				else
				{
					sizeChanged = true;
				}
			}
		}
		
		/**
		 * 
		 * @param value
		 */
		override public function set y(value:Number):void
		{
			var oldWidth:Number = _layoutStyle.width;
			var oldHeight:Number = _layoutStyle.height;
			//
			_layoutStyle.setValue("top", value);
			var newY:Number = _layoutStyle.y;
			if (!isNaN(newY)) super.y = newY;
			//
			if(oldWidth != _layoutStyle.width || oldHeight != _layoutStyle.height)
			{
				// if object's x coordinate is changed, 
				// call updateSize only if size is changed too.
				if(this.stage != null)
				{
					this.updateSize();
					sizeChanged = false;
				}
				else
				{
					sizeChanged = true;
				}
			}
		}
		
		/**
		 * 
		 * @param child
		 * @return 
		 */
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var child:DisplayObject = super.addChild(child);
			dispatchChildChanged();
			return child;
		}
		
		/**
		 * 
		 * @param child
		 * @param index
		 * @return 
		 */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var child:DisplayObject = super.addChildAt(child, index);
			dispatchChildChanged();
			return child;
		}
		
		/**
		 * 
		 * @param child
		 * @return 
		 */
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			var child:DisplayObject = super.removeChild(child);
			dispatchChildChanged();
			return child;
		}
		
		/**
		 * 
		 * @param index
		 * @return 
		 */
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = super.removeChildAt(index);
			dispatchChildChanged();
			return child;
		}
		
		/**
		 * 
		 * @param child1
		 * @param child2
		 */
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			super.swapChildren(child1, child2);
			dispatchChildChanged();
		}
		
		/**
		 * 
		 * @param index1
		 * @param index2
		 */
		override public function swapChildrenAt(index1:int, index2:int):void
		{
			super.swapChildrenAt(index1, index2);
			dispatchChildChanged();
		}
		
		//#######################################
		// DEFINE
		//#######################################
		
		private const SMOOTH_DELAY:Number=30;
		
		/**
		 * 
		 * @default 
		 */
		protected var sizeChanged:Boolean = false;
		
		/**
		 *
		 * @default null
		 */
		protected var _fillStyle:FillStyle;
		
		/**
		 * 
		 * @default 
		 */
		protected var _layoutStyle:LayoutStyle;
		
		private var _maxWidth:Number=4000;
		private var _maxHeight:Number=4000;
		private var _minWidth:Number=0;
		private var _minHeight:Number=0;
		
		private var moveMotion:MoveMotion;
		private var sizeMotion:SizeMotion;
		
		private var _controlPoint:Point = new Point(0, 0);
		private var _controlPointType:String = "";
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 *
		 * @return
		 */
		public function get fillStyle():FillStyle
		{
			return _fillStyle;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set fillStyle(value:FillStyle):void
		{
			if (_fillStyle != value)
			{
				_fillStyle = value;
				drawBg();
			}
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get layoutStyle():LayoutStyle
		{
			return _layoutStyle;
		}
		
		/**
		 * 
		 * @param value
		 */
		public function set layoutStyle(value:LayoutStyle):void
		{
			if(_layoutStyle != value)
			{
				_layoutStyle = value;
				this.updateByLayout();
			}
		}
		
		/**
		 * controlPoint is the point used to control the Bin object.
		 * You can set the position, rotate the object by it's controlPoint.
		 * @default (0, 0)
		 */
		public function get controlPoint():Point
		{
			accountControlPoint();
			return _controlPoint;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set controlPoint(value:Point):void
		{
			_controlPointType = "";
			_controlPoint = value;
		}
		
		/**
		 * The x coordition value of controlPoint from object's parent.
		 */
		public function get controlX():Number
		{
			return this.x + controlPoint.x;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set controlX(value:Number):void
		{
			this.x = value - controlPoint.x;
		}
		
		/**
		 * The y coordition value of controlPoint from object's parent.
		 */
		public function get controlY():Number
		{
			return this.y + controlPoint.y;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set controlY(value:Number):void
		{
			this.y=value - controlPoint.y;
		}
		
		/**
		 * The max width value of object.
		 * @default 4000
		 */
		public function get maxWidth():Number
		{
			return _maxWidth;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set maxWidth(value:Number):void
		{
			_maxWidth=value;
			if (this.width > _maxWidth)
			{
				this.width = _maxWidth;
			}
		}
		
		/**
		 * The max height value of object.
		 * @default 4000
		 */
		public function get maxHeight():Number
		{
			return _maxHeight;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set maxHeight(value:Number):void
		{
			_maxHeight=value;
			if (this.height > _maxHeight)
			{
				this.height=_maxHeight;
			}
		}
		
		/**
		 * The min width value of object.
		 * @default 0
		 */
		public function get minWidth():Number
		{
			return _minWidth;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set minWidth(value:Number):void
		{
			_minWidth=Math.max(value, 0);
			if (this.width < _minWidth)
			{
				this.width = _minWidth;
			}
		}
		
		/**
		 * The min height value of object.
		 * @default 0
		 */
		public function get minHeight():Number
		{
			return _minHeight;
		}
		
		/**
		 *
		 * @param value
		 */
		public function set minHeight(value:Number):void
		{
			_minHeight=Math.max(value, 0);
			if (this.height < _minHeight)
			{
				this.height = _minHeight;
			}
		}
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * Create an new Bin object.
		 */
		public function Bin()
		{
			super();
			_layoutStyle = new LayoutStyle();
			_layoutStyle.owner = this;
			// for first added to stage
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * Change Bin's size to target width and height immediately.
		 * run updateSize to reisze.
		 * 
		 * @param width
		 * @param height
		 */
		public function resize(width:Number, height:Number):void
		{
			var newWidth:Number = MathUtil.getNumArea(width, this.minWidth, this.maxWidth);
			var newHeight:Number = MathUtil.getNumArea(height, this.minHeight, this.maxHeight);
			if(newWidth != this.width || newHeight != this.height)
			{
				_layoutStyle.setValue("width", width);
				_layoutStyle.setValue("height", height);
				if(this.stage != null)
				{
					this.updateSize();
					this.dispatchSizeChanged();
					sizeChanged = false;
				}
				else
				{
					sizeChanged = true;
				}
				
			}
		}
		
		/**
		 * Zoom object's size to target width and height smoothly.
		 * Using Motion classes.
		 *
		 * @param width Target width.
		 * @param height Target height.
		 * @param during Time spend to change, in millisecond.
		 */
		public function zoomTo(width:Number, height:Number, during:uint = 500):void
		{
			if (this.sizeMotion == null)
			{
				this.sizeMotion=new SizeMotion(this);
				this.sizeMotion.addEventListener(MotionEvent.MOTION_STOP, stopZoomHandler);
			}
			else if (this.sizeMotion.running)
			{
				this.sizeMotion.stop();
			}
			this.sizeMotion.widthFrom = this.width
			this.sizeMotion.heightFrom  =this.height
			this.sizeMotion.widthTo = width;
			this.sizeMotion.heightTo = height;
			this.sizeMotion.during = during;
			this.sizeMotion.start();
		}
		
		/**
		 * Move object to target position smoothly.
		 * Using Motion classes.
		 *
		 * @param x Target x coordition
		 * @param y Target y coordition
		 * @param during Move during time in millisecond.
		 */
		public function moveTo(x:Number, y:Number, during:uint = 500):void
		{
			if (this.moveMotion == null)
			{
				this.moveMotion=new MoveMotion(this);
				moveMotion.addEventListener(MotionEvent.MOTION_STOP, stopMoveHandler);
			}
			else if (this.moveMotion.running)
			{
				this.moveMotion.stop();
			}
			moveMotion.xFrom=this.x;
			moveMotion.yFrom=this.y;
			moveMotion.xTo=x;
			moveMotion.yTo=y;
			moveMotion.during=during;
			moveMotion.start();
		}
		
		/**
		 * Bring the object to the front of it's parent.
		 */
		public function toFront():void
		{
			if (this.parent != null)
			{
				this.parent.setChildIndex(this, this.parent.numChildren - 1);
			}
		}
		
		/**
		 * Bring the object to the back of it's parent.
		 */
		public function toBack():void
		{
			if (this.parent != null)
			{
				this.parent.setChildIndex(this, 0);
			}
		}
		
		/**
		 * Place the object to the center of it's parent.
		 */
		public function toCenter():void
		{
			if (this.parent != null)
			{
				this.x=(this.parent.width - this.width) / 2;
				this.y=(this.parent.height - this.height) / 2;
			}
		}
		
		/**
		 * Place the object to the specified position
		 *
		 * @param pos Position string, see Class Position.
		 * @param center Only effect when parameter pos is one of the following values:
		 * 		Position.TOP, Position.LEFT, Position.RIGHT, Position.BOTTOM.
		 */
		public function toPosition(pos:String, center:Boolean = true):void
		{
			if (this.parent != null)
			{
				switch (pos)
				{
					case Position.TOP_CENTER:
						center=true;
					case Position.TOP:
						if (center)
						{
							this.x=(this.parent.width - this.width) / 2;
						}
						this.y=0;
						break;
					case Position.TOP_LEFT:
						this.x=this.y=0;
						break;
					case Position.TOP_RIGHT:
						this.x=this.parent.width - this.width;
						this.y=0;
						break;
					case Position.LEFT_CENTER:
						center=true;
					case Position.LEFT:
						if (center)
						{
							this.y=(this.parent.height - this.height) / 2;
						}
						this.x=0;
						break;
					case Position.RIGHT_CENTER:
						center=true;
					case Position.RIGHT:
						if (center)
						{
							this.y=(this.parent.height - this.height) / 2;
						}
						this.x=this.parent.width - this.width;
						break;
					case Position.BOTTOM_CENTER:
						center=true;
					case Position.BOTTOM:
						if (center)
						{
							this.x=(this.parent.width - this.width) / 2;
						}
						this.y=this.parent.height - this.height;
						break;
					case Position.BOTTOM_LEFT:
						this.x=0;
						this.y=this.parent.height - this.height;
						break;
					case Position.BOTTOM_RIGHT:
						this.x=this.parent.width - this.width;
						this.y=this.parent.height - this.height;
						break;
				}
			}
		}
		
		/**
		 * Add all children.
		 * 
		 * @param args List of children.
		 */
		public function addAll(... args):void
		{
			var len:uint=args.length;
			for (var i:uint=0; i < len; i++)
			{
				if (args[i] is DisplayObject)
				{
					this.addChild(args[i]);
				}
			}
		}
		
		/**
		 * remove all children and clean the graphics.
		 */
		public function removeAll():void
		{
			this.graphics.clear();
			for (var i:uint=this.numChildren; --i >= 0; )
			{
				this.removeChildAt(i);
			}
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		/**
		 *
		 */
		protected function updateSize():void
		{
			drawBg();
		}
		
		/**
		 *
		 */
		protected function callAtAdded():void
		{
			var isBtn:Boolean = this is Button;
			if(sizeChanged)
			{
				countSizeAndPosition();
				updateSize();
				dispatchSizeChanged();
				sizeChanged = false;
			}
		}
		
		/**
		 *
		 */
		protected function countSizeAndPosition():void
		{
		}
		
		/**
		 *
		 */
		protected function drawBg():void
		{
			if (_fillStyle != null)
			{
				_fillStyle.fill(this, this.width, this.height);
			}
			else
			{
				this.graphics.clear();
			}
		}
		
		/**
		 * 
		 */
		internal function updateByLayout():void
		{
			if(_layoutStyle != null)
			{
				this.x = _layoutStyle.x;
				this.y = _layoutStyle.y;
				this.updateSize();
			}
		}
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function accountControlPoint():void
		{
			switch (_controlPointType)
			{
				case Position.TOP_CENTER:
					_controlPoint.x = this.width / 2;
					_controlPoint.y = 0;
					break;
				case Position.TOP_LEFT:
					_controlPoint.x = _controlPoint.y=0;
					break;
				case Position.TOP_RIGHT:
					_controlPoint.x = this.width;
					_controlPoint.y = 0;
					break;
				case Position.LEFT_CENTER:
					_controlPoint.x=0;
					_controlPoint.y = this.height / 2;
					break;
				case Position.CENTER:
					_controlPoint.x = this.width / 2;
					_controlPoint.y = this.height / 2;
					break;
				case Position.RIGHT_CENTER:
					_controlPoint.x = this.width;
					_controlPoint.y = this.height / 2;
					break;
				case Position.BOTTOM_LEFT:
					_controlPoint.x = 0;
					_controlPoint.y = this.height;
					break;
				case Position.BOTTOM_CENTER:
					_controlPoint.x = this.width / 2;
					_controlPoint.y = this.height;
					break;
				case Position.BOTTOM_RIGHT:
					_controlPoint.x = this.width;
					_controlPoint.y = this.height;
					break;
				default:
					_controlPoint.x = _controlPoint.y = 0;
					_controlPointType = "";
					break;
			}
		}
		
		private function dispatchChildChanged():void
		{
			var ee:UIEvent = new UIEvent(UIEvent.CHILDREN_CHANGED);
			this.dispatchEvent(ee);
		}
		
		private function dispatchSizeChanged():void
		{
			for(var i:uint = this.numChildren ; --i >= 0 ; )
			{
				var child:DisplayObject = this.getChildAt(i);
				if(child is Bin)
				{
					(child as Bin).updateByLayout();
				}
			}
			var ee:UIEvent = new UIEvent(UIEvent.RESIZE);
			this.dispatchEvent(ee);
		}
		
		//#######################################
		// HANDLER
		//#######################################
		
		private function stopZoomHandler(e:MotionEvent):void
		{
			this.dispatchEvent(new DisplayEvent(DisplayEvent.END_ZOOM));
		}
		
		private function stopMoveHandler(e:MotionEvent):void
		{
			this.dispatchEvent(new DisplayEvent(DisplayEvent.END_MOVE));
		}
		
		private function addedToStageHandler(e:Event):void
		{
			//this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.callAtAdded();
		}
	}
}
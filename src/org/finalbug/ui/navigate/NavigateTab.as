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
package org.finalbug.ui.navigate
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import org.finalbug.errors.DataError;
	import org.finalbug.ui.control.Button;
	import org.finalbug.ui.control.Container;
	
	
	/**
	 * NavigateTab, not finished.
	 * 
	 * @author Tang Bin
	 * @since 2011.01
	 */	
	public class NavigateTab extends Container
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		protected const BUTTON_HEIGHT:Number = 26;
		
		private var btnBar:Container;
		private var box:Slider;
		
		private var tabs:Dictionary = new Dictionary();
		
		private var currentSelected:TabData;
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		/**
		 * 
		 * @param skinData
		 */
		public function NavigateTab()
		{
			super();
			this.name = "navigate tab";
			// create children.
			btnBar = new Container();
			btnBar.horizontalRank(0, true, false, true);
			box = new Slider();
			this.addAll(btnBar, box);
			//
			btnBar.layoutStyle.setNormalStyle("100%", BUTTON_HEIGHT, 0, 0);
			box.layoutStyle.setAroundStyle(0, BUTTON_HEIGHT, 0, 0);
		}
		
		//#######################################
		// PUBLIC
		//#######################################
		
		
		/**
		 * Add new tab into NavigateTab.
		 * 
		 * @param label Label string of new tab
		 * @param object Container of new tab. If null, an new Sprite object will be created and added to tab.
		 * @param index Index of new tab. -1 means added to the last.
		 * @return If object is not null, return object, or return the new Sprite object as DisplayObject.
		 */
		public function addTab(label:String, object:DisplayObject = null, index:int = -1):DisplayObject
		{
			var maxLen:uint = btnBar.numChildren;
			if(index < 0 || index > maxLen)
			{
				index = maxLen;
			}
			//
			if(object == null)
			{
				object = new Sprite();
			}
			// create elements and data
			var data:TabData = new TabData();
			data.label = label;
			data.object = object;
			data.btn = new Button(label);
			data.btn.holdable = true;
			data.btn.addEventListener(MouseEvent.CLICK, clickTabBtnHandler);
			// save data into dictionary.
			tabs[data.btn] = data;
			// add elements to display.
			if(index >=0 && index < maxLen)
			{
				btnBar.addChildAt(data.btn, index);
				box.addChildAt(data.object, index);
			}
			else
			{
				btnBar.addChild(data.btn);
				box.addChild(data.object);
			}
			// change selected
			if(currentSelected == null)
			{
				doSelect(data);
			}
			//
			return object;
		}
		
		/**
		 * 
		 * @param index
		 * @return 
		 * @throws DataError
		 */
		public function getTabObjectAt(index:uint):DisplayObject
		{
			if(index >= tabs.length)
			{
				throw new DataError(DataError.INVALID_INDEX);
			}
			return (tabs[index] as TabData).object;
		}
		
		/**
		 * 
		 * @param index
		 * @return 
		 * @throws DataError
		 */
		public function getTabLabelAt(index:uint):String
		{
			if(index >= tabs.length)
			{
				throw new DataError(DataError.INVALID_INDEX);
			}
			return (tabs[index] as TabData).label;
		}
		
		/**
		 * 
		 * @param index
		 * @param label
		 */
		public function setTabLabelAt(index:uint, label:String):void
		{
			if(index >= tabs.length)
			{
				throw new DataError(DataError.INVALID_INDEX);
			}
			
		}
		
		/**
		 * 
		 * @param object
		 * @param label
		 */
		public function setTabLabelByObject(object:DisplayObject, label:String):void
		{
			
		}
		
		/**
		 * 
		 * @param index
		 */
		public function removeTabAt(index:uint):void
		{
			
		}
		
		/**
		 * 
		 * @param object
		 */
		public function removeTabByObject(object:DisplayObject):void
		{
			
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		//#######################################
		// PRIVATE
		//#######################################
		
		private function doSelect(data:TabData):void
		{
			// remove pre-selected
			if(currentSelected != null)
			{
				currentSelected.btn.hold = false;
			}
			// select new 
			data.btn.hold = true;
			box.selectedChild = data.object;
			// save select data.
			currentSelected = data;
		}
		
		//#######################################
		// HANDLER
		//#######################################
		
		private function clickTabBtnHandler(e:MouseEvent):void
		{
			var btn:Button = e.currentTarget as Button;
			if(btn != null)
			{
				this.doSelect(tabs[btn]);
			}
		}
	}
}
import flash.display.DisplayObject;

import org.finalbug.ui.control.Button;

class TabData
{
	/**
	 * 
	 * @default 
	 */
	public var label:String;
	/**
	 * 
	 * @default 
	 */
	public var object:DisplayObject;
	/**
	 * 
	 * @default 
	 */
	public var btn:Button;
}
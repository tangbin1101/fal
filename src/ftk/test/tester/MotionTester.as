// ##############################################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
// |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// \__ |     |__|___|  (____  /____/___  /____/\___  /
// \/             \/     \/         \/     /_____/
// Flex ToolKits by Finalbug
// http://www.finalbug.org
// ##############################################################################
// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org
// **********************************************************
package ftk.test.tester
{
	import flash.events.MouseEvent;
	import ftk.events.MotionEvent;
	import ftk.ui.Bin;
	import ftk.ui.control.Button;
	import ftk.ui.control.UIObject;
	import ftk.utils.motion.FadeMotion;
	import ftk.utils.motion.MotionQueue;
	import ftk.utils.motion.MoveMotion;


	/**
	 * MotionTester
	 *
	 * @author Tang Bin
	 * @since 2010.08
	 */
	public class MotionTester extends UIObject
	{

		/****************************************
		 *
		 * GETTER and SETTER
		 *
		 *************************************************************/
		/****************************************
		 *
		 * org.finalbug.faltester.tester.MotionTester constructor.
		 *
		 *************************************************************/
		public function MotionTester()
		{
		}

		/****************************************
		 *
		 * DEFINE
		 *
		 *************************************************************/
		private var container:Bin;

		/****************************************
		 *
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 *
		 *************************************************************/
		override protected function callAtAdded():void
		{
			var btn:Button = new Button("start");
			this.addAll(btn);
			btn.tooltip = "test";
			btn.addEventListener(MouseEvent.CLICK, clickBtnHandler);
			//
			var mq:MotionQueue = new MotionQueue();
			var m:MoveMotion = new MoveMotion(btn);
			m.xTo = 200;
			m.yTo = 300;
			//
			var f:FadeMotion = new FadeMotion(btn);
			f.alphaTo = 0;
			//
			mq.addMotion(m);
			mq.addMotion(f);
			//
			// mq.start(SetType.CONCURRENT);
			mq.addEventListener(MotionEvent.MOTION_STOP, stopHandler);
		}

		/****************************************
		 *
		 * HANDLER
		 *
		 *************************************************************/
		private function clickBtnHandler(e:MouseEvent):void
		{
			if (container == null)
			{
				container = new Bin();
				this.addAll(container);
			}
			else
			{
				container.removeAll();
			}
			startTest(1000);
		}

		/****************************************
		 *
		 * PUBLIC
		 *
		 *************************************************************/
		/****************************************
		 *
		 * PROTECTED
		 *
		 *************************************************************/
		/****************************************
		 *
		 * PRIVATE
		 *
		 *************************************************************/
		private function startTest(total:uint):void
		{
			for (var i:uint = 0; i < total; i++)
			{
				var bin:Bin = new Bin();
				bin.graphics.beginFill(0, 0.8);
				bin.graphics.drawRect(0, 0, 2, 2);
				bin.graphics.endFill();
				container.addAll(bin);
				bin.moveTo(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
			}
		}

		private function stopHandler(e:MotionEvent):void
		{
		}
	}
}
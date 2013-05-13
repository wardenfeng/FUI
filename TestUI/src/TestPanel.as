package
{
	import com.bit101.components.Panel;
	import com.feng.components.FPanel;
	
	import flash.display.Sprite;
	
	import fl.ui.PanelTest;

	public class TestPanel extends Sprite
	{
		public function TestPanel()
		{
			var panel:Panel = new Panel(this);
			panel.showGrid = true;

			var panelTest:PanelTest = new PanelTest();
			addChild(panelTest);

			FPanel.getInstance(panelTest.tPanel);

		}
	}
}
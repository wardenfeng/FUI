package
{
	import com.bit101.components.CheckBox;
	import com.feng.components.FCheckBox;
	
	import flash.display.Sprite;
	
	/**
	 * 
	 * @author warden_feng 2013-8-14
	 */
	public class TestCheckBox extends Sprite
	{
		public function TestCheckBox()
		{
			new CheckBox(this,0,0,"a");
			
			var checkBoxTest:CheckBoxTest = new CheckBoxTest();
			addChild(checkBoxTest);
			
			var checkb:FCheckBox = FCheckBox.getInstance(checkBoxTest.tCheckBox);
			checkb.x = checkb.y = 100;
			checkb.label = "label";
		}
	}
}
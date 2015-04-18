package dialogue.plaques
{
	import assets.PlaqueAssets;
	import global.Global;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * @author @shaun
	 */
	public class PlaqueStatus extends Sprite
	{
		public static const CALLING:String = 'calling';
		public static const ENDED:String = 'ended';
		
		private static const BG:String = 'status';
		private static const ORB:String = 'orb';
		
		private var orb1:MovieClip;
		private var orb2:MovieClip;
		private var orb3:MovieClip;
		private var _status:String;
		
		protected var _name:String;
		protected var _textFieldName:TextField;
		protected var _textFieldStatus:TextField;
		protected var _bg:Image;
		
		public function PlaqueStatus(name:String, status:String = 'calling')
		{
			this._name = name;
			this._status = status;
			createPlaque();
		}
		
		private function createPlaque():void
		{
			_bg = new Image(PlaqueAssets.getAtlas().getTexture(PlaqueStatus.BG));
			addChild(_bg);
			
			if (_status === PlaqueStatus.CALLING) {
				_textFieldStatus = new TextField(150, 60, _status.toUpperCase(), Global.DEFAULT_FONT, 24, Global.BLUE_KARMA_WHITE, true);
				_textFieldStatus.x = 50;
				_textFieldStatus.y = 230;
				addChild(_textFieldStatus);
				
				_textFieldName = new TextField(150, 60, _name, Global.DEFAULT_FONT, 16, 0x4077d1, true);
				_textFieldName.x = 50;
				_textFieldName.y = 260;
				addChild(_textFieldName);
				
				addOrbs();
			}
		}
		
		private function addOrbs():void
		{
			orb1 = new MovieClip(PlaqueAssets.getAtlas().getTextures(ORB));
			orb1.x = 70;
			orb1.y = 144;
			addChild(orb1);
			
			orb2 = new MovieClip(PlaqueAssets.getAtlas().getTextures(ORB));
			orb2.x = 113;
			orb2.y = 144;
			addChild(orb2);
			
			orb3 = new MovieClip(PlaqueAssets.getAtlas().getTextures(ORB));
			orb3.x = 155;
			orb3.y = 144;
			addChild(orb3);
			
			Starling.juggler.add(orb1);
			Starling.juggler.add(orb2);
			Starling.juggler.add(orb3);
			
			orb1.currentFrame = 1;
			orb2.currentFrame = 4;
			orb3.currentFrame = 8;
			
			orb1.play();
			orb2.play();
			orb3.play();
		}
		
		public function hideAndRemove():void
		{
			if (_status === PlaqueStatus.CALLING) {
				orb1.stop();
				orb2.stop();
				orb3.stop();
				
				Starling.juggler.remove(orb1);
				Starling.juggler.remove(orb2);
				Starling.juggler.remove(orb3);
			}	
			
			
			this.visible = false;
			this.removeFromParent(true);
		}
	}
}
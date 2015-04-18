package notifications.mail.missions 
{
	import assets.GameAssets;
	import assets.MailAssets;
	import bluekarma.assets.sound.SoundAssets;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import global.Global;
	import notifications.mail.MailButton;
	import sound.SoundManager;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Shaun Stone
	 */
	public class MissionStatementDawson extends Sprite 
	{
		private var mailBtn:MailButton;
		private var image:Image;
		private var closeBtn:Button;
		
		public function MissionStatementDawson() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addButton();
			addMissionImage();
			addCloseButton();
			
			var mailLatency:Number = Global.getRandomNumber(5, 10);
			
			var timer:Timer = new Timer(1000, mailLatency);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, showMailNotification);
			timer.start();
		}
		
		private function showMailNotification(e:TimerEvent):void 
		{
			TweenLite.to(mailBtn, 2, { x: 0, ease: Expo.easeInOut } );
			SoundManager.addSound('mail-notification', SoundAssets.notificationSuccessMedium);
		}
		
		private function addButton():void 
		{
			mailBtn = new MailButton();
			mailBtn.x = -mailBtn.width;
			mailBtn.addEventListener(Event.TRIGGERED, showMissionStatement);
			addChild(mailBtn);
		}
		
		private function addMissionImage():void 
		{
			image = new Image(MailAssets.getAtlas().getTexture(MailAssets.MISSION_STATEMENT_DAWSON));
			image.y = Game.STAGE_HEIGHT;
			addChild(image);
		}
		
		private function addCloseButton():void 
		{
			closeBtn = new Button(GameAssets.getTexture("CloseButton"));
            closeBtn.width = 50;
            closeBtn.height = 50;
            closeBtn.x = Game.STAGE_WIDTH - (closeBtn.width + 20);
            closeBtn.y = 20;
            addChild(closeBtn);
			closeBtn.visible = false;
            closeBtn.addEventListener("triggered", closeMissionStatment);
		}
		
		private function showMissionStatement(e:Event):void 
		{
			closeBtn.visible = true;
			TweenLite.to(image, 0.6, { y: 0, ease: Expo.easeInOut } );
		}
		
		private function closeMissionStatment(e:Event):void 
		{
			this.removeFromParent(true);
		}
	}
}
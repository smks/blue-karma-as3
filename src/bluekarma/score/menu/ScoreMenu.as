package bluekarma.score.menu
{
	import adobe.utils.CustomActions;
	import assets.GameAssets;
	import assets.SocialAssets;
	import bluekarma.helpers.transitions.Fader;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import starling.utils.VAlign;
	import utils.TimeFormat;
	
	import bluekarma.gui.phone.health.HealthMenu;
	
	import global.Global;
	
	import starling.display.Quad;
	
	import bluekarma.gui.phone.applications.ApplicationMenu;
	
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	
	import flash.events.TimerEvent;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.Timer;
	
	import gui.phone.contacts.Contact
	import gui.phone.contacts.ContactMenu;
	
	import notifications.reminders.ReminderBox;
	
	import settings.foregrounds.Overlay;
	
	import starling.utils.HAlign;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	
	import assets.InventoryAssets;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import states.GameState;
	import states.Level1State;
	
	import bluekarma.assets.sound.SoundAssets;
	
	import helpers.GameClock;
	
	/**
	 * @author Shaun Stone
	 */
	public class ScoreMenu extends Sprite
	{
		private const INFO_DEVICE_OWNER:String = "device owner";
		private const INFO_CURRENT_RFID:String = "rfid";
		private const INFO_LEADER_RANK:String = "leaderboard rank";
		private const INFO_CONDITION:String = "condition";
		
		static public const ACHIEVEMENTS_STRING:String = "Level Medals Unlocked: ";
		static public const BONUS_ACHIEVEMENTS_STRING:String = "Bonus Medals Unlocked: ";
		
		private var finalScorePoints:uint;
		private var finalTimeTrial:uint;
		private var achievementsList:Array;
		private var achievementsBonusList:Array;
		private var rankLabel:TextField;
		private var achievementsFullString:String;
		private var bonusAchievementsFullString:String;
		//add bg
		protected var mainMenuBg:Image;
		protected var clockTime:Date;
		protected var clockTimer:Timer;
		protected var reminderBox:ReminderBox;
		protected var overlay:Image;
		//add images
		protected var inventoryMainMenuProfilePic:Image;
		//add text
		protected var inventory_text_score:TextField;
		protected var finalScoreLabel:TextField;
		protected var finalScore:TextField;
		protected var finalTimeLabel:TextField;
		protected var finalTime:TextField;
		protected var deviceOwnerLabel:TextField;
		protected var deviceOwner:TextField;
		protected var rfidNoLabel:TextField;
		protected var rfidNo:TextField;
		protected var leaderboardRankLabel:TextField;
		protected var leaderboardRank:TextField;
		protected var conditionLabel:TextField;
		protected var condition:TextField;
		//get clock
		protected var mobileClock:Timer;
		private var rankDecider:Rank;
		private var yt:Button;
		private var twitter:Button;
		private var facebook:Button;
		private var smks:Button;
		
		// @TODO private var bookUrl:URLRequest;
        private var smksUrl:URLRequest = new URLRequest(Global.SMKS_URL);
        private var facebookUrl:URLRequest = new URLRequest(Global.FACEBOOK_URL);
        private var twitterUrl:URLRequest = new URLRequest(Global.TWITTER_URL);
        private var youTubeUrl:URLRequest = new URLRequest(Global.YOUTUBE_URL);
		private var thanksForPlaying:TextField;
		
		public function ScoreMenu(finalScorePoints:uint, finalTimeTrial:uint, achievementsList:Array, achievementsBonusList:Array)
		{
			this.achievementsBonusList = achievementsBonusList;
			this.achievementsList = achievementsList;
			this.finalTimeTrial = finalTimeTrial;
			this.finalScorePoints = finalScorePoints;
			
			achievementsFullString = this.buildAchievementsList(achievementsList, ScoreMenu.ACHIEVEMENTS_STRING, false);
			bonusAchievementsFullString = this.buildAchievementsList(achievementsBonusList, ScoreMenu.BONUS_ACHIEVEMENTS_STRING, true);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			drawMainMenu();
			addOverlay();
			addListeners();
			
			SoundAssets.scoreMenuTheme.play();
		}
		
		private function addListeners():void 
		{
			
		}
		
		protected function addOverlay():void
		{
			// hide by default
			var fader:Fader = new Fader(true);
			addChild(fader);
			
			fader.fadeOut(5, 2);
		}
		
		protected function drawMainMenu():void
		{
			addBackground();
			addBasicInformation();
			addSocialIcons();
			addProfilePic();
			addTimeTrial(); 
			addAchievements();
			addBonusAchievements();
		}
		
		private function addAchievements():void 
		{
			var achievementsListing:TextField = new TextField(200, 400, achievementsFullString, Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_WHITE);
			achievementsListing.hAlign = HAlign.LEFT;
			achievementsListing.vAlign = VAlign.TOP;
			achievementsListing.x = 80;
			achievementsListing.y = 280;
			achievementsListing.border = false;
			addChild(achievementsListing);
		}
		
		private function addBonusAchievements():void 
		{
			var bonusAchievementsListing:TextField = new TextField(200, 400, bonusAchievementsFullString, Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_WHITE);
			bonusAchievementsListing.hAlign = HAlign.LEFT;
			bonusAchievementsListing.vAlign = VAlign.TOP;
			bonusAchievementsListing.x = 740;
			bonusAchievementsListing.y = 280;
			bonusAchievementsListing.border = false;
			addChild(bonusAchievementsListing);
		}
		
		protected function addTimeTrial():void
		{
			finalTimeLabel = new TextField(200, 100, 'TIME', Global.DEFAULT_FONT, 44, Global.BLUE_KARMA_BLUE, true);
			finalTimeLabel.x = 742;
			finalTimeLabel.y = 80;
			finalTimeLabel.border = false;
			addChild(finalTimeLabel);
			
			finalTime = new TextField(200, 100, 
				TimeFormat.formatTime(finalTimeTrial), 
				Global.DEFAULT_FONT, 32, Global.BLUE_KARMA_WHITE, true
			);
			finalTime.x = 742;
			finalTime.y = 140;
			finalTime.border = false;
			addChild(finalTime);
		}
		
		protected function addProfilePic():void
		{
			// @TODO switch case on what protagonist currently
			inventoryMainMenuProfilePic = new Image(InventoryAssets.getAtlas("mainMenu").getTexture("riley"));
			inventoryMainMenuProfilePic.x = 97;
			inventoryMainMenuProfilePic.y = 60;
			addChild(inventoryMainMenuProfilePic);
		}
		
		protected function addBasicInformation():void
		{
			thanksForPlaying = new TextField(300, 100, 'THANKS FOR PLAYING!', Global.DEFAULT_FONT, 22, Global.BLUE_KARMA_WHITE, true);
			thanksForPlaying.x = 360;
			thanksForPlaying.y = 30;
			thanksForPlaying.border = false;
			addChild(thanksForPlaying);
			
			finalScoreLabel = new TextField(300, 100, 'TOTAL SCORE', Global.DEFAULT_FONT, 44, Global.BLUE_KARMA_BLUE, true);
			finalScoreLabel.x = 360;
			finalScoreLabel.y = 80;
			finalScoreLabel.border = false;
			addChild(finalScoreLabel);
			
			finalScore = new TextField(200, 100, String(finalScorePoints), Global.DEFAULT_FONT, 32, Global.BLUE_KARMA_WHITE, true);
			finalScore.x = 420;
			finalScore.y = 140;
			finalScore.border = false;
			addChild(finalScore);
			
			// Rank
			rankLabel = new TextField(150, 100, 'RANK', Global.DEFAULT_FONT, 44, Global.BLUE_KARMA_BLUE, true);
			rankLabel.x = 430;
			rankLabel.y = 300;
			rankLabel.border = false;
			addChild(rankLabel);
			
			// Rank to show
			rankDecider = new Rank(finalScorePoints);
			rankDecider.x = 430;
			rankDecider.y = 415;
			addChild(rankDecider);
		}
		
		private function addSocialIcons():void 
		{
			yt = new Button(SocialAssets.getAtlas().getTexture(SocialAssets.YOUTUBE));
			yt.x = 360;
			yt.y = 640;
			yt.scaleX = 0.5;
			yt.scaleY = 0.5;
			addChild(yt);
			
			twitter = new Button(SocialAssets.getAtlas().getTexture(SocialAssets.TWITTER));
			twitter.scaleX = 0.5;
			twitter.scaleY = 0.5;
			twitter.x = 440;
			twitter.y = 640;
			addChild(twitter);
			
			facebook = new Button(SocialAssets.getAtlas().getTexture(SocialAssets.FACEBOOK));
			facebook.scaleX = 0.5;
			facebook.scaleY = 0.5;
			facebook.x = 520;
			facebook.y = 640;
			addChild(facebook);
			
			smks = new Button(SocialAssets.getAtlas().getTexture(SocialAssets.SMKS));
			smks.scaleX = 0.5;
			smks.scaleY = 0.5;
			smks.x = 600;
			smks.y = 640;
			addChild(smks);
			
			//get_book.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            smks.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            facebook.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            twitter.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            yt.addEventListener(Event.TRIGGERED, navigateToExternalLink);
		}
		
		protected function addBackground():void
		{
			mainMenuBg = new Image(InventoryAssets.getAtlas("mainMenu").getTexture("background"));
			addChild(mainMenuBg);
		}
		
		private function buildAchievementsList(list:Array, title:String, bonus:Boolean):String 
		{
			title = title.toUpperCase();
			
			var str:String = title + '\n\n' ;
			var len:uint = list.length;
			
			if (len === 0) {
				return str += 'No Medals Achieved';
			}
			
			for (var i:uint = 1; i <= len; i++) {
				var itr:String = String(i + ') ');
				str += itr += list[i - 1] += '\n';
			}
			
			return str;
		}
		
		private function navigateToExternalLink(e:Event):void
        {
            if (smks.contains(e.currentTarget as Button)) {
                navigateToURL(smksUrl, "_blank");
            } else if (facebook.contains(e.currentTarget as Button)) {
                navigateToURL(facebookUrl, "_blank");
            } else if (twitter.contains(e.currentTarget as Button)) {
                navigateToURL(twitterUrl, "_blank");
            } else if (yt.contains(e.currentTarget as Button)) {
                navigateToURL(youTubeUrl, "_blank");
            }
        }
	}
}
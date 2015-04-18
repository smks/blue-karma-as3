package gui.inventory.abstract
{
    import assets.GameAssets;

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
    public class AbstractPhoneMenu extends Sprite
    {
        private const INFO_DEVICE_OWNER:String = "device owner";
        private const INFO_CURRENT_RFID:String = "rfid";
        private const INFO_LEADER_RANK:String = "leaderboard rank";
        private const INFO_CONDITION:String = "condition";
        //add bg
        protected var mainMenuBg:Image;
        protected var clockTime:Date;
        protected var contactMenu:ContactMenu;
        protected var clockTimer:Timer;
        protected var appsMenu:ApplicationMenu;
        protected var healthMenu:HealthMenu;
        protected var reminderBox:ReminderBox;
        protected var overlay:Image;
        //add buttons
        protected var inventoryIconApps:Button;
        protected var inventoryIconCall:Button;
        protected var inventoryIconExit:Button;
        protected var inventoryIconHealth:Button;
        //add images
        protected var inventoryMainMenuProfilePic:Image;
        //add text
        protected var inventory_text_score:TextField;
        protected var inventoryMainMenuLevelTitle:TextField;
        protected var inventory_mainmenu_notifications_text:TextField;
        protected var inventoryMainMenuTime:TextField;
        protected var inventoryMainmenuDate:TextField;
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
        protected var params:Object;

        public function AbstractPhoneMenu(_params:Object)
        {
            params = _params;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function getClockTime():String
        {
            var timeFormat:DateTimeFormatter = new DateTimeFormatter("en-UK");
            timeFormat.setDateTimePattern("HH:mm:ss");
            return String(timeFormat.format(params.date));
        }

        public function getCurrentTimeOnAct():Date
        {
            return params.date;
        }

        public function getActTimeDeadline():Date
        {
            return params.deadlineDate;
        }

        public function getClockDate():String
        {
            var timeFormat:DateTimeFormatter = new DateTimeFormatter("en-UK");
            timeFormat.setDateTimePattern("dd/MM/yyyy");
            return String(timeFormat.format(params.date));
        }

        protected function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawMainMenu();
            drawHealthStatusMenu(params);
            addOverlay();
            drawContactsMenu();
            drawAppsMenu();
            addListeners();
        }

        protected function addOverlay():void
        {
            // hide by default
            overlay = new Image(GameAssets.getTexture("Overlay50"));
            overlay.visible = false;
            addChild(overlay);
        }

        protected function drawContactsMenu(debug:Boolean = false):void
        {
            contactMenu = new ContactMenu(null, debug);
            contactMenu.x = Game.STAGE_WIDTH;
            addChild(contactMenu);
        }

        protected function drawAppsMenu():void
        {
            appsMenu = new ApplicationMenu(null, false);
            appsMenu.x = -400;
            addChild(appsMenu);
        }

        protected function drawHealthStatusMenu(_params:Object):void
        {
            healthMenu = new HealthMenu(_params);
            healthMenu.x = 320;
            healthMenu.y = 280;
            healthMenu.visible = false;
            addChild(healthMenu);
        }

        protected function addListeners():void
        {
            //add touch listener
            inventoryIconApps.addEventListener(Event.TRIGGERED, goToAppsScreen);
            inventoryIconCall.addEventListener(Event.TRIGGERED, goToCallScreen);
            inventoryIconExit.addEventListener(Event.TRIGGERED, exitMenu);
            inventoryIconHealth.addEventListener(Event.TRIGGERED, showHealthMenu);
            addEventListener("closingSubMenu", closedContacts);
        }

        protected function closedContacts(e:Event):void
        {
            overlay.visible = false;
        }

        protected function drawMainMenu():void
        {
            addBackground();
            addIcons();
            addBasicInformation();
            addProfilePic();
            addDateAndTime();
            addReminders();
        }

        protected function addDateAndTime():void
        {
            inventoryMainMenuTime = new TextField(200, 100, this.getClockTime(), "Harvest", 44, Global.BLUE_KARMA_WHITE, true);
            inventoryMainMenuTime.x = 742;
            inventoryMainMenuTime.y = 80;
            addChild(inventoryMainMenuTime);
            inventoryMainmenuDate = new TextField(200, 100, this.getClockDate(), Global.DEFAULT_FONT, 22, Global.BLUE_KARMA_WHITE, true);
            inventoryMainmenuDate.x = 742;
            inventoryMainmenuDate.y = 120;
            addChild(inventoryMainmenuDate);
            mobileClock = new Timer(1000, 0);
            mobileClock.addEventListener(TimerEvent.TIMER, updateMobileClock);
            mobileClock.start();
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
            inventoryMainMenuLevelTitle = new TextField(350, 60, String(params.act).toUpperCase(), Global.DEFAULT_FONT, 18, Global.BLUE_KARMA_WHITE, true);
            inventoryMainMenuLevelTitle.hAlign = HAlign.LEFT;
            inventoryMainMenuLevelTitle.x = 335;
            inventoryMainMenuLevelTitle.y = 40;
            inventoryMainMenuLevelTitle.border = false;
            addChild(inventoryMainMenuLevelTitle);
            addBasicInformationLabels();
            addBasicInformationValues();
        }

        protected function addBackground():void
        {
            mainMenuBg = new Image(InventoryAssets.getAtlas("mainMenu").getTexture("background"));
            addChild(mainMenuBg);
        }

        protected function addIcons():void
        {
            //add buttons to stage
            inventoryIconApps = new Button(InventoryAssets.getAtlas("mainMenu").getTexture("apps"));
            inventoryIconApps.x = 80;
            inventoryIconApps.y = 280;
            addChild(inventoryIconApps);
            inventoryIconCall = new Button(InventoryAssets.getAtlas("mainMenu").getTexture("phone"));
            inventoryIconCall.x = 740;
            inventoryIconCall.y = 280;
            addChild(inventoryIconCall);
            inventoryIconExit = new Button(InventoryAssets.getAtlas("mainMenu").getTexture("exit"));
            inventoryIconExit.x = 740;
            inventoryIconExit.y = 520;
            addChild(inventoryIconExit);
            inventoryIconHealth = new Button(InventoryAssets.getAtlas("mainMenu").getTexture("health"));
            inventoryIconHealth.x = 80;
            inventoryIconHealth.y = 520;
            addChild(inventoryIconHealth);
        }

        /**
         * example use:
         * reminderBox.addReminder("reminder1", "message", "critical");
         * reminderBox.addReminder("reminder2", "message", "high");
         * reminderBox.addReminder("reminder3", "message", "fine");
         */
        protected function addReminders():void
        {
            reminderBox = new ReminderBox();
            reminderBox.x = 320;
            reminderBox.y = 280;
            addChild(reminderBox);
        }

        /**
         * this will update real time
         * @param    e
         */
        protected function updateMobileClock(e:TimerEvent):void
        {
            var seconds:uint = params.date.getSeconds();
            params.date.setSeconds(seconds + 1);
            inventoryMainMenuTime.text = this.getClockTime();
            var updateHealthStats:Boolean = Boolean(seconds % 5 === 0);
            if (healthMenu !== null && updateHealthStats) {
                healthMenu.updateHealthStats();
            }
        }

        protected function showHealthMenu(e:Event):void
        {
            SoundAssets.buttonBeep1.play();
            if (healthMenu.visible === true) {
                healthMenu.visible = false;
            } else {
                healthMenu.visible = true;
            }
        }

        protected function exitMenu(e:Event):void
        {
            //SoundAssets.buttonBeep3.play();
            TweenLite.to(this, 0.6, {y: Game.STAGE_HEIGHT, ease: Expo.easeInOut});
        }

        protected function goToCallScreen(e:Event):void
        {
            overlay.visible = true;
            SoundAssets.buttonBeep1.play();
            var xPos:uint = Game.STAGE_WIDTH - contactMenu.width;
            TweenLite.to(contactMenu, 0.6, {x: xPos, ease: Expo.easeInOut});
        }

        protected function goToAppsScreen(e:Event):void
        {
            overlay.visible = true;
            SoundAssets.buttonBeep1.play();
            TweenLite.to(appsMenu, 0.6, {x: 0, ease: Expo.easeInOut});
        }

        private function addBasicInformationLabels():void
        {
            deviceOwnerLabel = new TextField(170, 40, INFO_DEVICE_OWNER.toUpperCase(), Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_BLUE, true);
            deviceOwnerLabel.hAlign = HAlign.LEFT;
            //deviceOwnerLabel.border = true;
            deviceOwnerLabel.x = 338;
            deviceOwnerLabel.y = 95;
            addChild(deviceOwnerLabel);
            rfidNoLabel = new TextField(140, 40, INFO_CURRENT_RFID.toUpperCase(), Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_BLUE, true);
            //rfidNoLabel.border = true;
            rfidNoLabel.hAlign = HAlign.RIGHT;
            rfidNoLabel.x = 540;
            rfidNoLabel.y = 95;
            addChild(rfidNoLabel);
            leaderboardRankLabel = new TextField(200, 40, INFO_LEADER_RANK.toUpperCase(), Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_BLUE, true);
            //leaderboardRankLabel.border = true;
            leaderboardRankLabel.hAlign = HAlign.LEFT;
            leaderboardRankLabel.x = 338;
            leaderboardRankLabel.y = 165;
            addChild(leaderboardRankLabel);
            conditionLabel = new TextField(120, 40, INFO_CONDITION.toUpperCase(), Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_BLUE, true);
            //conditionLabel.border = true;
            conditionLabel.hAlign = HAlign.RIGHT;
            conditionLabel.x = 560;
            conditionLabel.y = 165;
            addChild(conditionLabel);
        }

        private function addBasicInformationValues():void
        {
            deviceOwner = new TextField(180, 30, String(params.deviceOwner).toUpperCase(), Global.DEFAULT_FONT, 16, Global.BLUE_KARMA_LIGHT_GREY, false);
            //deviceOwner.border = true;
            deviceOwner.hAlign = HAlign.LEFT;
            deviceOwner.x = 338;
            deviceOwner.y = 130;
            addChild(deviceOwner);
            rfidNo = new TextField(150, 30, String(params.rfidNo).toUpperCase(), Global.DEFAULT_FONT, 14, Global.BLUE_KARMA_LIGHT_GREY, false);
            //rfidNo.border = true;
            rfidNo.hAlign = HAlign.RIGHT;
            rfidNo.x = 530;
            rfidNo.y = 130;
            addChild(rfidNo);
            leaderboardRank = new TextField(120, 30, String(params.leaderboardRank).toUpperCase(), Global.DEFAULT_FONT, 18, Global.BLUE_KARMA_LIGHT_GREY, false);
            leaderboardRank.hAlign = HAlign.LEFT;
            leaderboardRank.x = 338;
            leaderboardRank.y = 200;
            addChild(leaderboardRank);
            condition = new TextField(120, 30, String(params.condition).toUpperCase(), Global.DEFAULT_FONT, 18, Global.BLUE_KARMA_LIGHT_GREY, false);
            condition.hAlign = HAlign.RIGHT;
            condition.x = 560;
            condition.y = 200;
            addChild(condition);
        }
    }
}
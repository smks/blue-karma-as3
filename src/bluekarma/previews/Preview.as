/**
 * @author Shaun Stone
 *
 * Previews are used to test any sort of functionality before placing it
 * in game.
 */
package bluekarma.previews
{
    import adobe.utils.CustomActions;
	import apis.ThirdPartyAPI;
	import bluekarma.dialogue.character.slumsstreet.riley_roger.RileyRoger;
	import bluekarma.score.menu.ScoreMenu;
	import notifications.mail.missions.MissionStatementDawson;
	import sound.SoundManager;
	import starling.core.Starling;
	import starling.display.Image;

    import bluekarma.interactive.compound.RileyCable;

    import components.gestures.balancer.BalancerBar;

    import dialogue.character.compound.RileyDawson;
    import dialogue.phone.conversations.RileyAlbertOne;

    import score.LevelOneScore;

    import bluekarma.dialogue.character.slumsstreet.riley_rupert.RileyRupert;
    import bluekarma.interactive.compound.characters.Dawson;
    import bluekarma.interactive.compound.items.MaskingTape;
    import bluekarma.interactive.general.items.LockPick;
    import bluekarma.settings.backgrounds.BackgroundCompound;

    import interactive.apartment.items.DogFood;

    import starling.filters.BlurFilter;

    import assets.CompoundAssets;

    import dialogue.character.compound.DawsonBodyguards;

    import levels.level1.Level1;
    import levels.level1.part5.Compound;

    import apis.newgrounds.Newgrounds;

    import assets.PhoneDialogueAssets;
    import assets.PlaqueAssets;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.components.gestures.hold.Hold;
    import bluekarma.gui.phone.applications.Application;
    import bluekarma.gui.phone.applications.ApplicationMenu;
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.InteractionRepoFactory;
    import bluekarma.interactive.base.Item;
    import bluekarma.levels.abstract.AbstractSlumsStreet;

    import assets.GameAssets;
    import assets.ItemAssets;

    import bluekarma.settings.backgrounds.albertscar.movingbg.MovingBackgroundSlums;

    import com.greensock.TweenLite;

    import components.gestures.swipes.Swipe;

    import dialogue.character.albertscar.AlbertRileyDialogue;
    import dialogue.character.slumsstreet.riley_bodyguards.RileyBodyguards;
    import dialogue.phone.conversations.RileyTyroneOne;
    import dialogue.subjects.AbstractSubject;

    import flash.events.TimerEvent;
    import flash.media.Sound;
    import flash.utils.Timer;

    import global.Global;

    import gui.inventory.phonemenu.ActParams;

    import helpers.arrows.Arrow;
    import helpers.messages.MessageBox;
    import helpers.transitions.ActIntroduction;

    import interactive.apartment.items.Pyjamas;
    import interactive.apartment.items.WorkClothing;
    import interactive.apartment.props.kitchen.KitchenSink;
    import interactive.apartment.repos.ApartmentInteractionRepo;

    import bluekarma.interactive.base.InteractionRepo;

    import gui.inventory.Inventory;

    import interactive.backalley.props.Fan;
    import interactive.backalley.props.FanPanel;
    import interactive.backalley.props.Toolbox;
    import interactive.slumsstreet.props.FuseBox;

    import levels.base.RileysApartment;
    import levels.level1.part1.RileysApartmentIntro;
    import levels.level1.part2.RileysJourneyAlbert;
    import levels.level1.part3.SlumsStreet;
    import levels.level1.part4.BackAlley;

    import messages.Message;

    import navigation.PositionArrow;

    import notifications.achievement.Achievement;
    import notifications.modal.Modal;

    import players.riley.RileyAsleep;
    import players.riley.RileyOnLadder;
    import players.riley.RileyPyjamas;

    import screens.WelcomeMenu;

    import settings.backgrounds.apartment.cityview.CityView;
    import settings.backgrounds.BackgroundBackAlley;
    import settings.backgrounds.BackgroundRileysApartment;
    import settings.backgrounds.BackgroundSlumsStreet;
    import settings.foregrounds.slums_street.ForegroundSlumsStreet;

    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;

    import players.AbstractPlayer;

    import dialogue.phone.repositories.RileryTyroneApartmentRepository

    /**
     * ...
     * @author Shaun Stone
     */
    public class Preview extends Sprite
    {
        protected var _achievement:Achievement;
        protected var _inventory:Inventory;
        protected var _i:int = 0;
        //protected var _repo:RileryTyroneApartmentRepository;
        protected var mvslums:MovingBackgroundSlums
        private var counter:uint;
        private var view:CityView;
        private var _phoneConvoRileyUncle:RileyTyroneOne;
        private var balancerGame:BalancerBar;
        private var ls:LevelOneScore;
		private var api:ThirdPartyAPI;
		
		/**
		 * API Plugins
		 */
		private var ng:Newgrounds;

        public function Preview()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, added);
			
			ng = new Newgrounds();
			api = new ThirdPartyAPI(ng, Starling.current.nativeStage);
			ls = new LevelOneScore(api);
        }

        private function added(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, added);
            //addTest();
            //addTest2();
            //addItemTest();
            //addBackgroundApartmentTest();
            //addInventoryTest();
            //addApp();
            //addMovingBGSlums();
            //addConvo();
            //addNormalConvo();
            //addActIntro();
            //addWelcomeMenu();
            //addAlbertJourney();
            //addSlums();
            //addBackAlley();
            //addFan();
            //addBackAlleyBg();
            //addModal();
            //addToolbox();
            //addFanPanel();
            //addRileyLadder();
            //addFuseBox();
            //addRileyTyroneConvo();
            //addCharacterConvo();
            //addRileyAsleep();
            //addSlumsBg();
            //addRileyIntroApartment();
            //addArrowPointer();
            //addSlider();
            //addEventListener("messageListener", messageHandler);
            //addCityView();
            //addCompound();
            //playSoundTest();
            //addInventoryItems();
            //addDawson();
            //addRileyAlbert2();
            //addRileyDawson();
            //addRileyCable();
            //addBalancer();
            //addLevelScore();
			//apis();
			//addScoreMenu();
			//addSoundManager();
			//addContactMenu();
			addLevel1();
			//addConvo();
			//addMissionStatement();
        }
		
        private function addLevel1():void
        {
            var level1:Level1 = new Level1();
			addChild(level1);
            level1.finishedAct(Level1.ACT_3);
        }
		
		private function addMissionStatement():void 
		{
			var ms:MissionStatementDawson = new MissionStatementDawson();
			addChild(ms);
		}
		
		private function addContactMenu():void 
		{
			var button:Button = new Button(GameAssets.getTexture("ArrowGameButtonDown"));
            button.x = 100;
            button.y = 400;
            addChild(button);
            button.addEventListener("triggered", click);
            _inventory = new Inventory();
            addChild(_inventory);
            _inventory.openMenu();
            //add phone menu and params
            var actParams:ActParams = new ActParams();
            // this will fetch necessary params for this act (1)
            var params:Object = actParams.getLevelOneActOneParams();
            // pass these params into phone menu to enable it
            _inventory.addMobileDashboard(params);
            _inventory.setECGState(_inventory.STATE_FINE);
            _inventory.addReminder("a", "go shopping", "fine");
			_inventory.addContact("albert", 'Albert Green', true);
			_inventory.addContact("albert2", 'Tyrone Marshall', false);
		}
		
		private function addSoundManager():void 
		{
			var sound:Sound = SoundAssets.apartmentIntroBegin;
			
			SoundManager.addSound("bedroom-chest", sound, 2, 1);
			
			var timer:Timer = new Timer(1000, 10);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerE);
			timer.start();
			
			function timerE(e:TimerEvent):void 
			{
				SoundManager.fadeOutAndRemove("bedroom-chest");
			}
		}
		
		private function addScoreMenu():void 
		{
			var sm:ScoreMenu = new ScoreMenu(
				12000,
				345,
				new Array(
					'Break In',
					'Collect Enforcement Gear',
					'Find Compound',
					'Find Suit',
					'Pyjama Wash',
					'Responsible Owner',
					'Another Way',
					'Tradesmen Toolbox',
					'We Have Noise',
					'Arrest Dawson',
					'Hide and Seek'
				),
				new Array(
					'Bonus - Bedroom Maintainer',
					'Bonus - City Admirer',
					'Bonus - Water Plants',
					'Bonus - Workout',
					'Bonus - Cable Balancer',
					'Bonus - Full Vetter',
					'Bonus - Mans Best Friend',
					'Bonus - No Notifications Apartment',
					'Bonus - House Checker',
					'Bonus - Save Water Bills',
					'Bonus - Slums Notifications',
					'Bonus - Street Check',
					'Bonus - Who\'s the Driver'
				)
			);
			
			addChild(sm);
		}
		
		private function apis():void 
		{
			api.postScore(100);
		}

        private function addLevelScore():void
        {
            /**
             * ACT 1 TEST
             *
            ls.getAct1().addToScore(ls.getAct1().FIND_SUIT_SENTENCE, ls.getAct1().FIND_SUIT);
            ls.getAct1().addToScore(ls.getAct1().PYJAMA_WASH_SENTENCE, ls.getAct1().PYJAMA_WASH);
            ls.getAct1().addToScore(ls.getAct1().RESPONSIBLE_OWNER_SENTENCE, ls.getAct1().RESPONSIBLE_OWNER);
            /**
             * ACT 2 TEST
             *
            ls.getAct2().addToScore(ls.getAct2()
                            .COLLECT_ENFORCEMENT_GEAR_SENTENCE,
                    ls.getAct2().COLLECT_ENFORCEMENT_GEAR
            );
            /**
             * ACT 3 TEST
             *
            ls.getAct3().addToScore(ls.getAct3().FIND_COMPOUND_SENTENCE,
                    ls.getAct3().FIND_COMPOUND
            );
            ls.getAct3().addToScore(ls.getAct3().ANOTHER_WAY_SENTENCE,
                    ls.getAct3().ANOTHER_WAY
            );
            /**
             * ACT 4 TEST
             *
            ls.getAct4().addToScore(ls.getAct4().TRADESMEN_TOOLBOX_SENTENCE,
                    ls.getAct4().TRADESMEN_TOOLBOX
            );
            ls.getAct4().addToScore(ls.getAct4().WE_HAVE_NOISE_SENTENCE,
                    ls.getAct4().WE_HAVE_NOISE
            );
            ls.getAct4().addToScore(ls.getAct4().BREAK_IN_SENTENCE,
                    ls.getAct4().BREAK_IN
            );
            /**
             * ACT 5 TEST
             *
            ls.getAct5().addToScore(ls.getAct5().ARREST_DAWSON_SENTENCE,
                    ls.getAct5().ARREST_DAWSON
            );
            ls.getTotalScore();
            ls.getMainAchievements();
            ls.getBonusAchievements();
            trace(ls);
			
			*/
        }

        private function addBalancer():void
        {
            var obj:Object = new Object();
            obj.rileyCable = new RileyCable();
            addChild(obj.rileyCable);
            obj.rileyCable.y = 400;
            balancerGame = new BalancerBar(obj);
            balancerGame.pivotX = balancerGame.width / 2;
            balancerGame.pivotY = balancerGame.height / 2;
            balancerGame.scaleX = -1;
            balancerGame.x = 560;
            balancerGame.y = 170;
            addChild(balancerGame);
            balancerGame.startTimingMiniGame();
            //addEventListener("balancerResolution", dealWithBalancerResolution);
        }

        private function addRileyCable():void
        {
            var compoundBg:BackgroundCompound = new BackgroundCompound();
            addChild(compoundBg);
            var rc:RileyCable = new RileyCable();
            rc.x = 75;
            rc.y = 410;
            addChild(rc);
            var gs:Swipe = new Swipe();
            gs.scaleX = 1.5;
            gs.scaleY = 1.5;
            gs.x = 100;
            gs.y = 300;
            addChild(gs);
        }

        private function addRileyDawson():void
        {
            var rd:RileyDawson = new RileyDawson();
            addChild(rd);
        }

        private function addRileyAlbert2():void
        {
            var rileyAlbertPickup:RileyAlbertOne = new RileyAlbertOne();
            rileyAlbertPickup.scaleX = 0.5;
            rileyAlbertPickup.scaleY = 0.5;
            rileyAlbertPickup.x = (Game.STAGE_WIDTH / 2);
            rileyAlbertPickup.y = Game.STAGE_HEIGHT;
            addChild(rileyAlbertPickup);
            TweenLite.to(rileyAlbertPickup, 0.5, {x: 0, y: 0, scaleX: 1, scaleY: 1});
            var timeToAnswerPhone:Timer = new Timer(2000, 1);
            timeToAnswerPhone.addEventListener(TimerEvent.TIMER_COMPLETE, onDelayAnswer);
            timeToAnswerPhone.start();
            // play ringing sound
            SoundAssets.callingSomeone.play();
            function onDelayAnswer(e:TimerEvent):void
            {
                rileyAlbertPickup.phoneAnsweredByReceiver();
            }
        }

        private function addDawson():void
        {
            var compoundBg:BackgroundCompound = new BackgroundCompound();
            addChild(compoundBg);
            var dawson:Dawson = new Dawson("dawson", false, true);
            dawson.x = 232;
            dawson.y = 490;
            //dawson.filter = BlurFilter.createGlow(0xFFCC00,5,5,0.1);
            dawson.filter = BlurFilter.createGlow(Global.BLUE_KARMA_GLOW_YELLOW, 1, 4, 2);
            dawson.cuffDawson();
            addChild(dawson);
        }

        private function addConvo():void
        {
            //var db:DawsonBodyguards = new DawsonBodyguards();
            //var db:RileyBodyguards = new RileyBodyguards();
            //var db:AlbertRileyDialogue = new AlbertRileyDialogue(AlbertRileyDialogue.CONVO_1);
			var db:RileyDawson = new RileyDawson();
			//var db:RileyTyroneOne = new RileyTyroneOne();
			//var db:RileyRupert = new RileyRupert();
			addChild(db);
        }

        private function playSoundTest():void
        {
            trace("playing sound");
            SoundAssets.walkToDoorAndOpen.play();
        }

        private function addCompound():void
        {
            //var c:Compound = new Compound(ls.getAct5());
            var c:BackgroundCompound = new BackgroundCompound();
			addChild(c);
			
			var i:Image = new Image(CompoundAssets.getAtlas().getTexture("jake-looking-out"));
			i.x = 26;
			i.y = 390;
			addChild(i);
        }

        private function addFan():void
        {
            var f:Fan = new Fan("fan", true);
            f.spin();
            var timer:Timer = new Timer(1000, 3);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, reach);
            timer.start();
            function reach(e:TimerEvent):void
            {
            }
        }

        private function addBackAlleyBg():void
        {
            var bab:BackgroundBackAlley = new BackgroundBackAlley(1);
            addChild(bab);
            bab.testToolBoxItemPlacements();
        }

        private function addModal():void
        {
            var m:Modal = new Modal("HINT: Look for the nearest house that meets the description", 2, 2, 1);
            addChild(m);
        }

        private function addToolbox():void
        {
            var tb:Toolbox = new Toolbox("as", true);
            addChild(tb);
            var timer:Timer = new Timer(3000, 10);
            timer.addEventListener(TimerEvent.TIMER, reach);
            timer.start();
            function reach(e:TimerEvent):void
            {
                trace("called");
                trace(tb.isOpen());
                if (tb.isOpen()) {
                    tb.close();
                } else {
                    tb.open();
                }
            }
        }

        private function addFanPanel():void
        {
            var fp:FanPanel = new FanPanel("fan-panel", true);
            fp.x = 200;
            fp.y = 200;
            addChild(fp);
            var timer:Timer = new Timer(3000, 6);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, reach);
            timer.start();
            function reach(e:TimerEvent):void
            {
                fp.unlock();
                if (fp.isUnlocked()) {
                    var timer2:Timer = new Timer(1000, 6);
                    timer2.addEventListener(TimerEvent.TIMER_COMPLETE, reach2);
                    timer2.start();
                }
            }

            function reach2(e:TimerEvent):void
            {
                fp.switchOn();
            }
        }

        private function addRileyLadder():void
        {
            var rl:RileyOnLadder = new RileyOnLadder('riley_ladder', true);
            rl.x = 200;
            rl.y = 200;
            addChild(rl);
            var timer:Timer = new Timer(1000, 6);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, reach);
            timer.start();
            function reach(e:TimerEvent):void
            {
                rl.changeDirection("right");
            }
        }

        private function addBackAlley():void
        {
            //var b_a:BackAlley = new BackAlley();
            //addChild(b_a);
        }

        private function addFuseBox():void
        {
            var fb:FuseBox = new FuseBox("box", true);
            fb.x = 200;
            fb.y = 200;
            addChild(fb);
            var t:Timer = new Timer(1000, 30);
            t.addEventListener(TimerEvent.TIMER, tick);
            t.start();
            function tick(e:TimerEvent):void
            {
                if (fb.isOpen()) {
                    if (fb.isLightsOn()) {
                        fb.turnOff();
                    } else {
                        fb.turnOn();
                    }
                } else {
                    fb.openBox();
                }
            }
        }

        private function addCharacterConvo():void
        {
            var ad:DawsonBodyguards = new DawsonBodyguards();
            addChild(ad);
        }

        private function addRileyTyroneConvo():void
        {
            _phoneConvoRileyUncle = new RileyTyroneOne();
            _phoneConvoRileyUncle.scaleX = 0.5;
            _phoneConvoRileyUncle.scaleY = 0.5;
            _phoneConvoRileyUncle.x = (Game.STAGE_WIDTH / 2);
            _phoneConvoRileyUncle.y = Game.STAGE_HEIGHT;
            addChild(_phoneConvoRileyUncle);
            _phoneConvoRileyUncle.setMessageStartPosition(1);
            TweenLite.to(_phoneConvoRileyUncle, 0.5, {x: 0, y: 0, scaleX: 1, scaleY: 1});
        }

        private function addCityView():void
        {
            view = new CityView(true);
            view.x = 350;
            view.y = 200;
            addChild(view);
        }

        private function addSlider():void
        {
            var s:Swipe = new Swipe(Global.RIGHT);
            s.x = 200;
            s.y = 200;
            addChild(s);
            s = new Swipe(Global.LEFT);
            s.x = 300;
            s.y = 300;
            addChild(s);
            var h:Hold = new Hold(4);
            h.x = 400;
            h.y = 400;
            addChild(h);
            h = new Hold(2);
            h.x = 500;
            h.y = 500;
            addChild(h);
        }

        private function addArrowPointer():void
        {
            var a:Arrow = new Arrow(Arrow.UP);
            a.x = 300;
            a.y = 300;
            addChild(a);
            a = new Arrow(Arrow.DOWN);
            a.x = 300;
            a.y = 600;
            addChild(a);
            a = new Arrow(Arrow.LEFT);
            a.x = 200;
            a.y = 300;
            addChild(a);
            a = new Arrow(Arrow.RIGHT);
            a.x = 600;
            addChild(a);
        }

        private function addRileyAsleep():void
        {
            var rs:RileyAsleep = new RileyAsleep("as", true);
            rs.x = 300;
            rs.y = 300;
            addChild(rs);
            rs.wakeUpRiley();
            var timer:Timer = new Timer(1000, 2);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, reach);
            timer.start();
            function reach(e:TimerEvent):void
            {
                rs.makeRileyReachForPhone();
            }
        }

        private function addSlumsBg():void
        {
            var sb:BackgroundSlumsStreet = new BackgroundSlumsStreet(1);
            addChild(sb);
        }

        private function addApp():void
        {
            var appMenu:ApplicationMenu = new ApplicationMenu(null, true);
            addChild(appMenu);
            //appMenu.addApp(Application.CAMERA, true);
            /*
             var app:Application = new Application(Application.BANKING, true);
             addChild(app);

             var app:Application = new Application(Application.CAMERA, true);
             app.y = 140;
             addChild(app);

             var app:Application = new Application(Application.MICROPHONE, true);
             app.y = 280;
             addChild(app);
             */
        }

        private function addRileyIntroApartment():void
        {
            var ra:RileysApartmentIntro = new RileysApartmentIntro(ls.getAct1());
            addChild(ra);
            //ra.setBackgroundAndForegroundTest(2);
        }

        private function addAlbertJourney():void
        {
            var aj:RileysJourneyAlbert = new RileysJourneyAlbert(ls.getAct2());
            addChild(aj);
        }

        private function addWelcomeMenu():void
        {
            var welcome:WelcomeMenu = new WelcomeMenu();
            addChild(welcome);
        }

        private function addSlums():void
        {
            var slums:SlumsStreet = new SlumsStreet(ls.getAct3());
            addChild(slums);
        }

        private function addActIntro():void
        {
            var ai:ActIntroduction = new ActIntroduction("Level 1", "Act 1", "The Slums", 2, 2, 4);
            ai.x = 312;
            ai.y = 354;
            addChild(ai);
        }

        private function addNormalConvo():void
        {
            var ra:AlbertRileyDialogue = new AlbertRileyDialogue(AlbertRileyDialogue.CONVO_1);
            addChild(ra);
        }

        private function addMovingBGSlums():void
        {
            mvslums = new MovingBackgroundSlums(30, true);
            addChild(mvslums);
            if (button == null) {
                var button:Button = new Button(GameAssets.getTexture("ArrowGameButtonDown"));
                button.x = 500;
                button.y = 400;
                addChild(button);
                button.addEventListener("triggered", movingBgClick);
            }
        }

        private function movingBgClick(e:Event):void
        {
            removeChild(mvslums);
            addMovingBGSlums();
        }

        private function addInventoryItems():void
        {
            var dogFood:DogFood = new DogFood('dog_food', true);
            dogFood.x = 100;
            dogFood.y = 400;
            addChild(dogFood);
            var lockpick:LockPick = new LockPick('lockpick', true);
            lockpick.x = 100;
            lockpick.y = 400;
            addChild(lockpick);
            var mt:MaskingTape = new MaskingTape('masking-tape', true);
            mt.x = 100;
            mt.y = 400;
            addChild(mt);
            var wc:WorkClothing = new WorkClothing('work-clothing', true);
            wc.x = 100;
            wc.y = 400;
            addChild(wc);
            _inventory = new Inventory();
            addChild(_inventory);
            _inventory.addItem(dogFood);
            _inventory.addItem(lockpick);
            _inventory.addItem(mt);
            _inventory.addItem(wc);
            var button:Button = new Button(GameAssets.getTexture("ArrowGameButtonDown"));
            button.x = 300;
            button.y = 500;
            addChild(button);
            button.addEventListener("triggered", clickRemoveInventoryItem);
        }

        private function clickRemoveInventoryItem(e:Event):void
        {
            if (_inventory.countItems() === 4) {
                trace("3 items");
                _inventory.removeItem("work-clothing");
                return;
            }
            if (_inventory.countItems() === 3) {
                trace("3 items");
                _inventory.removeItem("dog_food");
                return;
            }
            if (_inventory.countItems() === 2) {
                trace("2 items");
                _inventory.removeItem("lockpick");
                return;
            }
            if (_inventory.countItems() === 1) {
                trace("1 item");
                _inventory.removeItem("masking-tape");
                return;
            }
        }

        private function addInventoryTest():void
        {
            var button:Button = new Button(GameAssets.getTexture("ArrowGameButtonDown"));
            button.x = 100;
            button.y = 400;
            addChild(button);
            button.addEventListener("triggered", click);
            _inventory = new Inventory();
            addChild(_inventory);
            _inventory.openMenu();
            //add phone menu and params
            var actParams:ActParams = new ActParams();
            // this will fetch necessary params for this act (1)
            var params:Object = actParams.getLevelOneActOneParams();
            // pass these params into phone menu to enable it
            _inventory.addMobileDashboard(params);
            _inventory.setECGState(_inventory.STATE_FINE);
            _inventory.addReminder("a", "go shopping", "fine");
        }

        private function click(e:Event):void
        {
            if (_i == 0) {
                _inventory.setECGState(_inventory.STATE_WORRIED);
            } else if (_i == 1) {
                _inventory.setECGState(_inventory.STATE_TERRIFIED);
            } else if (_i == 2) {
                _inventory.setECGState(_inventory.STATE_FINE);
                _i = -1;
            }
            _i++;
        }

        private function addBackgroundApartmentTest():void
        {
            var bg:BackgroundRileysApartment = new BackgroundRileysApartment(2);
            addChild(bg);
            bg.openAllCupboards();
        }

        private function addItemTest():void
        {
            var tap:KitchenSink = new KitchenSink("sink", true);
            tap.x = 100;
            tap.y = 100;
            addChild(tap);
        }

        private function messageHandler(e:Event):void
        {
            trace("in message handler");
            var message:Array = e.data.messages;
            trace(message);
            var _message:Message = new Message(message);
            parent.addChild(_message);
        }

        private function addTest():void
        {
            /*
             _achievement = new Achievement(200, "You have won", 1.5);
             addChild(_achievement);
             */
            /**
             var bg:BackgroundRileysApartment = new BackgroundRileysApartment(3);
             addChild(bg);

             _player = new RileyPyjamas(12);
             _player.x = 680;
             _player.y = 400;
             addChild(_player);
             */

            _inventory = new Inventory();
            addChild(_inventory);
            _inventory.openMenu();
            var _item:WorkClothing = new WorkClothing("work_clothing", true);
            var _item2:Pyjamas = new Pyjamas("pyjamas", true);
            _item.setInInventory(true);
            _item2.setInInventory(true);
            _inventory.addItem(_item);
            _inventory.addItem(_item2);
            trace(_inventory.countItems());
            var button:Button = new Button(GameAssets.getTexture("arrowGameButtonDown"));
            button.x = 100;
            button.y = 400;
            addChild(button);
            button.addEventListener("triggered", triggered);
            //var bg:RileysApartment = new RileysApartment("night");
            //addChild(bg);
            //var bg2:Level1SlumsStreet = new Level1SlumsStreet();
            //addChild(bg2);
            /*
             var positionarrow:PositionArrow = new PositionArrow("arrow1", true);
             positionarrow.x = 300;
             positionarrow.y = 300;
             positionarrow.setRotation("right");

             var positionarrow2:PositionArrow = new PositionArrow("arrow1", true);
             positionarrow2.x = 300;
             positionarrow2.y = 300;
             positionarrow2.setRotation("left");

             var positionarrow3:PositionArrow = new PositionArrow("arrow1", true);
             positionarrow3.x = 300;
             positionarrow3.y = 300;
             positionarrow3.setRotation("up");

             var positionarrow4:PositionArrow = new PositionArrow("arrow1", true);
             positionarrow4.x = 300;
             positionarrow4.y = 300;
             positionarrow4.setRotation("down");

             addChild(positionarrow);
             addChild(positionarrow2);
             addChild(positionarrow3);
             addChild(positionarrow4);

             */
        }

        private function addTest2():void
        {
            var repo:ApartmentInteractionRepo = InteractionRepoFactory.getInteractionRepo(InteractionRepoFactory.APARTMENT_1);
            var messages:Array = repo.getMessages("kitchen_light_cupboard_1", repo.PROP, repo.EXAMINE);
            var voiceFileNames:Array = repo.getVoiceFiles("kitchen_light_cupboard_1", repo.PROP, repo.EXAMINE);
        }

        private function triggered(e:Event):void
        {
            var item:Item = _inventory.getItem("work_clothing");
            item.triggerInteractionObject();
        }
    }
}
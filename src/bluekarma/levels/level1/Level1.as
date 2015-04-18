package levels.level1
{
	import apis.newgrounds.Newgrounds;
	import apis.ThirdPartyAPI;
	import bluekarma.score.menu.ScoreMenu;
    import flash.events.TimerEvent;
    import flash.utils.Dictionary;
    import flash.utils.Timer;

    import global.Global;

    import levels.abstract.AbstractLevel;

    import score.LevelOneScore;

    import starling.core.Starling;

    import helpers.ScoreCalculator;

    import levels.level1.part5.Compound;

    import states.GameState;

    import levels.base.RileysApartment;
    import levels.level1.part1.RileysApartmentIntro;
    import levels.level1.part2.RileysJourneyAlbert;
    import levels.level1.part3.SlumsStreet;
    import levels.level1.part4.BackAlley;

    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    import utils.TimeFormat;

    /**
     * Level 1
     * @author Shaun Stone (SMKS)
     * @website http://www.smks.co.uk
     */
    final public class Level1 extends Sprite
    {
        public static const ACT_START:String = "start";
        public static const ACT_1:String = "1_apartment_intro";
        public static const ACT_2:String = "2_albert_journey";
        public static const ACT_3:String = "3_slums_street";
        public static const ACT_4:String = "4_slums_alley";
        public static const ACT_5:String = "5_the_compound";
        public static const ACT_COMPLETE_LISTENER:String = "actComplete";
        /**
         * Acts
         */
        private var act1RileysApartmentIntro:RileysApartmentIntro;
        private var act2AlbertJourney:RileysJourneyAlbert;
        private var act3SlumsStreet:SlumsStreet;
        private var act4BackAlley:BackAlley;
        private var act5TheCompound:Compound;
        /**
         * Game properties
         */

        // this will count how long the user stays in level 1
        private var levelTimer:Timer = new Timer(1000);
        //microseconds
        private var timeScore:Number = new Number(0);
        private var textfield:TextField;
        private var q:Quad;
        private var gameScore:Number = 0;
		
		/**
		 * This is the Third Party API Plugin to use for Game
		 * 
		 * ############################################
		 */
		public var apiPlugin:Newgrounds = new Newgrounds();
		/**
		 * ############################################
		 */
		
		 /**
		  * API Facade to inject API Plugin into
		  */
		 private var api:ThirdPartyAPI;
		
        /**
         * When each act has complete, we
         * want to grab items and pass to next Act
         */
        private var itemsToCarryOver:Dictionary;
        private var levelScore:LevelOneScore;
		private var scoreMenu:ScoreMenu;

        public function Level1(levelSkip:String = Level1.ACT_1)
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }
		
		/**
		 * 
		 * @param e
		 */
		private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            init();
        }

		/**
		 * We create a new Score and pass in Plugin
		 */
        private function init():void
        {
			api = new ThirdPartyAPI(apiPlugin, Starling.current.nativeStage);
            levelScore = new LevelOneScore(api);
			
			// connect to the API before we begin
			api.connect();
        }

        /**
         *
         * @return
         */
        public function getCurrentTimePassed():Number
        {
            return levelTimer.currentCount;
        }

        public function finishedAct(level:String = Level1.ACT_START, defaultScore:Number = 0, addTimer:Boolean = false):void
        {
			if (level === Level1.ACT_START) {
				// add timer and let run till level has ended
				levelTimer.addEventListener(TimerEvent.TIMER, levelTimerHandler);
				levelTimer.start();
			}
			
            // Do we want to set the score
            if (defaultScore > 0) {
                gameScore = defaultScore;
            }
            // Do we want to show the timer
            if (addTimer) {
                addLevelOneTimerText();
            }
            // Listen for when acts are complete
            addStateChangeListener();
            switch (level) {
                case ACT_START:
                    addRileyApartmentIntro();
                    positionTimerTextField();
                    gameScore = Global.ZERO_SCORE;
                    break;
                case ACT_1:
                    if (act1RileysApartmentIntro !== null) {
                        act1RileysApartmentIntro.cleanUp();
                        removeChild(act1RileysApartmentIntro, true);
                    }
                    trace("########################################################");
                    trace("Score for Act 1 is: " + levelScore.getAct1().getActScore());
                    trace("Total Score so far is: " + levelScore.getTotalScore());
                    trace("########################################################");
                    addAlbertJourney();
                    positionTimerTextField();
                    break;
                case ACT_2:
                    if (act2AlbertJourney !== null) {
                        itemsToCarryOver = getItemsToCarryOver(act2AlbertJourney);
                        act2AlbertJourney.cleanUp();
                        removeChild(act2AlbertJourney, true);
                    }
                    trace("########################################################");
                    trace("Score for Act 2 is: " + levelScore.getAct2().getActScore());
                    trace("Total Score so far is: " + levelScore.getTotalScore());
                    trace("########################################################");
                    addSlumsStreet();
                    positionTimerTextField();
                    break;
                case ACT_3:
                    if (act3SlumsStreet !== null) {
                        itemsToCarryOver = getItemsToCarryOver(act3SlumsStreet);
                        act3SlumsStreet.cleanUp();
                        removeChild(act3SlumsStreet, true);
                    }
                    trace("########################################################");
                    trace("Score for Act 3 is: " + levelScore.getAct3().getActScore());
                    trace("Total Score so far is: " + levelScore.getTotalScore());
                    trace("########################################################");
                    addBackAlley();
                    positionTimerTextField();
                    break;
                case ACT_4:
                    if (act4BackAlley !== null) {
                        itemsToCarryOver = getItemsToCarryOver(act4BackAlley);
                        act4BackAlley.cleanUp();
                        removeChild(act4BackAlley, true);
                    }
                    trace("########################################################");
                    trace("Score for Act 4 is: " + levelScore.getAct4().getActScore());
                    trace("Total Score so far is: " + levelScore.getTotalScore());
                    trace("########################################################");
                    addCompound();
                    positionTimerTextField();
                    break;
                case ACT_5:
					if (act5TheCompound !== null) {
                        act5TheCompound.cleanUp();
                        removeChild(act5TheCompound, true);
                    }
                    // the level has completed, stop the timer
                    levelTimer.stop();
					
					this.calculateScore();
                    // use the score and the time to calculate the final score
                    
                    trace("########################################################");
					trace("Score for Act 5 is: " + levelScore.getAct5().getActScore());
                    trace("Total Score is: " + levelScore.getTotalScore());
                    trace("########################################################");
                    trace("Time Score is: ", timeScore);
                    trace("Game Score is: ", gameScore);
					
					submitScoreToAPI();
					addScoreMenu();
					
                    break;
                default:
                    throw new Error("Act was not found for Level 1");
            }
        }
		
		private function calculateScore():void 
		{
			timeScore = ScoreCalculator.calculateLevelScore(gameScore, levelTimer.currentCount);
			gameScore = levelScore.getTotalScore();
		}
		
		private function submitScoreToAPI():void 
		{
			try {
				this.api.postScore(levelScore.getTotalScore());
			} catch (e:Error) {
				trace(e.message);
			}
			
			try {
				this.api.postTime(levelTimer.currentCount * 1000);
			} catch (e:Error) {
				trace(e.message);
			}
		}
		
		private function addScoreMenu():void 
		{
			scoreMenu = new ScoreMenu(
				levelScore.getTotalScore(),
				levelTimer.currentCount,
				levelScore.getMainAchievements(),
				levelScore.getBonusAchievements()
			);
			
			addChild(scoreMenu);
		}

        protected function getItemsToCarryOver(level:AbstractLevel):Dictionary
        {
            if (level === null) {
                return new Dictionary();
            }
            return level.getItemsInInventory();
        }

        /**
         * This will listen for any event dispatches to change level
         */
        private function addStateChangeListener():void
        {
            addEventListener(ACT_COMPLETE_LISTENER, handleStateChange);
        }

        private function handleStateChange(e:Event):void
        {
            var act:String = e.data.level;
            finishedAct(act);
        }

        private function positionTimerTextField():void
        {
            if (textfield === null) {
                return;
            }
            setChildIndex(q, this.numChildren);
            setChildIndex(textfield, this.numChildren);
        }

        private function addLevelOneTimerText():void
        {
            q = new Quad(180, 60, 0x000000);
            addChild(q);
            textfield = new TextField(180, 60, TimeFormat.formatTime(timeScore), "Verdana", 32, 0xffffff);
            addChild(textfield);
        }

        private function levelTimerHandler(e:TimerEvent):void
        {
            if (textfield === null) {
                return;
            }
            timeScore += 1;
            textfield.text = TimeFormat.formatTime(timeScore, 2);
        }

        /**
         * ACT 1
         */
        private function addRileyApartmentIntro():void
        {
            //play first act
            act1RileysApartmentIntro = new RileysApartmentIntro(levelScore.getAct1());
            addChild(act1RileysApartmentIntro);
        }

        /**
         * ACT 2
         */
        private function addAlbertJourney():void
        {
            act2AlbertJourney = new RileysJourneyAlbert(levelScore.getAct2());
            addChild(act2AlbertJourney);
            carryOverItemsIfExist(act2AlbertJourney);
        }

        /**
         * ACT 3
         */
        private function addSlumsStreet():void
        {
            act3SlumsStreet = new SlumsStreet(levelScore.getAct3());
            addChild(act3SlumsStreet);
            carryOverItemsIfExist(act3SlumsStreet);
        }

        /**
         * ACT 4
         */
        private function addBackAlley():void
        {
            act4BackAlley = new BackAlley(levelScore.getAct4());
            addChild(act4BackAlley);
            carryOverItemsIfExist(act4BackAlley);
        }

        /**
         * ACT 5
         */
        private function addCompound():void
        {
            act5TheCompound = new Compound(levelScore.getAct5());
            addChild(act5TheCompound);
            carryOverItemsIfExist(act5TheCompound);
        }

        private function carryOverItemsIfExist(level:AbstractLevel):void
        {
            if (level === null) {
                return;
            }
            if (itemsToCarryOver === null) {
                return;
            }
            level.setItemsInInventory(itemsToCarryOver);
        }
    }
}
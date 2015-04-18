package bluekarma.settings.backgrounds.albertscar
{
    import adobe.utils.CustomActions;
	import sound.SoundManager;

    import assets.Level1Assets;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.albertscar.props.MiddleCompartment;
    import bluekarma.interactive.general.items.DigiCuffs;
    import bluekarma.interactive.general.items.LockPick;

    import com.greensock.TweenLite;

    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;

    import interactive.albertscar.characters.AlbertDriving;
    import interactive.albertscar.props.CarSeat;
    import interactive.albertscar.props.CarWindow;

    import starling.display.MovieClip;
    import starling.events.Event;

    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;
    import bluekarma.settings.backgrounds.albertscar.movingbg.MovingBackgroundSlums;

    import flash.display.Stage;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    import starling.core.Starling;

    import players.riley.RileySittingVehicle;

    import settings.AbstractSetting;

    import starling.display.Image;
    import starling.text.TextFieldAutoSize;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BackgroundAlbertsCar extends AbstractSetting
    {
        private var movingBg:MovingBackgroundSlums;
        private var bg:Image;
        private var seatBackDriver:CarSeat;
        private var seatBackPassenger:CarSeat;
        private var seatFrontDriver:CarSeat;
        private var seatFrontPassenger:CarSeat;
        private var middleDashboard:Image;
        private var digiCuffs:DigiCuffs;
        private var lockpick:LockPick;
        private var middleCompartment:MiddleCompartment;
        private var albertDriving:AlbertDriving;
        private var rileySitting:RileySittingVehicle;

        public function BackgroundAlbertsCar(position:uint = 1, playAmbience:Boolean = true)
        {
            // will call compose setting by default
            super(position);
            if (playAmbience) {
                playInteriorAmbience();
            }
        }

        /**
         * @desc composes the level (draws, listeners etc.)
         */
        override protected function composeSetting():void
        {
            drawSetting();
        }

        /**
         * renders the graphics
         */
        override protected function drawSetting():void
        {
            addMovingBackground();
            addBackground();
            addBackSeats();
            addMiddleDashboard();
            addSittingRiley();
            addFrontSeats();
            addAlbert();
            turnOnCruise();
        }

        public function turnOffCruise():void
        {
            this.removeEventListener(Event.ENTER_FRAME, setCruise);
        }

        public function playInteriorAmbience(loop:Boolean = true):void
        {
			SoundManager.addSound("car-ambience", SoundAssets.carInteriorAmbience, int.MAX_VALUE, 0);
			SoundManager.fadeIn("car-ambience", 6);
        }

        public function stopInteriorAmbience():void
        {
			SoundManager.fadeOutAndRemove("car-ambience", 2);
        }

        public function makeCompartmentExaminable():void
        {
            middleCompartment.setExaminable(true);
        }

        public function stopMovingBackground():void
        {
            movingBg.stopMoving();
        }

        public function openCompartment():void
        {
            middleCompartment.open();
            // make items appear above compartment
            setChildIndex(digiCuffs, getChildIndex(middleCompartment));
            digiCuffs.setGlow(true);
            setChildIndex(lockpick, getChildIndex(middleCompartment));
            lockpick.setGlow(true);
        }

        public function getDigiCuffs():DigiCuffs
        {
            return digiCuffs;
        }

        public function getLockPick():LockPick
        {
            return lockpick;
        }

        private function turnOnCruise():void
        {
            this.addEventListener(Event.ENTER_FRAME, setCruise);
            bg.height *= 1.05;
        }

        private function setCruise(e:Event):void
        {
            var currentDate:Date = new Date();
            bg.y = (Math.cos(currentDate.getTime() * 0.0010) * 5);
        }

        private function addMovingBackground():void
        {
            movingBg = new MovingBackgroundSlums(20);
            movingBg.touchable = false;
            addChild(movingBg);
        }

        private function addBackground():void
        {
            bg = new Image(AlbertJourneyAssets.getTexture("CarBackground"));
            addChild(bg);
            var windows:CarWindow = new CarWindow("car_window", true);
            addChild(windows);
        }

        private function addMiddleDashboard():void
        {
            middleDashboard = new Image(AlbertJourneyAssets.getAtlas().getTexture("middle-dashboard"));
            middleDashboard.x = 401;
            middleDashboard.y = 198;
            addChild(middleDashboard);
            // add items to be picked up near end of part
            digiCuffs = new DigiCuffs("digi_cuffs", true);
            digiCuffs.setLevelItem(DigiCuffs.CAR);
            digiCuffs.scaleX = 0.7;
            digiCuffs.scaleY = 0.7;
            digiCuffs.x = 450;
            digiCuffs.y = 462;
            addChild(digiCuffs);
            lockpick = new LockPick("lock_pick", true);
            lockpick.setLevelItem(LockPick.CAR);
            lockpick.scaleX = 0.5;
            lockpick.scaleY = 0.5;
            lockpick.x = 497;
            lockpick.y = 470;
            addChild(lockpick);
            middleCompartment = new MiddleCompartment("middle_compartment", true);
            middleCompartment.x = 438;
            middleCompartment.y = 338;
            // this should not be examinable yet
            middleCompartment.setExaminable(false);
            addChild(middleCompartment);
        }

        private function addBackSeats():void
        {
            seatBackPassenger = new CarSeat(CarSeat.BACK_PASSENGER, true);
            seatBackPassenger.x = 192;
            seatBackPassenger.y = 179;
            addChild(seatBackPassenger);
            seatBackDriver = new CarSeat(CarSeat.BACK_DRIVER, true);
            seatBackDriver.x = 558;
            seatBackDriver.y = 179;
            addChild(seatBackDriver);
        }

        private function addSittingRiley():void
        {
            rileySitting = new RileySittingVehicle();
            rileySitting.touchable = false;
            addChild(rileySitting);
        }

        private function addFrontSeats():void
        {
            seatFrontDriver = new CarSeat(CarSeat.FRONT_DRIVER);
            seatFrontDriver.x = 600;
            seatFrontDriver.y = 135;
            addChild(seatFrontDriver);
            seatFrontPassenger = new CarSeat(CarSeat.FRONT_PASSENGER);
            seatFrontPassenger.touchable = false;
            seatFrontPassenger.x = -65;
            seatFrontPassenger.y = 143;
            addChild(seatFrontPassenger);
        }

        private function addAlbert():void
        {
            albertDriving = new AlbertDriving("albert_driving", true, true);
            albertDriving.x = 600;
            albertDriving.y = 160;
            addChild(albertDriving);
            var bgShade:Image = new Image(AlbertJourneyAssets.getTexture("CarBackgroundShadow"));
            bgShade.touchable = false;
            addChild(bgShade);
        }
    }
}
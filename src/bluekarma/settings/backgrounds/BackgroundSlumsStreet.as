package settings.backgrounds
{
    import adobe.utils.CustomActions;

    import bluekarma.interactive.base.Character;

    import starling.display.DisplayObject;

    import bluekarma.interactive.slumsstreet.characters.Graham;
    import bluekarma.interactive.base.Item;
    import bluekarma.interactive.base.Animal;
    import bluekarma.interactive.slumsstreet.animals.DogBob;
    import bluekarma.interactive.slumsstreet.props.CCTV;

    import com.greensock.loading.data.ImageLoaderVars;

    import flash.display3D.Context3DProfile;

    import global.Global;

    import interactive.slumsstreet.characters.Barry;
    import interactive.slumsstreet.characters.Billy;
    import interactive.slumsstreet.characters.Charlie;
    import interactive.slumsstreet.characters.Danny;
    import interactive.slumsstreet.characters.Jacob;
    import interactive.slumsstreet.characters.Pablo;
    import interactive.slumsstreet.characters.Roger;
    import interactive.slumsstreet.characters.Roger;
    import interactive.slumsstreet.props.CompoundDoor;
    import interactive.slumsstreet.props.HouseDoor;
    import interactive.slumsstreet.props.HouseWindow;
    import interactive.slumsstreet.props.MetalFence;
    import interactive.slumsstreet.props.MetalFenceDoor;
    import interactive.slumsstreet.props.RoadSign;

    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Image;

    import assets.Level1Assets;
    import assets.Level1CharacterAssets;

    import bluekarma.assets.sound.SoundAssets;

    import starling.core.Starling;
    import starling.display.Button;

    import settings.AbstractSetting;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BackgroundSlumsStreet extends AbstractSetting
    {
        private var _bgStreet:Image;
        private var _bgAlleySmall:Image;
        private var _bobDog:Animal;
        private var _metalFence:MetalFence;
        private var _metalFenceDoor:MetalFenceDoor;
        private var _compoundDoor:CompoundDoor;
        private var _houseDoor:HouseDoor;
        private var _houseWindow:HouseWindow;
        private var _roadSign:RoadSign;
        private var _skipOpen:Image;
        private var _skipClosed:Image;
        private var _cctv1:CCTV;
        private var _billy:Billy;
        private var _charlie:Charlie;
        private var _danny:Danny;
        private var _jacob:Jacob;
        private var _pablo:Pablo;
        private var _roger:Roger;
        private var _graham:Graham;

        public function BackgroundSlumsStreet(position:uint = 1)
        {
            super(position);
        }

        override protected function composeSetting():void
        {
            drawSetting();
        }

        override protected function drawSetting():void
        {
            var slumsBGName:String;
            // replace with bigger image if supported
            /**
             if (Starling.current.profile === "baselineExtended") {
                slumsBGName = "SlumsBackgroundTimesTwoImage";
            } else {
				slumsBGName = "SlumsBackgroundImage";
			}
             **/

            slumsBGName = "SlumsBackgroundImage";
            _bgStreet = new Image(Level1Assets.getTexture(slumsBGName));
            _bgStreet.width = 2560;
            _bgStreet.height = 768;
            addChild(_bgStreet);
            // set position
            setCurrentPosition(_currentPosition);
            //Add street background props
            addProps();
            addCharacters();
        }

        override public function setCurrentPosition(_pos:uint):void
        {
            //assign new position
            _currentPosition = _pos;
            //set position of background
            if (_pos == 1) {
                this.x = 0;
                this.y = 0;
            } else if (_pos == 2) {
                this.x = -853;
                this.y = 0;
            } else if (_pos == 3) {
                this.x = -2560 + stage.stageWidth;
                this.y = 0;
            } else {
                return;
            }
        }

        public function getDog():Animal
        {
            return _bobDog;
        }

        public function getBgAlleySmall():Image
        {
            return _bgAlleySmall;
        }

        public function openMetalGate():void
        {
            _metalFenceDoor.open();
        }

        public function isMetalGateOpen():Boolean
        {
            return _metalFenceDoor.isOpen();
        }

        /**
         * @return Graham
         */
        public function getRupert():Graham
        {
            return _graham;
        }

        public function setRupertSleep():void
        {
            _roger.sleep();
        }

        public function everyoneExamined():Boolean
        {
            var charCount:uint = 0;
            var totalCharacters:uint = 7;
            for (var i:uint = 0; i < this.numChildren; i++) {
                if (charCount === totalCharacters) {
                    return true;
                }
                var child:DisplayObject = this.getChildAt(i);
                if (child is Character) {
					
					trace(Character(child)._id);
					
                    if (Character(child).hasBeenExamined() === false) {
						
						trace(Character(child)._id + " is FALSE ------------");
						
                        return false;
                    }
                    charCount++;
                }
            }
            return true;
        }

        private function addProps():void
        {
            //addDog();
            addRoadSign();
            addHouseDoor();
            addHouseWindow();
            addMetalFence();
            addCCTV1();
            addCompoundDoor();
        }

        private function addCompoundDoor():void
        {
            _compoundDoor = new CompoundDoor("compound-door", true);
            _compoundDoor.x = 2032;
            _compoundDoor.y = 144;
            addChild(_compoundDoor);
        }

        private function addHouseDoor():void
        {
            _houseDoor = new HouseDoor("house-door", true);
            _houseDoor.x = 1024;
            _houseDoor.y = 192;
            addChild(_houseDoor);
        }

        private function addHouseWindow():void
        {
            _houseWindow = new HouseWindow("house-window", true);
            _houseWindow.x = 575;
            _houseWindow.y = 127;
            addChild(_houseWindow);
        }

        private function addRoadSign():void
        {
            _roadSign = new RoadSign("road-sign", true);
            _roadSign.x = 104;
            _roadSign.y = 52;
            addChild(_roadSign);
        }

        private function addCCTV1():void
        {
            _cctv1 = new CCTV("cctv-1", true);
            _cctv1.x = 150;
            _cctv1.y = 80;
            _cctv1.scaleX = -0.6;
            _cctv1.scaleY = 0.6;
            addChild(_cctv1);
        }

        private function addCharacters():void
        {

            //add gang members
            _billy = new Billy("billy", true, true);
            _billy.x = 223;
            _billy.y = 240;
            addChild(_billy);
            _danny = new Danny("danny", true, true);
            _danny.x = 473;
            _danny.y = 240;
            addChild(_danny);
            _charlie = new Charlie("charlie", true, true);
            _charlie.x = 335;
            _charlie.y = 210;
            addChild(_charlie);
            _roger = new Roger("roger", true, true);
            _roger.x = 830;
            _roger.y = 328;
            addChild(_roger);
            _jacob = new Jacob("jacob", true, true);
            _jacob.x = 2020;
            _jacob.y = 253;
            addChild(_jacob);
            _pablo = new Pablo("pablo", true, true);
            _pablo.x = 2125;
            _pablo.y = 260;
            addChild(_pablo);
            _graham = new Graham("graham", true, true);
            _graham.x = 630;
            _graham.y = 339;
            addChild(_graham);
        }

        private function addMetalFence():void
        {
            //add metal fence frame
            _metalFence = new MetalFence("metal-fence", false);
            _metalFence.x = 1296;
            _metalFence.y = 96;
            addChild(_metalFence);
            _metalFenceDoor = new MetalFenceDoor("metal-gate", true);
            _metalFenceDoor.x = 1492;
            _metalFenceDoor.y = 208;
            addChild(_metalFenceDoor);
        }

        private function addDog():void
        {
            _bobDog = new DogBob("bob-dog", true);
            _bobDog.x = 1150;
            _bobDog.y = 170;
            addChild(_bobDog);
        }
    }
}
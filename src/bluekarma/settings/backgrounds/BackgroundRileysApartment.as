package settings.backgrounds
{
    import bluekarma.interactive.apartment.animals.crunch.DogCrunchSleeping;
    import bluekarma.interactive.base.Item;
    import bluekarma.interactive.general.items.LockPick;

    import interactive.apartment.items.DogBowl;
    import interactive.apartment.items.DogFood;
    import interactive.apartment.items.KitchenFoodBowl;
    import interactive.apartment.items.KitchenPlate;
    import interactive.apartment.items.KitchenWaterGlass;
    import interactive.apartment.props.bedroom.BedroomPlugSocket;
    import interactive.apartment.props.bedroom.BedroomWashingBasket;
    import interactive.apartment.props.bedroom.BedsideCabinet;
    import interactive.apartment.props.bedroom.BedsideChest;
    import interactive.apartment.props.bedroom.CanvasPhoto;
    import interactive.apartment.props.bedroom.SaxophonistPortrait;
    import interactive.apartment.props.general.Window;
    import interactive.apartment.props.bedroom.BedroomPlugSocket;
    import interactive.apartment.props.bedroom.BedroomWashingBasket;
    import interactive.apartment.props.bedroom.BedsideCabinet;
    import interactive.apartment.props.bedroom.BedsideChest;
    import interactive.apartment.props.bedroom.CanvasPhoto;

    import assets.RileyApartmentAssets;

    import com.greensock.loading.BinaryDataLoader;
    import com.greensock.loading.data.ImageLoaderVars;

    import interactive.apartment.props.bedroom.BedroomLamp;
    import interactive.apartment.props.general.Door;
    import interactive.apartment.props.general.Window;
    import interactive.apartment.props.kitchen.KitchenBinBag;
    import interactive.apartment.props.kitchen.KitchenCooker;
    import interactive.apartment.props.kitchen.KitchenDarkCupboard;
    import interactive.apartment.props.kitchen.KitchenLightCupboard;
    import interactive.apartment.props.kitchen.KitchenMicrowave;
    import interactive.apartment.props.kitchen.KitchenSink;
    import interactive.apartment.props.kitchen.KitchenStoveConvector;
    import interactive.apartment.props.living_room.LivingRoomDogBed;
    import interactive.apartment.props.living_room.LivingRoomFramedPhoto;
    import interactive.apartment.props.living_room.LivingRoomCoffeeTable;
    import interactive.apartment.props.living_room.LivingRoomSofa;
    import interactive.apartment.props.living_room.LivingRoomSpeaker;
    import interactive.apartment.props.living_room.LivingRoomTelevision;
    import interactive.apartment.props.bedroom.PlantPot;
    import interactive.apartment.props.living_room.LivingRoomWelcomeMatt;
    import interactive.apartment.props.living_room.SmartWindow;
    import interactive.base.Prop;

    import settings.AbstractSetting;
    import settings.backgrounds.apartment.cityview.CityView;

    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Image;

    import flash.geom.Point;

    import starling.display.DisplayObject;
    import starling.filters.ColorMatrixFilter;

    import com.barliesque.shaders.macro.Blend;

    import assets.Level1Assets;
    import assets.Level1CharacterAssets;

    import bluekarma.assets.sound.SoundAssets;

    import starling.core.Starling;
    import starling.display.Button;

    import events.InteractionEvent;

    import interactive.apartment.props.bedroom.BedroomBed;
    import interactive.apartment.props.bedroom.Lightswitch;
    import interactive.apartment.props.living_room.LivingRoomCurtains
    import interactive.apartment.props.living_room.LivingRoomTelevisionCabinet;
    import interactive.apartment.props.living_room.LivingRoomRug;

    /**
     * ...
     * @author Shaun Stone
     */
    public class BackgroundRileysApartment extends AbstractSetting
    {
        private var bg:Image;
        //Bedroom
        private var _bed:BedroomBed;
        private var _bedroomWindow:Window;
        private var _lightSwitch1:Lightswitch;
        private var _lightSwitch2:Lightswitch;
        private var _bedroomLamp:BedroomLamp;
        private var _plugSocket:BedroomPlugSocket;
        private var _bedsideCabinet:BedsideCabinet;
        private var _bedroomChest:BedsideChest;
        private var _bedroomDoor:Door;
        private var _plantPot:PlantPot;
        private var _canvasPhoto:CanvasPhoto;
        private var _saxophonistPortrait:SaxophonistPortrait;
        private var _washingBasket:BedroomWashingBasket;
        //Living Room
        //private var _bigCurtains:LivingRoomCurtains;
        private var _cityView:CityView;
        private var _smartWindow:SmartWindow;
        private var _smartTv:LivingRoomTelevision;
        private var _tvCabinet:LivingRoomTelevisionCabinet;
        private var _rug:LivingRoomRug;
        private var _sofa:LivingRoomSofa;
        private var _speaker1:LivingRoomSpeaker;
        private var _speaker2:LivingRoomSpeaker;
        private var _welcomeMatt:LivingRoomWelcomeMatt;
        private var _coffeeTable:LivingRoomCoffeeTable;
        private var _doveFramePhoto:LivingRoomFramedPhoto;
        private var _dogBed:LivingRoomDogBed;
        private var _dogCrunch:DogCrunchSleeping;
        //Kitchen
        private var _kitchenBowl1:KitchenFoodBowl;
        private var _kitchenBowl2:KitchenFoodBowl;
        private var _kitchenBowl3:KitchenFoodBowl;
        private var _kitchenGlass1:KitchenWaterGlass;
        private var _kitchenGlass2:KitchenWaterGlass;
        private var _kitchenGlass3:KitchenWaterGlass;
        private var _kitchenGlass4:KitchenWaterGlass;
        private var _kitchenPlate1:KitchenPlate;
        private var _kitchenPlate2:KitchenPlate;
        private var _kitchenPlate3:KitchenPlate;
        private var _kitchenPlate4:KitchenPlate;
        private var _dogFood:DogFood;
        private var _dogBowl:DogBowl;
        private var _kitchenSink:KitchenSink;
        private var _kitchenWindow:Window;
        private var _kitchenLightCupboard1:KitchenLightCupboard;
        private var _kitchenLightCupboard2:KitchenLightCupboard;
        private var _kitchenLightCupboard3:KitchenLightCupboard;
        private var _kitchenMicrowave:KitchenMicrowave;
        private var _kitchenDarkCupboard1:KitchenDarkCupboard;
        private var _kitchenDarkCupboard2:KitchenDarkCupboard;
        private var _kitchenDarkCupboard3:KitchenDarkCupboard;
        private var _kitchenDarkCupboard4:KitchenDarkCupboard;
        private var _kitchenOvenConvector:KitchenStoveConvector;
        private var _kitchenCooker:KitchenCooker;
        private var _kitchenDoor:Door;
        private var _kitchenBin:KitchenBinBag;

        public function BackgroundRileysApartment(position:uint = 1)
        {
            super(position);
        }

        override protected function composeSetting():void
        {
            drawSetting();
        }

        override protected function drawSetting():void
        {
            //add bg
            bg = new Image(RileyApartmentAssets.getTexture(RileyApartmentAssets.APARTMENT_BACKGROUND));
            bg.width = 3072;
            bg.height = 768;
            this.addChild(bg);
            addInteractiveObjects();
            setBlendMode();
            this.setCurrentPosition(_currentPosition);
        }

        /**
         * cliprect is limited to stage bounds, therefore we have to hide
         * it.
         * @param    position
         */
        override public function setCurrentPosition(position:uint):void
        {
            if (position === 1 || position === 3) {
                _cityView.visible = false;
            } else {
                _cityView.visible = true;
            }
            super.setCurrentPosition(position);
        }

        public function toggleBedroomLight(id:String):void
        {
            if (id == 'light_switch_1') {
                _lightSwitch1.triggerInteractionObject();
            } else if (id == 'light_switch_2') {
                _lightSwitch2.triggerInteractionObject();
            }
        }

        public function fillDogBowlWithFood():void
        {
            _dogBowl.fillWithFood();
        }

        public function placeDogBowlByDog(dogBowl:Item):void
        {
            _dogBowl.scaleX = 0.8;
            _dogBowl.scaleY = 0.4;
            _dogCrunch.setBeenFed(true);
            dogBowl.x = 1130;
            dogBowl.y = 662;
            addChild(dogBowl);
        }

        public function openAllCupboards():void
        {
            //_kitchenDarkCupboard1.openCupboard();
            _kitchenDarkCupboard2.openCupboard();
            _kitchenDarkCupboard3.openCupboard();
            _kitchenDarkCupboard4.openCupboard();
            _kitchenLightCupboard1.openCupboard();
            _kitchenLightCupboard2.openCupboard();
            _kitchenLightCupboard3.openCupboard();
        }

        public function getBedroomChest():BedsideChest
        {
            return _bedroomChest;
        }

        public function isBedroomChestOpen():Boolean
        {
            return _bedroomChest.getDrawOpen();
        }

        public function setBedroomChest(value:BedsideChest):void
        {
            _bedroomChest = value;
        }

        public function bedroomDoorOpen():Boolean
        {
            return _bedroomDoor.getIsDoorOpen();
        }

        public function animateDog():void
        {
            _dogCrunch.setUpAnimation();
        }

        public function getDogBowl():DogBowl
        {
            return _dogBowl;
        }

        public function getDogFood():DogFood
        {
            return _dogFood;
        }

        public function bedsideCabinetHasLockpick():Boolean
        {
            return _bedsideCabinet.hasLockPick();
        }

        public function getLockpick():LockPick
        {
            return _bedsideCabinet.getLockPick();
        }

        public function triggerFlyingVehicles():void
        {
            _cityView.enableShips().triggerFlyingVehicle();
        }

        public function stopFlyingVehicles():void
        {
        }

        public function getKitchenSink():KitchenSink
        {
            return _kitchenSink;
        }

        public function getPlantPot():PlantPot
        {
            return _plantPot;
        }

        public function getBed():BedroomBed
        {
            return _bed;
        }

        public function washingBasketOpen():Boolean
        {
            return _washingBasket.isOpen();
        }

        public function getCrunch():DogCrunchSleeping
        {
            return _dogCrunch;
        }

        public function getSmartWindow():SmartWindow
        {
            return _smartWindow;
        }

        private function setBlendMode():void
        {
            // Blend.overlay
        }

        private function addInteractiveObjects():void
        {
            addBedroomInteractiveItems();
            addLivingRoomInteractiveItems();
            addKitchenInteractiveItems();
        }

        private function addKitchenInteractiveItems():void
        {
            _kitchenWindow = new Window("kitchen_window", true);
            _kitchenWindow.x = 118;
            _kitchenWindow.y = 164.22;
            addChild(_kitchenWindow);
            /**
             * Add cupboard items
             */

                // bowls
            _kitchenBowl3 = new KitchenFoodBowl("kitchen_bowl", true);
            _kitchenBowl3.x = 220;
            _kitchenBowl3.y = 268;
            addChild(_kitchenBowl3);
            _kitchenBowl2 = new KitchenFoodBowl("kitchen_bowl", true);
            _kitchenBowl2.x = 220;
            _kitchenBowl2.y = 278;
            addChild(_kitchenBowl2);
            _kitchenBowl1 = new KitchenFoodBowl("kitchen_bowl", true);
            _kitchenBowl1.x = 220;
            _kitchenBowl1.y = 288;
            addChild(_kitchenBowl1);
            // glasses
            _kitchenGlass1 = new KitchenWaterGlass("kitchen_glass", true);
            _kitchenGlass1.x = 221;
            _kitchenGlass1.y = 390;
            addChild(_kitchenGlass1);
            _kitchenGlass2 = new KitchenWaterGlass("kitchen_glass", true);
            _kitchenGlass2.x = 252;
            _kitchenGlass2.y = 390;
            addChild(_kitchenGlass2);
            _kitchenGlass3 = new KitchenWaterGlass("kitchen_glass", true);
            _kitchenGlass3.x = 285;
            _kitchenGlass3.y = 390;
            addChild(_kitchenGlass3);
            _kitchenGlass4 = new KitchenWaterGlass("kitchen_glass", true);
            _kitchenGlass4.x = 316;
            _kitchenGlass4.y = 390;
            addChild(_kitchenGlass4);
            // plates
            _kitchenPlate4 = new KitchenPlate("kitchen_plate", true);
            _kitchenPlate4.x = 265;
            _kitchenPlate4.y = 300;
            addChild(_kitchenPlate4);
            _kitchenPlate3 = new KitchenPlate("kitchen_plate", true);
            _kitchenPlate3.x = 265;
            _kitchenPlate3.y = 295;
            addChild(_kitchenPlate3);
            _kitchenPlate2 = new KitchenPlate("kitchen_plate", true);
            _kitchenPlate2.x = 265;
            _kitchenPlate2.y = 290;
            addChild(_kitchenPlate2);
            _kitchenPlate1 = new KitchenPlate("kitchen_plate", true);
            _kitchenPlate1.x = 265;
            _kitchenPlate1.y = 285;
            addChild(_kitchenPlate1);
            // dog bowl
            _dogBowl = new DogBowl("dog_bowl", true);
            _dogBowl.scaleX = 0.6;
            _dogBowl.scaleY = 0.2;
            _dogBowl.x = 625;
            _dogBowl.y = 538;
            addChild(_dogBowl);
            // dog food
            _dogFood = new DogFood("dog_food", true);
            _dogFood.scaleX = 0.6;
            _dogFood.scaleY = 0.4;
            _dogFood.x = 625;
            _dogFood.y = 568;
            addChild(_dogFood);
            /**
             * Add cupboards
             */

            _kitchenLightCupboard1 = new KitchenLightCupboard("kitchen_light_cupboard_1", true);
            _kitchenLightCupboard1.x = 179;
            _kitchenLightCupboard1.y = 209;
            addChild(_kitchenLightCupboard1);
            _kitchenLightCupboard2 = new KitchenLightCupboard("kitchen_light_cupboard_2", true);
            _kitchenLightCupboard2.x = 179;
            _kitchenLightCupboard2.y = 322;
            addChild(_kitchenLightCupboard2);
            _kitchenLightCupboard3 = new KitchenLightCupboard("kitchen_light_cupboard_3", true);
            _kitchenLightCupboard3.x = 559;
            _kitchenLightCupboard3.y = 209;
            addChild(_kitchenLightCupboard3);
            _kitchenDarkCupboard1 = new KitchenDarkCupboard("kitchen_dark_cupboard_1", true);
            _kitchenDarkCupboard1.x = 200;
            _kitchenDarkCupboard1.y = 519;
			_kitchenDarkCupboard1.setTouchable(false);
            addChild(_kitchenDarkCupboard1);
            _kitchenDarkCupboard2 = new KitchenDarkCupboard("kitchen_dark_cupboard_2", true);
            _kitchenDarkCupboard2.x = 276;
            _kitchenDarkCupboard2.y = 509;
            addChild(_kitchenDarkCupboard2);
            _kitchenDarkCupboard3 = new KitchenDarkCupboard("kitchen_dark_cupboard_3", true);
            _kitchenDarkCupboard3.x = 433;
            _kitchenDarkCupboard3.y = 509;
            addChild(_kitchenDarkCupboard3);
            _kitchenDarkCupboard4 = new KitchenDarkCupboard("kitchen_dark_cupboard_4", true);
            _kitchenDarkCupboard4.x = 589;
            _kitchenDarkCupboard4.y = 509;
            addChild(_kitchenDarkCupboard4);
            //add sink
            _kitchenSink = new KitchenSink("kitchen_sink", true);
            _kitchenSink.x = 39;
            _kitchenSink.y = 439;
            addChild(_kitchenSink);
            //add microwave
            _kitchenMicrowave = new KitchenMicrowave("kitchen_microwave", true);
            _kitchenMicrowave.x = 560;
            _kitchenMicrowave.y = 342;
            addChild(_kitchenMicrowave);
            //_kitchenMicrowave.turnOnMicrowave();
            _kitchenOvenConvector = new KitchenStoveConvector("kitchen_convector", true);
            _kitchenOvenConvector.x = 377.75;
            _kitchenOvenConvector.y = 275;
            addChild(_kitchenOvenConvector);
            _kitchenCooker = new KitchenCooker("kitchen_cooker", true);
            _kitchenCooker.x = 365;
            _kitchenCooker.y = 460;
            addChild(_kitchenCooker);
            _kitchenDoor = new Door("kitchen_door", true);
            _kitchenDoor.x = 797.5;
            _kitchenDoor.y = 270.5;
            addChild(_kitchenDoor);
            //add bin
            _kitchenBin = new KitchenBinBag("kitchen_bin_bag", true);
            _kitchenBin.x = 736;
            _kitchenBin.y = 463;
            addChild(_kitchenBin);
        }

        private function addLivingRoomInteractiveItems():void
        {
            // add city view
            _cityView = new CityView(false);
            _cityView.x = 1256;
            _cityView.y = 39;
            addChild(_cityView);
            _smartWindow = new SmartWindow("smart_window", true);
            _smartWindow.x = 1256;
            _smartWindow.y = 39;
            addChild(_smartWindow);
            _smartWindow.showView();
            //add tv
            _smartTv = new LivingRoomTelevision("living_room_tv", true);
            _smartTv.x = 1890;
            _smartTv.y = 106;
            addChild(_smartTv);
            //add tv-cabinet
            _tvCabinet = new LivingRoomTelevisionCabinet("living_room_tv_cabinet", true);
            _tvCabinet.x = 1822;
            _tvCabinet.y = 386;
            addChild(_tvCabinet);
            //rug
            _rug = new LivingRoomRug("living_room_rug", true);
            _rug.x = 1337;
            _rug.y = 484;
            addChild(_rug);
            _sofa = new LivingRoomSofa("living_room_sofa", true);
            _sofa.x = 1004;
            _sofa.y = 356;
            addChild(_sofa);
            _speaker2 = new LivingRoomSpeaker(LivingRoomSpeaker.SPEAKER_RIGHT, true);
            _speaker2.x = 1975;
            _speaker2.y = 522.25;
            addChild(_speaker2);
            _welcomeMatt = new LivingRoomWelcomeMatt("living_room_welcome_matt", true);
            _welcomeMatt.x = 1456;
            _welcomeMatt.y = 725;
            addChild(_welcomeMatt);
            _coffeeTable = new LivingRoomCoffeeTable("living_room_coffee_table", true);
            _coffeeTable.x = 1426.50;
            _coffeeTable.y = 440;
            addChild(_coffeeTable);
            _doveFramePhoto = new LivingRoomFramedPhoto("living_room_photo", true);
            _doveFramePhoto.x = 1068;
            _doveFramePhoto.y = 114;
            addChild(_doveFramePhoto);
            _dogBed = new LivingRoomDogBed("living_room_dog_bed", true);
            _dogBed.x = 1016;
            _dogBed.y = 591;
            addChild(_dogBed);
            //Add Crunch
            _dogCrunch = new DogCrunchSleeping("dog_crunch", true);
            _dogCrunch.x = 1085;
            _dogCrunch.y = 544;
            addChild(_dogCrunch);
        }

        private function addBedroomInteractiveItems():void
        {
            _bed = new BedroomBed("bed", true);
            _bed.x = 2750;
            _bed.y = 410;
            addChild(_bed);
            _bedroomWindow = new Window("bedroom_window", true);
            _bedroomWindow.x = 2950;
            _bedroomWindow.y = 164.22;
            addChild(_bedroomWindow);
            _bedroomWindow.closeBlinds();
            _lightSwitch1 = new Lightswitch("light_switch_1", true);
            _lightSwitch1.x = 2100;
            _lightSwitch1.y = 411;
            addChild(_lightSwitch1);
            _lightSwitch2 = new Lightswitch("light_switch_2", true);
            _lightSwitch2.x = 2699.50;
            _lightSwitch2.y = 411;
            addChild(_lightSwitch2);
            //add plugs
            _plugSocket = new BedroomPlugSocket("plug_socket", true);
            _plugSocket.x = 2687;
            _plugSocket.y = 455;
            addChild(_plugSocket);
            //add bedside cabinet
            _bedsideCabinet = new BedsideCabinet("bedside_cabinet", true);
            _bedsideCabinet.x = 2607;
            _bedsideCabinet.y = 509;
            addChild(_bedsideCabinet);
            _bedroomLamp = new BedroomLamp("bedroom_lamp", true);
            _bedroomLamp.x = 2613;
            _bedroomLamp.y = 440;
            addChild(_bedroomLamp);
            _bedroomChest = new BedsideChest("bedroom_chest", true);
            _bedroomChest.x = 2376;
            _bedroomChest.y = 454.5;
            addChild(_bedroomChest);
            _saxophonistPortrait = new SaxophonistPortrait("sax_photo", true);
            _saxophonistPortrait.x = 2426;
            _saxophonistPortrait.y = 202;
            addChild(_saxophonistPortrait);
            _plantPot = new PlantPot("plant_pot", true);
            _plantPot.x = 2390;
            _plantPot.y = 307;
            addChild(_plantPot);
            _bedroomDoor = new Door("bedroom_door", true);
            _bedroomDoor.x = 2185;
            _bedroomDoor.y = 270;
            addChild(_bedroomDoor);
            _canvasPhoto = new CanvasPhoto("canvas_photo", true);
            _canvasPhoto.x = 2594;
            _canvasPhoto.y = 202;
            addChild(_canvasPhoto);
            _washingBasket = new BedroomWashingBasket("washing_basket", true);
            _washingBasket.x = 2070;
            _washingBasket.y = 487;
            addChild(_washingBasket);
        }
    }
}
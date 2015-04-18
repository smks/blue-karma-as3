package bluekarma.assets.sound
{
    import flash.media.Sound;

    /**
     * ...
     * @author Shaun Stone
     */
    public class SoundAssets
    {
        [Embed(source="../../../../media/tracks/discovery/bk_discovery_good_long.mp3")]
        public static const DiscoveryTrackGoodLong:Class;
        //short version of above TO BE CHANGED
        [Embed(source="../../../../media/tracks/discovery/bk_discovery_good_short.mp3")]
        public static const DiscoveryTrackGoodShort:Class;
        [Embed(source="../../../../media/tracks/discovery/bk_discovery_bad.mp3")]
        public static const DiscoveryTrackBadLong:Class;
        [Embed(source="../../../../media/tracks/danger/bk_danger_1.mp3")]
        public static const DangerTrack:Class;
        [Embed(source="../../../../media/tracks/discovery/bk_discovery_good_short.mp3")]
        public static const TrackIntroLevel:Class;
        [Embed(source="../../../../media/tracks/introduction/bk_introduction_1.mp3")]
        public static const ApartmentIntroBegin:Class;
        [Embed(source="../../../../media/tracks/warning/bk_warning.mp3")]
        public static const WarningTrack:Class;
        [Embed(source="../../../../media/tracks/new-level/bk_new_location.mp3")]
        public static const NewLocationTrack:Class;
        /**
         *  Initialise Sound Ambience Loops
         */

        [Embed(source="../../../../media/sounds/ambience/slums_street_ambience.mp3")]
        public static const SlumsAmbienceSound:Class;
        [Embed(source="../../../../media/sounds/ambience/albertscar/car-interior-ambience.mp3")]
        public static const CarInteriorAmbience:Class;
        /**
         * Moments
         */
        [Embed(source="../../../../media/sounds/moments/walk-to-door.mp3")]
        public static const WalkToDoorAndOpen:Class;
        /**
         * Back Alley Sounds
         */
        [Embed(source="../../../../media/sounds/electric/fan-generator.mp3")]
        public static const FanGenerator:Class;
        /**
         *  Menu Sounds
         */

        [Embed(source="../../../../media/sounds/button/beep-1.mp3")]
        public static const MenuButtonBeep1:Class;
        [Embed(source="../../../../media/sounds/button/beep-2.mp3")]
        public static const MenuButtonBeep2:Class;
        [Embed(source="../../../../media/sounds/button/beep-3.mp3")]
        public static const MenuButtonBeep3:Class;
        [Embed(source="../../../../media/sounds/button/beep-message-1.mp3")]
        public static const MenuButtonBeepMessage1:Class;
        [Embed(source="../../../../media/sounds/button/minimise.mp3")]
        public static const MenuButtonBeepMinimise1:Class;
        [Embed(source="../../../../media/sounds/button/maximise.mp3")]
        public static const MenuButtonBeepMaximise1:Class;
        [Embed(source="../../../../media/sounds/button/click-1.mp3")]
        public static const MenuButtonClick1:Class;
        [Embed(source="../../../../media/sounds/button/click-2.mp3")]
        public static const MenuButtonClick2:Class;
        [Embed(source="../../../../media/sounds/button/click-3.mp3")]
        public static const MenuButtonClick3:Class;
        /**
         *  Apartment Sounds
         */
        [Embed(source="../../../../media/sounds/apartment/lightswitchOn.mp3")]
        public static const ApartmentLightSwitchOn:Class;
        [Embed(source="../../../../media/sounds/apartment/lightswitchOff.mp3")]
        public static const ApartmentLightSwitchOff:Class;
        [Embed(source="../../../../media/sounds/mobile/phone_ring.mp3")]
        public static const ApartmentMobilePhoneRinging:Class;
        [Embed(source="../../../../media/sounds/ambience/city_ambience_apartment.mp3")]
        public static const ApartmentCityAmbienceMild:Class;
        [Embed(source="../../../../media/sounds/apartment/props/door/doorOpen.mp3")]
        public static const ApartmentDoorOpen:Class;
        [Embed(source="../../../../media/sounds/apartment/props/door/doorClose.mp3")]
        public static const ApartmentDoorClose:Class;
        [Embed(source="../../../../media/sounds/apartment/props/chest/openDrawer.mp3")]
        public static const ApartmentBedroomChestOpen:Class;
        [Embed(source="../../../../media/sounds/apartment/props/chest/closeDrawer.mp3")]
        public static const ApartmentBedroomChestClose:Class;
        [Embed(source="../../../../media/sounds/apartment/props/clothing/getOutClothing.mp3")]
        public static const ClothingGetOut:Class;
        [Embed(source="../../../../media/sounds/apartment/props/clothing/pickUpClothing.mp3")]
        public static const ClothingPickup:Class;
        [Embed(source="../../../../media/sounds/apartment/shower.mp3")]
        public static const BedroomShower:Class;
        [Embed(source="../../../../media/sounds/apartment/cupboardOpen.mp3")]
        public static const KitchenCupboardOpen:Class;
        [Embed(source="../../../../media/sounds/apartment/cupboardClose.mp3")]
        public static const KitchenCupboardClose:Class;
        [Embed(source="../../../../media/sounds/apartment/props/microwave/microwaveClose.mp3")]
        public static const KitchenMicrowaveClose:Class;
        [Embed(source="../../../../media/sounds/apartment/props/microwave/microwaveOpen.mp3")]
        public static const KitchenMicrowaveOpen:Class;
        [Embed(source="../../../../media/sounds/apartment/props/microwave/microwaveRunning.mp3")]
        public static const KitchenMicrowaveRunning:Class;
        [Embed(source="../../../../media/sounds/apartment/props/microwave/microwaveBeep.mp3")]
        public static const KitchenMicrowaveBeep:Class;
        [Embed(source="../../../../media/sounds/apartment/pickUpDogFood.mp3")]
        public static const DogFoodPickup:Class;
        [Embed(source="../../../../media/sounds/apartment/pourDogFood.mp3")]
        public static const DogFoodPour:Class;
        [Embed(source="../../../../media/sounds/apartment/dropDogBowl.mp3")]
        public static const DropDogBowl:Class;
        [Embed(source="../../../../media/sounds/notifications/success-high.mp3")]
        public static const SuccessHigh:Class;
        /*
         *
         * Notification Sounds
         *
         */
        [Embed(source="../../../../media/sounds/notifications/success-medium.mp3")]
        public static const SuccessMedium:Class;
        [Embed(source="../../../../media/sounds/notifications/success-low.mp3")]
        public static const SuccessLow:Class;
        [Embed(source="../../../../media/sounds/animals/dog-woof.mp3")]
        public static const DogWoof:Class;
        /*
         *
         * Animal Sounds
         *
         */
        [Embed(source="../../../../media/sounds/ecg/heartbeat.mp3")]
        public static const HeartBeat:Class;
        /*
         *
         * ECG Sounds
         *
         */
        [Embed(source="../../../../media/sounds/vehicles/car-trunk-unlock-01.mp3")]
        public static const UnlockCompartment:Class;
        /*
         *
         * Vehicle Sounds
         *
         */
        [Embed(source="../../../../media/sounds/vehicles/car-door-open-01.mp3")]
        public static const CarDoorOpen:Class;
        [Embed(source="../../../../media/sounds/vehicles/car-handbrake-01.mp3")]
        public static const CarHandBrake:Class;
        [Embed(source="../../../../media/sounds/vehicles/car-central-lock-01.mp3")]
        public static const CarLock:Class;
        [Embed(source="../../../../media/sounds/vehicles/car-drive-away.mp3")]
        public static const CarDriveAway:Class;
        [Embed(source="../../../../media/sounds/electric/power-down.mp3")]
        public static const PowerDownElectric:Class;
        /*
         * Electric
         */
        /**
         * Props
         */
        [Embed(source="../../../../media/sounds/props/metal-fence-open.mp3")]
        public static const MetalGateOpen:Class;
        [Embed(source="../../../../media/sounds/ladder/steps.mp3")]
        public static const LadderSteps:Class;
        [Embed(source="../../../../media/sounds/items/toolbox.mp3")]
        public static const ToolboxOpen:Class;
        [Embed(source="../../../../media/sounds/items/crowbar.mp3")]
        public static const CrowbarSound:Class;
        [Embed(source="../../../../media/sounds/breaking/opening-window.mp3")]
        public static const WindowBreak:Class;
        [Embed(source="../../../../media/sounds/ladder/lay-down.mp3")]
        public static const LadderLayDown:Class;
        [Embed(source="../../../../media/sounds/props/brick-scrape.mp3")]
        public static const Bricks:Class;
        [Embed(source="../../../../media/sounds/moments/door_unlock.mp3")]
        public static const FenceUnlock:Class;
        [Embed(source="../../../../media/sounds/props/cable-swinging.mp3")]
        public static const CableSwinging:Class;
        [Embed(source="../../../../media/sounds/props/digi-cuffs.mp3")]
        public static const DigiCuffsFastened:Class;
        [Embed(source="../../../../media/sounds/props/duct-tape.mp3")]
        public static const DuctTape:Class;
        [Embed(source="../../../../media/sounds/props/fastening-backpack.mp3")]
        public static const FastenBackpack:Class;
        [Embed(source="../../../../media/sounds/dialogue/phone/calling-someone.mp3")]
        public static const CallingSomeone:Class;
        [Embed(source="../../../../media/sounds/apartment/water-glass-fill-02.mp3")]
        public static const FillUpGlassWithWater:Class;
        [Embed(source="../../../../media/sounds/general/slide-latch.mp3")]
        public static const SlideLatch:Class;
        [Embed(source="../../../../media/sounds/general/cable-whoosh.mp3")]
        public static const CableWhoosh:Class;
        
		// Been Seen in Compound
		[Embed(source = "../../../../media/sounds/dialogue/level1/dawson/dawson-yell.mp3")]
		public static const CompoundBeenSeen:Class;
		
		[Embed(source = "../../../../media/sounds/dialogue/level1/jake/7-hey-boss-are-you-in-there.mp3")]
		public static const JakeYelling:Class;
		
		[Embed(source = "../../../../media/sounds/dialogue/level1/jake/11-compound-hes-gone.mp3")]
		public static const JakeHeHasGone:Class;
		
		
		/**
         *  Music Themes
         */
        //[Embed(source = "../../../../media/tracks/welcome_menu_loop.mp3")]
        [Embed(source="../../../../media/tracks/main/bk_main_menu.mp3")]
        public static const WelcomeMenuThemeSong:Class;
		
		[Embed(source = "../../../../media/tracks/main/bk_main_menu_short.mp3")]
        public static const ScoreMenuTheme:Class;
		
		
		
        /**
         *  Initialise Sound Objects
         */

        //theme tunes
        public static var welcomeMenuTheme:Sound = new SoundAssets.WelcomeMenuThemeSong() as Sound;
        public static var scoreMenuTheme:Sound = new SoundAssets.ScoreMenuTheme() as Sound;
        public static var discoveryTrackGoodLong:Sound = new SoundAssets.DiscoveryTrackGoodLong() as Sound;
        public static var discoveryTrackGoodShort:Sound = new SoundAssets.DiscoveryTrackGoodShort() as Sound;
        public static var discoveryTrackLongBad:Sound = new SoundAssets.DiscoveryTrackBadLong() as Sound;
        public static var trackIntroLevel:Sound = new SoundAssets.TrackIntroLevel() as Sound;
        public static var warningTrack:Sound = new SoundAssets.WarningTrack() as Sound;
        public static var newLocationTrack:Sound = new SoundAssets.NewLocationTrack() as Sound;
        public static var dangerTrack:Sound = new SoundAssets.DangerTrack() as Sound;
        //ambience tracks
        public static var slumsAmbience:Sound = new SoundAssets.SlumsAmbienceSound() as Sound;
        public static var carInteriorAmbience:Sound = new SoundAssets.CarInteriorAmbience() as Sound;
        public static var apartmentIntroBegin:Sound = new SoundAssets.ApartmentIntroBegin() as Sound;
        // moments
        public static var walkToDoorAndOpen:Sound = new SoundAssets.WalkToDoorAndOpen() as Sound;
        //button sounds
        public static var buttonBeep1:Sound = new SoundAssets.MenuButtonBeep1() as Sound;
        public static var buttonBeep2:Sound = new SoundAssets.MenuButtonBeep2() as Sound;
        public static var buttonBeep3:Sound = new SoundAssets.MenuButtonBeep3() as Sound;
        public static var buttonMessageBeep1:Sound = new SoundAssets.MenuButtonBeepMessage1() as Sound;
        public static var buttonMaximiseBeep1:Sound = new SoundAssets.MenuButtonBeepMaximise1() as Sound;
        public static var buttonMinimiseBeep1:Sound = new SoundAssets.MenuButtonBeepMinimise1() as Sound;
        public static var buttonClick1:Sound = new SoundAssets.MenuButtonClick1() as Sound;
        public static var buttonClick2:Sound = new SoundAssets.MenuButtonClick2() as Sound;
        public static var buttonClick3:Sound = new SoundAssets.MenuButtonClick3() as Sound;
        //Apartment Sounds
        public static var apartmentLightSwitchOn:Sound = new SoundAssets.ApartmentLightSwitchOn() as Sound;
        public static var apartmentLightSwitchOff:Sound = new SoundAssets.ApartmentLightSwitchOff() as Sound;
        public static var apartmentMobilePhoneRinging:Sound = new SoundAssets.ApartmentMobilePhoneRinging() as Sound;
        public static var apartmentCityAmbienceMild:Sound = new SoundAssets.ApartmentCityAmbienceMild() as Sound;
        public static var apartmentDoorOpen:Sound = new SoundAssets.ApartmentDoorOpen() as Sound;
        public static var apartmentDoorClose:Sound = new SoundAssets.ApartmentDoorClose() as Sound;
        public static var apartmentBedroomChestOpen:Sound = new SoundAssets.ApartmentBedroomChestOpen() as Sound;
        public static var apartmentBedroomChestClose:Sound = new SoundAssets.ApartmentBedroomChestClose() as Sound;
        public static var clothingPickup:Sound = new SoundAssets.ClothingPickup() as Sound;
        public static var clothingGetOut:Sound = new SoundAssets.ClothingGetOut() as Sound;
        public static var bedroomShower:Sound = new SoundAssets.BedroomShower() as Sound;
        public static var kitchenCupboardOpen:Sound = new SoundAssets.KitchenCupboardOpen() as Sound;
        public static var kitchenCupboardClose:Sound = new SoundAssets.KitchenCupboardClose() as Sound;
        public static var dogFoodPickup:Sound = new SoundAssets.DogFoodPickup() as Sound;
        public static var dogFoodPour:Sound = new SoundAssets.DogFoodPour() as Sound;
        public static var dropDogBowl:Sound = new SoundAssets.DropDogBowl() as Sound;
        public static var kitchenMicrowaveClose:Sound = new SoundAssets.KitchenMicrowaveClose() as Sound;
        public static var kitchenMicrowaveOpen:Sound = new SoundAssets.KitchenMicrowaveOpen() as Sound;
        public static var kitchenMicrowaveRunning:Sound = new SoundAssets.KitchenMicrowaveRunning() as Sound;
        public static var kitchenMicrowaveBeep:Sound = new SoundAssets.KitchenMicrowaveBeep() as Sound;
        // vehicles
        public static var unlockCompartment:Sound = new SoundAssets.UnlockCompartment() as Sound;
        public static var carDoorOpen:Sound = new SoundAssets.CarDoorOpen() as Sound;
        public static var carHandBrake:Sound = new SoundAssets.CarHandBrake() as Sound;
        public static var carLock:Sound = new SoundAssets.CarLock() as Sound;
        public static var carDriveAway:Sound = new SoundAssets.CarDriveAway() as Sound;
        //notification sounds
        public static var notificationSuccessHigh:Sound = new SoundAssets.SuccessHigh() as Sound;
        public static var notificationSuccessMedium:Sound = new SoundAssets.SuccessMedium() as Sound;
        public static var notificationSuccessLow:Sound = new SoundAssets.SuccessLow() as Sound;
        //animal sounds
        public static var dogWoof:Sound = new SoundAssets.DogWoof() as Sound;
        // heartbeat sounds
        public static var heartBeat:Sound = new SoundAssets.HeartBeat() as Sound;
        public static var fanGenerator:Sound = new SoundAssets.FanGenerator() as Sound;
        public static var powerDown:Sound = new SoundAssets.PowerDownElectric() as Sound;
        public static var metalGateOpen:Sound = new SoundAssets.MetalGateOpen() as Sound;
        public static var ladderSteps:Sound = new SoundAssets.LadderSteps() as Sound;
        public static var toolboxOpen:Sound = new SoundAssets.ToolboxOpen() as Sound;
        public static var crowbarSound:Sound = new SoundAssets.CrowbarSound() as Sound;
        public static var windowBreak:Sound = new SoundAssets.WindowBreak() as Sound;
        public static var ladderLayDown:Sound = new SoundAssets.LadderLayDown() as Sound;
        public static var bricks:Sound = new SoundAssets.Bricks() as Sound;
        public static var fenceUnlock:Sound = new SoundAssets.FenceUnlock() as Sound;
        public static var cableSwinging:Sound = new SoundAssets.CableSwinging() as Sound;
        public static var digiCuffsFastened:Sound = new SoundAssets.DigiCuffsFastened() as Sound;
        public static var ductTape:Sound = new SoundAssets.DuctTape() as Sound;
        public static var fastenBackpack:Sound = new SoundAssets.FastenBackpack() as Sound;
        public static var callingSomeone:Sound = new SoundAssets.CallingSomeone() as Sound;
        public static var fillUpGlassWithWater:Sound = new SoundAssets.FillUpGlassWithWater() as Sound;
        public static var slideLatch:Sound = new SoundAssets.SlideLatch() as Sound;
        public static var cableWhoosh:Sound = new SoundAssets.CableWhoosh() as Sound;
		
		static public var compoundBeenSeen:Sound = new SoundAssets.CompoundBeenSeen() as Sound;
		static public var jakeYelling:Sound = new SoundAssets.JakeYelling() as Sound;
		static public var jakeHeHasGone:Sound = new SoundAssets.JakeHeHasGone() as Sound;
    }
}
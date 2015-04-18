package assets
{
    import starling.textures.Texture;

    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author Shaun Stone
     */
    public class RileyApartmentAssets
    {
        //create a dictionary class
        /**
         * Background
         */
        public static const APARTMENT_BACKGROUND:String = "RileysApartmentBackground";
        //create an atlas class
        public static const APARTMENT_FOREGROUND:String = "RileysApartmentForeground";
        [Embed(source="../../../media/images/apartment/backgrounds/rileysApartmentBg.jpg")]
        public static const RileysApartmentBackground:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentKitchenLights.png")]
        public static const KitchenLightsOn:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentKitchenDark.png")]
        public static const KitchenDark:Class;
        /**
         * End of Background
         */
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentLivingroomDaylight.png")]
        public static const LivingroomDaylight:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentLivingroomLightOn.png")]
        public static const LivingroomLightsOn:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentLivingroomDark.png")]
        public static const LivingroomDark:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentBedroomDaylight.png")]
        public static const BedroomDaylight:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentBedroomLight.png")]
        public static const BedroomLightsOn:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentBedroomDark.png")]
        public static const BedroomDark:Class;
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentBedroomShade.png")]
        public static const BedroomShade:Class;
        /**
         * Interactive Props
         **/
        public static const BED:String = "bedroom/bed/bedroomBed";
        public static const BEDROOM_COVER_DONE:String = "bedroom/bed/bedroomCoverDone";
        public static const BEDROOM_COVER_UNDONE:String = "bedroom/bed/bedroomCoverUndone";
        /**
         * End of Foreground
         */
        public static const BEDROOM_CHEST:String = "bedroom/bedroom-chest/bedroomChest";
        public static const BEDROOM_CHEST_DRAW:String = "bedroom/bedroom-chest/bedroomDraw";
        public static const BEDROOM_LAMP_OFF:String = "bedroom/lamp/lampOff";
        public static const BEDROOM_PLANTPOT:String = "bedroom/plantpot/plantPot";
        public static const BEDROOM_PLUGS:String = "bedroom/switches/plugs";
        public static const BEDROOM_SWITCH_OFF:String = "bedroom/switches/switchOff";
        public static const BEDROOM_SWITCH_ON:String = "bedroom/switches/switchOn";
        public static const BEDROOM_WASHING_BASKET_CLOSED:String = "bedroom/washing-basket/washingBasketClosed";
        public static const BEDROOM_WASHING_BASKET_OPEN:String = "bedroom/washing-basket/washingBasketOpen";
        public static const BEDROOM_WINDOW:String = "window/bedroomWindow";
        public static const BEDROOM_CANVAS_PHOTO:String = "bedroom/canvas/canvasPhoto";
        public static const BEDROOM_SAX_PHOTO:String = "bedroom/canvas/saxophonist";
        public static const BEDROOM_BEDSIDE_CABINET:String = "bedroom/bedroom-cabinet/bedroomCabinet";
        public static const DOOR_OPEN:String = "doors/doorOpen";
        public static const DOOR_CLOSED:String = "doors/doorClosed";
        public static const KITCHEN_BINBAG_OPEN:String = "kitchen/binbag/binBagOpen";
        public static const KITCHEN_CONVECTOR:String = "kitchen/convector/convectorOff";
        public static const KITCHEN_COOKER_OFF:String = "kitchen/cooker/cookerOff";
        public static const KITCHEN_COOKER_ON:String = "kitchen/cooker/cookerOn";
        public static const KITCHEN_DARK_CUPBOARD_CLOSED:String = "kitchen/cupboards/darkCupboardClosed";
        public static const KITCHEN_DARK_CUPBOARD_SIDE_CLOSED:String = "kitchen/cupboards/darkCupboardSideClosed";
        public static const KITCHEN_DARK_CUPBOARD_OPEN:String = "kitchen/cupboards/darkCupboardOpen";
        public static const KITCHEN_DARK_CUPBOARD_SIDE_OPEN:String = "kitchen/cupboards/darkCupboardSideOpen";
        public static const KITCHEN_LIGHT_CUPBOARD_CLOSED:String = "kitchen/cupboards/lightCupboardClosed";
        public static const KITCHEN_LIGHT_CUPBOARD_OPEN:String = "kitchen/cupboards/lightCupboardOpen";
        public static const KITCHEN_MICROWAVE_FINISHED:String = "kitchen/microwave/microwaveFinished";
        public static const KITCHEN_MICROWAVE_OFF:String = "kitchen/microwave/microwaveOff";
        public static const KITCHEN_MICROWAVE_RUNNING:String = "kitchen/microwave/microwaveRunning";
        public static const KITCHEN_SINK_OFF:String = "kitchen/sink/sinkOff";
        public static const LIVING_ROOM_SMART_WINDOW_FRAME:String = "window/smartWindowFrame";
        public static const LIVING_ROOM_SMART_WINDOW_SCREEN:String = "window/smartWindowScreen";
        public static const LIVING_ROOM_RUG:String = "living-room/flooring/livingRoomRug";
        //public static const LIVING_ROOM_CURTAINS_CLOSED:String  = "living-room/curtains/curtainsClosed";
        //public static const LIVING_ROOM_CURTAINS_OPEN:String  = "living-room/curtains/curtainsOpen";
        public static const LIVING_ROOM_WELCOME_MATT:String = "living-room/flooring/welcomeMatt";
        public static const LIVING_ROOM_COFFEE_TABLE:String = "living-room/furniture/coffeeTable";
        public static const LIVING_ROOM_TV_CABINET:String = "living-room/furniture/tvCabinet";
        public static const LIVING_ROOM_SOFA_OFF:String = "living-room/sofa/sofaOff";
        public static const LIVING_ROOM_SPEAKER_LEFT:String = "living-room/speakers/speakerLeft";
        public static const LIVING_ROOM_SPEAKER_RIGHT:String = "living-room/speakers/speakerRight";
        public static const LIVING_ROOM_TV_REMOTE:String = "living-room/television/remote";
        public static const LIVING_ROOM_TV_OFF:String = "living-room/television/televisionOff";
        public static const LIVING_ROOM_PHOTO:String = "living-room/photo/dovesPhoto";
        public static const LIVING_ROOM_DOG_BED:String = "living-room/dog-bed/dog-bed";
        public static const BEDROOM_BLINDS_CLOSED:String = "window/bedroomWindowClosedBlinds";
        public static const BEDROOM_BLINDS_OPEN:String = "window/bedroomWindowOpenBlinds";
        public static const BEDROOM_MOBILE_OFF:String = "phone/phone";
        public static const BEDROOM_MOBILE_ON:String = "phone/phone-ringing";
        [Embed(source="../../../media/images/apartment/rileysApartment.png")]
        public static const RileysApartmentTextureAtlas:Class;
        [Embed(source="../../../media/images/apartment/rileysApartment.xml", mimeType="application/octet-stream")]
        public static const RileysApartmentXML:Class;
        /**
         * Foreground
         */

        //get foregrounds fopr all rooms (light, night, daylight)
        [Embed(source="../../../media/images/apartment/foregrounds/apartmentKitchenDaylight.png")]
        public static const KitchenDaylight:Class;
        // Texture Atlas
        private static var gameTextures:Dictionary = new Dictionary();
        //XML
        private static var gameTextureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("RileysApartmentTextureAtlas");
                var xml:XML = XML(new RileysApartmentXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new RileyApartmentAssets[name]();
                gameTextures[name] = Texture.fromBitmap(bitmap);
            }
            return gameTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in gameTextures) {
                gameTextures[i].dispose();
            }
        }
    }
}
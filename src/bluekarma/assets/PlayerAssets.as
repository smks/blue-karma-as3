package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PlayerAssets
    {
        public static const RILEY_PLAYER:String = "riley";
        public static const RILEY_PYJAMAS_PLAYER:String = "riley_pyjamas";
        public static const RILEY_SLEEP:String = "riley_sleep";
        public static const RILEY_SITTING:String = "riley_sitting";
        public static const RILEY_SITTING_LOOKING_OUT_WINDOW:String = "riley_sitting_look_out_window";
        public static const RILEY_SITTING_LOOKING_AT_DRIVER:String = "riley_sitting_look_at_driver";
        public static const RILEY_STANDING_LADDER:String = "riley_standing_ladder";
        //create a dictionary class
        [Embed(source="../../../media/sprites/players/riley/Riley.xml", mimeType="application/octet-stream")]
        public static const PlayerRileyXML:Class;
        //create an atlas class
        [Embed(source="../../../media/sprites/players/riley/RileyPyjamas.xml", mimeType="application/octet-stream")]
        public static const PlayerRileyPyjamasXML:Class;
        [Embed(source="../../../media/sprites/players/riley/RileyBed.xml", mimeType="application/octet-stream")]
        public static const PlayerRileyBedXML:Class;
        /**
         * Riley Sprites for sitting in Vehicle
         */
        [Embed(source="../../../media/sprites/players/riley/RileySittingVehicle.png")]
        public static const PlayerRileySittingVehicle:Class;
        [Embed(source="../../../media/sprites/players/riley/RileySittingVehicle.xml", mimeType="application/octet-stream")]
        public static const PlayerRileySittingVehicleXML:Class;
        //Embed XML Data of Riley Sprites
        [Embed(source="../../../media/sprites/players/riley/riley_stand_ladder/RileyLadder.png")]
        public static const PlayerRileyStandingLadder:Class;
        [Embed(source="../../../media/sprites/players/riley/riley_stand_ladder/RileyLadder.xml", mimeType="application/octet-stream")]
        public static const PlayerRileyStandingLadderXML:Class;
        //Embed XML Data of Riley Sprites
        /**
         * Riley Sprites Work Clothing
         */

        //Embed PNG Riley Sprites for main player interaction
        [Embed(source="../../../media/sprites/players/riley/Riley.png")]
        public static const PlayerRileyAtlasTextures:Class;
        /**
         * Riley Sprites Pyjamas
         */

        //Embed PNG Riley Sprites for main player interaction
        [Embed(source="../../../media/sprites/players/riley/RileyPyjamas.png")]
        public static const PlayerRileyPyjamasAtlasTextures:Class;
        //Embed XML Data of Riley Sprites
        /**
         * Riley Sprites Pyjamas in Bed
         */

        //Assets for Riley in bed
        [Embed(source="../../../media/sprites/players/riley/RileyBed.png")]
        public static const PlayerRileyBedAtlasTextures:Class;
        private static var playerTextures:Dictionary = new Dictionary();
        private static var playerTextureAtlas:TextureAtlas;
        // Look at Driver
        private static var playerPyjamasTextureAtlas:TextureAtlas;
        private static var playerBedTextureAtlas:TextureAtlas;
        // Look out window
        private static var playerSittingTextureAtlas:TextureAtlas;
        private static var playerSittingDriverTextureAtlas:TextureAtlas;
        // Riley on Ladder
        private static var playerSittingWindowTextureAtlas:TextureAtlas;
        private static var playerLadderAtlas:TextureAtlas;
        // End #####################
        public static function getAtlas(name:String = RILEY_PLAYER):TextureAtlas
        {
            var texture:Texture;
            var xml:XML;
            switch (name) {
                case RILEY_PLAYER:
                    if (playerTextureAtlas == null) {
                        texture = getTexture("PlayerRileyAtlasTextures");
                        xml = XML(new PlayerRileyXML());
                        //create a new atlas
                        playerTextureAtlas = new TextureAtlas(texture, xml);
                    }
                    return playerTextureAtlas;
                    break;
                case RILEY_PYJAMAS_PLAYER:
                    if (playerPyjamasTextureAtlas == null) {
                        texture = getTexture("PlayerRileyPyjamasAtlasTextures");
                        xml = XML(new PlayerRileyPyjamasXML());
                        //create a new atlas
                        playerPyjamasTextureAtlas = new TextureAtlas(texture, xml);
                    }
                    return playerPyjamasTextureAtlas;
                    break;
                case RILEY_SLEEP:
                    if (playerBedTextureAtlas == null) {
                        texture = getTexture("PlayerRileyBedAtlasTextures");
                        xml = XML(new PlayerRileyBedXML());
                        //create a new atlas
                        playerBedTextureAtlas = new TextureAtlas(texture, xml);
                    }
                    return playerBedTextureAtlas;
                    break;
                case RILEY_SITTING:
                    if (playerSittingTextureAtlas == null) {
                        texture = getTexture("PlayerRileySittingVehicle");
                        xml = XML(new PlayerRileySittingVehicleXML());
                        //create a new atlas
                        playerSittingTextureAtlas = new TextureAtlas(texture, xml);
                    }
                    return playerSittingTextureAtlas;
                    break;
                case RILEY_STANDING_LADDER:
                    if (playerLadderAtlas == null) {
                        texture = getTexture("PlayerRileyStandingLadder");
                        xml = XML(new PlayerRileyStandingLadderXML());
                        //create a new atlas
                        playerLadderAtlas = new TextureAtlas(texture, xml);
                    }
                    return playerLadderAtlas;
                    break;
                default:
                    throw new Error("no atlas recognised");
            }
        }

        public static function getTexture(name:String):Texture
        {
            if (playerTextures[name] == undefined) {
                var bitmap:Bitmap = new PlayerAssets[name]();
                playerTextures[name] = Texture.fromBitmap(bitmap);
            }
            return playerTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in playerTextures) {
                playerTextures[i].dispose();
            }
        }
    }
}
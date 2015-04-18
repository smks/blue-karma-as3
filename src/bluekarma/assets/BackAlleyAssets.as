package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;

    /**
     * This is an asset file for BackAlley
     * @author Shaun Stone - Blue Karma
     */
    public class BackAlleyAssets
    {
        public static const CABLES:String = "cables";
        public static const CABLE_HANGING:String = "cable-hanging";
        public static const FAN:String = "fan";
        public static const FAN_PANEL_CLOSED:String = "fan-panel-closed";
        public static const FAN_PANEL_OPEN:String = "fan-panel-open";
        public static const FAN_PANEL_SWITCH:String = "fan-panel-switch";
        public static const FAN_BLADES:String = "fan-blades";
        public static const FAN_BLADE_CENTER:String = "fan-blade-center";
        public static const FRAME:String = "frame";
        public static const LADDER:String = "ladder";
        public static const LADDER_EXT:String = "ladder-ext";
        public static const ROOF_LEFT:String = "roof";
        public static const ROOF_RIGHT:String = "roof-2";
        public static const WINDOW_CLOSED:String = "window-closed";
        public static const WINDOW_OPEN:String = "window-open";
        public static const WINDOW_LEDGE:String = "window-ledge";
        public static const METAL_FENCE_BIG:String = "fence";
        public static const METAL_FENCE_DOOR_OPEN:String = "metal_fence_door_open";
        public static const METAL_FENCE_DOOR_CLOSED:String = "metal_fence_door_shut";
        public static const TOOLBOX:String = "toolbox";
        public static const TOOLBOX_OPEN:String = "toolbox-open";
        public static const RUBBISH:String = "rubbish";
        public static const BIN:String = "bin";
        public static const BRICK:String = "brick";
        public static const TOOLBOX_KEY:String = "toolbox-key-floor";
        public static const FAN_KEYS:String = "fan-keys-floor";
        public static const CROWBAR:String = "crowbar";
        public static const FOREGROUND_BIN_LEFT:String = "bin-left";
        public static const FOREGROUND_BIN_RIGHT:String = "bin-right";
		
        //create a dictionary class to hold assets
        [Embed(source="../../../media/images/back-alley/BackAlley.png")]
        public static const BackAlleyTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../media/images/back-alley/BackAlley.xml", mimeType="application/octet-stream")]
        public static const BackAlleyTextureAtlasXML:Class;
        // add Texture atlas for BackAlley
        [Embed(source="../../../media/images/back-alley/BackAlley.jpg")]
        public static const BackAlleyBackgroundImage:Class;
        // add Texture Atlas XML for BackAlley
        static public const MIRROR:String = "mirror";
        //Get Background BackAlley as separate image as too big for spritesheet
        private static var gameTextures:Dictionary = new Dictionary();
        private static var gameTextureAtlas:TextureAtlas;
        // Get the atlas for BackAlley
        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("BackAlleyTextureAtlas");
                var xml:XML = XML(new BackAlleyTextureAtlasXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        // Get a single texture from this class BackAlley
        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new BackAlleyAssets[name]();
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
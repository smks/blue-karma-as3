package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;

    /**
     * This is an asset file for Compound
     * @author Shaun Stone - Blue Karma
     */
    public class CompoundAssets
    {
        static public const MIRROR:String = "mirror";
        static public const BACKPACK:String = "backpack";
        static public const CHAIR:String = "chair";
        static public const CABINET:String = "cabinet";
        static public const CORKBOARD:String = "corkboard";
        static public const DOOR_OPEN:String = "door-open";
        static public const DOOR_CLOSED:String = "door-closed";
        static public const INCOGNITIVEMASK:String = "incognitive-mask-laying";
        static public const PLASTICBAG_1:String = "plastic-bag-1";
        static public const PLASTICBAG_2:String = "plastic-bag-2";
        static public const PLASTICBAG_3:String = "plastic-bag-3";
        static public const PLASTICBAG_4:String = "plastic-bag-4";
        static public const SOFA:String = "sofa";
        static public const STATIONARY:String = "stationary";
        static public const WINDOW:String = "window";
        static public const MASKING_TAPE:String = "masking-tape";
        //create a dictionary class to hold assets
        [Embed(source="../../../media/images/compound/interactive/Compound.png")]
        public static const CompoundTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../media/images/compound/interactive/Compound.xml", mimeType="application/octet-stream")]
        public static const CompoundTextureAtlasXML:Class;
        // add Texture atlas for Compound
        [Embed(source="../../../media/images/compound/CompoundBg.png")]
        public static const CompoundBackgroundImage:Class;
        // add Texture Atlas XML for Compound
        [Embed(source="../../../media/images/compound/CompoundFg.png")]
        public static const CompoundForegroundImage:Class;
        //Get Background Compound as separate image as too big for spritesheet
        [Embed(source="../../../media/images/compound/CompoundFgShade.png")]
        public static const CompoundForegroundShadeImage:Class;
        private static var gameTextures:Dictionary = new Dictionary();
        private static var gameTextureAtlas:TextureAtlas;
        // Get the atlas for Compound
        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("CompoundTextureAtlas");
                var xml:XML = XML(new CompoundTextureAtlasXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        // Get a single texture from this class Compound
        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new CompoundAssets[name]();
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
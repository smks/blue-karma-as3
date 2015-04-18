package bluekarma.assets.settings.backgrounds.albertscar
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AlbertJourneyAssets
    {
        public static const MID_COMP:String = "middle-compartment";
        public static const MID_COMP_OPEN:String = "middle-compartment-open";
        //create a dictionary class
        [Embed(source="../../../../../../media/images/alberts-vehicle/AlbertsVehicle.png")]
        public static const AlbertJourneyTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../../../../media/images/alberts-vehicle/AlbertsVehicle.xml", mimeType="application/octet-stream")]
        public static const AlbertJourneyXML:Class;
        // Texture Atlas
        [Embed(source="../../../../../../media/images/alberts-vehicle/background/background.png")]
        public static var CarBackground:Class;
        //XML
        [Embed(source="../../../../../../media/images/alberts-vehicle/background/background-shadow.png")]
        public static var CarBackgroundShadow:Class;
        [Embed(source="../../../../../../media/images/alberts-vehicle/foreground/foreground-original.png")]
        public static var CarForeground:Class;
		
		[Embed(source="../../../../../../media/images/alberts-vehicle/foreground/foreground.png")]
        public static var CarForegroundShadow:Class;
        private static var gameTextures:Dictionary = new Dictionary();
        private static var gameTextureAtlas:TextureAtlas;

        /**
         *
         * @param    name
         * @return
         */

        public static function getAtlas(name:String = ''):TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("AlbertJourneyTextureAtlas");
                var xml:XML = XML(new AlbertJourneyXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new AlbertJourneyAssets[name]();
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
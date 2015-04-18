package assets.settings.backgrounds.albertscar.moving
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author Shaun Stone
     */
    public class MovingBackgroundSlumsAssets
    {
        //create a dictionary class
        [Embed(source="../../../../../../../media/images/alberts-vehicle/moving-slums/MovingBackgroundSlums.png")]
        public static const MovingBackgroundSlumsTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../../../../../media/images/alberts-vehicle/moving-slums/MovingBackgroundSlums.xml", mimeType="application/octet-stream")]
        public static const MovingBackgroundSlumsXML:Class;
        // Texture Atlas
        private static var gameTextures:Dictionary = new Dictionary();
        //XML
        private static var gameTextureAtlas:TextureAtlas;
        // Get texture atlas
        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("MovingBackgroundSlumsTextureAtlas");
                var xml:XML = XML(new MovingBackgroundSlumsXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new MovingBackgroundSlumsAssets[name]();
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
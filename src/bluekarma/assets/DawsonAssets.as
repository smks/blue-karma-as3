package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;

    /**
     * This is an asset file for Dawson
     * @author Shaun Stone - Blue Karma
     */
    public class DawsonAssets
    {
        public static const CUFFED:String = "dawson-cuffed";
        public static const PACKING:String = "dawson-packing";
        //create a dictionary class to hold assets
        [Embed(source="../../../media/sprites/characters/slumsstreet/dawson/Dawson.png")]
        public static const DawsonTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../media/sprites/characters/slumsstreet/dawson/Dawson.xml", mimeType="application/octet-stream")]
        public static const DawsonTextureAtlasXML:Class;
        // add Texture atlas for Dawson
        private static var gameTextures:Dictionary = new Dictionary();
        // add Texture Atlas XML for Dawson
        private static var gameTextureAtlas:TextureAtlas;
        // Get the atlas for Dawson
        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("DawsonTextureAtlas");
                var xml:XML = XML(new DawsonTextureAtlasXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        /**
         * Get a single texture from this class Dawson
         */
        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new DawsonAssets[name]();
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
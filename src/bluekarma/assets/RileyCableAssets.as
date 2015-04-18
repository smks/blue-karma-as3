package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;

    /**
     * This is an asset file for RileyCable
     * @author Shaun Stone - Blue Karma
     */
    public class RileyCableAssets
    {
        public static const ASSET_NAME:String = 'riley_cable';
        //create a dictionary class to hold assets
        [Embed(source="../../../media/sprites/players/riley/riley_cable/RileyCable.png")]
        public static const RileyCableTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../media/sprites/players/riley/riley_cable/RileyCable.xml", mimeType="application/octet-stream")]
        public static const RileyCableTextureAtlasXML:Class;
        // Add Texture atlas for RileyCable
        private static var gameTextures:Dictionary = new Dictionary();
        // Add Texture Atlas XML for RileyCable
        private static var gameTextureAtlas:TextureAtlas;
        // Get the atlas for RileyCable
        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("RileyCableTextureAtlas");
                var xml:XML = XML(new RileyCableTextureAtlasXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        // Get a single texture from this class RileyCable
        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new RileyCableAssets[name]();
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
package bluekarma.assets.characters.albertscar
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AlbertAssets
    {
        public static const ALBERT_DRIVING:String = "albert_driving";
        //create a dictionary class
        [Embed(source="../../../../../media/sprites/characters/albert/Albert.png")]
        public static const AlbertTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../../../media/sprites/characters/albert/Albert.xml", mimeType="application/octet-stream")]
        public static const AlbertXML:Class;
        // Texture Atlas
        private static var gameTextures:Dictionary = new Dictionary();
        //XML
        private static var gameTextureAtlas:TextureAtlas;

        /**
         *
         * @param    name
         * @return
         */

        public static function getAtlas(name:String = ''):TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("AlbertTextureAtlas");
                var xml:XML = XML(new AlbertXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new AlbertAssets[name]();
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
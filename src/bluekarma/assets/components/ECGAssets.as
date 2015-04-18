package assets.components
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ECGAssets
    {
        //create a dictionary class
        [Embed(source="../../../../media/sprites/ecg/Ecg.png")]
        public static const ECGTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../../media/sprites/ecg/Ecg.xml", mimeType="application/octet-stream")]
        public static const ECGXML:Class;
        // Texture Atlas
        private static var gameTextures:Dictionary = new Dictionary();
        //XML
        private static var gameTextureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (gameTextureAtlas == null) {
                var texture:Texture = getTexture("ECGTextureAtlas");
                var xml:XML = XML(new ECGXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new ECGAssets[name]();
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
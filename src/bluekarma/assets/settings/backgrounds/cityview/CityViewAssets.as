package assets.settings.backgrounds.cityview
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author @shaun
     */
    public class CityViewAssets
    {

        //create a dictionary class
        [Embed(source="../../../../../../media/images/apartment/backgrounds/city_view/CityView.png")]
        public static const CityViewTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../../../../media/images/apartment/backgrounds/city_view/CityView.xml", mimeType="application/octet-stream")]
        public static const CityViewXML:Class;
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
                var texture:Texture = getTexture("CityViewTextureAtlas");
                var xml:XML = XML(new CityViewXML());
                //create a new atlas
                gameTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return gameTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new CityViewAssets[name]();
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
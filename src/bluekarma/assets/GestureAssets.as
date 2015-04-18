package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author @shaun
     */
    public class GestureAssets
    {

        //create a dictionary class
        [Embed(source="../../../media/gestures/Gestures.png")]
        public static const GesturesTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../media/gestures/Gestures.xml", mimeType="application/octet-stream")]
        public static const GesturesXML:Class;
        //Embed PNG Dog Bob
        private static var textures:Dictionary = new Dictionary();
        //Embed XML Data of Bob the Dog Sprites
        private static var textureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (textureAtlas == null) {
                var texture:Texture = getTexture("GesturesTextureAtlas");
                var xml:XML = XML(new GesturesXML());
                //create a new atlas
                textureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return textureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (textures[name] == undefined) {
                var bitmap:Bitmap = new GestureAssets[name]();
                textures[name] = Texture.fromBitmap(bitmap);
            }
            return textures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in textures) {
                textures[i].dispose();
            }
        }
    }
}
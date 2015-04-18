package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author Shaun Stone
     */
    public class PlaqueAssets
    {
		public static const ORBS:String = 'orbs';
		
        //create a dictionary
        [Embed(source="../../../media/images/phone-dialogue/plaques/plaques.png")]
        private static const PlaqueTexture:Class;
        //create an atlas
        [Embed(source="../../../media/images/phone-dialogue/plaques/plaques.xml", mimeType="application/octet-stream")]
        private static const PlaqueTextureXML:Class;
        private static var plaqueTextures:Dictionary = new Dictionary();
        private static var plaqueAtlas:TextureAtlas;

        public static function getAtlas(name:String = null):TextureAtlas
        {
            if (plaqueAtlas == null) {
                var texture:Texture = getTexture("PlaqueTexture");
                var xml:XML = XML(new PlaqueTextureXML());
                //create a new atlas
                plaqueAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return plaqueAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (plaqueTextures[name] == undefined) {
                var bitmap:Bitmap = new PlaqueAssets[name]();
                plaqueTextures[name] = Texture.fromBitmap(bitmap);
            }
            return plaqueTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in plaqueTextures) {
                plaqueTextures[i].dispose();
            }
        }
    }
}
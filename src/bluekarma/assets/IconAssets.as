package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author Shaun Stone
     */
    public class IconAssets
    {

        //create a dictionary class
        [Embed(source="../../../media/images/inventory/icons/inventory-icons.png")]
        public static const IconTexturesSpriteSheet:Class;
        //create an atlas class
        [Embed(source="../../../media/images/inventory/icons/inventory-icons.xml", mimeType="application/octet-stream")]
        public static const IconTexturesXML:Class;
        //Embed PNG Dog Bob
        private static var iconTextures:Dictionary = new Dictionary();
        //Embed XML Data of Bob the Dog Sprites
        private static var iconTextureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (iconTextureAtlas == null) {
                var texture:Texture = getTexture("IconTexturesSpriteSheet");
                var xml:XML = XML(new IconTexturesXML());
                //create a new atlas
                iconTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return iconTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (iconTextures[name] == undefined) {
                var bitmap:Bitmap = new IconAssets[name]();
                iconTextures[name] = Texture.fromBitmap(bitmap);
            }
            return iconTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i in gameTextures) {
                gameTextures[i].dispose();
            }
        }
    }
}
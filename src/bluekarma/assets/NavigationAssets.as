package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;

    /**
     * ...
     * @author Shaun Stone
     */
    public class NavigationAssets
    {
        //create a dictionary class
        [Embed(source="../../../media/buttons/arrow1-up.png")]
        public static const arrowGameButtonUp:Class;
        //create an atlases
        [Embed(source="../../../media/buttons/arrow1-down.png")]
        public static const arrowGameButtonDown:Class;
        /*
         *
         * Get Generic Buttons
         *
         * */
        private static var gameTextures:Dictionary = new Dictionary();
        private static var gameTextureAtlas:TextureAtlas;
        //public static const NavigationTextureAtlas:TextureAtlas;
        //public static const NavigationXML:Class;
        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new GameAssets[name]();
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
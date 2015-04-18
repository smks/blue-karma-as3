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
    public class ParticleAssets
    {
        //create a dictionary class
        private static var particleTextures:Dictionary = new Dictionary();
        //create an atlas class
        private static var particleTexturesAtlas:TextureAtlas;

        public static function getTexture(name:String):Texture
        {
            if (particleTextures[name] == undefined) {
                var bitmap:Bitmap = new ParticleAssets[name]();
                particleTextures[name] = Texture.fromBitmap(bitmap);
            }
            return particleTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in particleTextures) {
                particleTextures[i].dispose();
            }
        }
    }
}
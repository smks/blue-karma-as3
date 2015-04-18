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
    public class PropAssets
    {

        //create a dictionary class
        [Embed(source="../../../media/sprites/props/slums/cctv/cctv_frame.png")]
        public static const CCTVFrame:Class;
        //create an atlas class
        [Embed(source="../../../media/sprites/props/slums/cctv/cctv.png")]
        public static const CCTVTextureAtlas:Class;
        //Embed cctv frame
        [Embed(source="../../../media/sprites/props/slums/cctv/cctv.xml", mimeType="application/octet-stream")]
        public static const CCTVXML:Class;
        //Embed PNG Dog Bob
        private static var propTextures:Dictionary = new Dictionary();
        //Embed XML Data of Bob the Dog Sprites
        private static var propTextureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (propTextureAtlas == null) {
                var texture:Texture = getTexture("CCTVTextureAtlas");
                var xml:XML = XML(new CCTVXML());
                //create a new atlas
                propTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return propTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (propTextures[name] == undefined) {
                var bitmap:Bitmap = new PropAssets[name]();
                propTextures[name] = Texture.fromBitmap(bitmap);
            }
            return propTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in propTextures) {
                propTextures[i].dispose();
            }
        }
    }
}
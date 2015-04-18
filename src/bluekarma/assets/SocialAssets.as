package assets
{
    import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.text.TextField;

	/**
     * This is an asset file for Social
     * @author Shaun Stone - Blue Karma
     */
    public class SocialAssets
    {
        public static const YOUTUBE:String = "youtube";
        public static const TWITTER:String = "twitter";
        public static const FACEBOOK:String = "facebook";
        public static const SMKS:String = "smks";
        //public static const IMAGE2:String = "";
        //public static const IMAGE3:String = "";
        //public static const IMAGE4:String = "";
        //public static const IMAGE5:String = "";

		//create a dictionary class to hold assets
		private static var gameTextures:Dictionary = new Dictionary();

		//create an atlas class
		private static var gameTextureAtlas:TextureAtlas;

        // add Texture atlas for Social
		[Embed(source = "../../../media/images/social-icons/Social.png")]
		public static const SocialTextureAtlas:Class;

        // add Texture Atlas XML for Social
		[Embed(source="../../../media/images/social-icons/Social.xml", mimeType = "application/octet-stream")]
		public static const SocialTextureAtlasXML:Class;

        // Get the atlas for Social
		public static function getAtlas():TextureAtlas {

			if (gameTextureAtlas == null) {

				var texture:Texture = getTexture("SocialTextureAtlas");
				var xml:XML = XML(new SocialTextureAtlasXML());

				//create a new atlas
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}

			//return atlas
			return gameTextureAtlas;
		}

        // Get a single texture from this class Social
        public static function getTexture(name:String):Texture {

            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new SocialAssets[name]();
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
package assets
{
    import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.text.TextField;

	/**
     * This is an asset file for ScoreMenu
     * @author Shaun Stone - Blue Karma
     */
    public class ScoreMenuAssets
    {
        public static const BK:String = "blue-karma";
        public static const THANKS:String = "thanks-for-playing";
        //public static const IMAGE2:String = "";
        //public static const IMAGE3:String = "";
        //public static const IMAGE4:String = "";
        //public static const IMAGE5:String = "";

		//create a dictionary class to hold assets
		private static var gameTextures:Dictionary = new Dictionary();

		//create an atlas class
		private static var gameTextureAtlas:TextureAtlas;

        // add Texture atlas for ScoreMenu
		[Embed(source = "../../../media/images/score/Scoreboard.png")]
		public static const ScoreMenuTextureAtlas:Class;

        // add Texture Atlas XML for ScoreMenu
		[Embed(source = "../../../media/images/score/Scoreboard.xml", mimeType = "application/octet-stream")]
		public static const ScoreMenuTextureAtlasXML:Class;

        // Get the atlas for ScoreMenu
		public static function getAtlas():TextureAtlas {

			if (gameTextureAtlas == null) {

				var texture:Texture = getTexture("ScoreMenuTextureAtlas");
				var xml:XML = XML(new ScoreMenuTextureAtlasXML());

				//create a new atlas
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}

			//return atlas
			return gameTextureAtlas;
		}

        // Get a single texture from this class ScoreMenu
        public static function getTexture(name:String):Texture {

            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new ScoreMenuAssets[name]();
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
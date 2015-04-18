package assets
{
    import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.text.TextField;

	/**
     * This is an asset file for GameScore
     * @author Shaun Stone - Blue Karma
     */
    public class GameScoreAssets
    {
        //public static const IMAGE1:String = "";
        //public static const IMAGE2:String = "";
        //public static const IMAGE3:String = "";
        //public static const IMAGE4:String = "";
        //public static const IMAGE5:String = "";

		//create a dictionary class to hold assets
		private static var gameTextures:Dictionary = new Dictionary();

		//create an atlas class
		private static var gameTextureAtlas:TextureAtlas;

        // add Texture atlas for GameScore
		[Embed(source = "../../../media/images/GameScore")]
		public static const GameScoreTextureAtlas:Class;

        // add Texture Atlas XML for GameScore
		[Embed(source = "../../../media/images/GameScore", mimeType = "application/octet-stream")]
		public static const GameScoreTextureAtlasXML:Class;

		//Get Background GameScore as separate image as too big for spritesheet
		[Embed(source="../../../media/images/GameScore.png")]
		public static const GameScoreBackgroundImage:Class;

        // Get the atlas for GameScore
		public static function getAtlas():TextureAtlas {

			if (gameTextureAtlas == null) {

				var texture:Texture = getTexture("GameScoreTextureAtlas");
				var xml:XML = XML(new GameScoreTextureAtlasXML());

				//create a new atlas
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}

			//return atlas
			return gameTextureAtlas;
		}

        // Get a single texture from this class GameScore
        public static function getTexture(name:String):Texture {

            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new GameScoreAssets[name]();
                gameTextures[name] = Texture.fromBitmap(bitmap);
			}

			return gameTextures[name];
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
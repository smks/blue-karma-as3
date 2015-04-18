package assets
{
    import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.text.TextField;

	/**
     * This is an asset file for MailAssets
     * @author Shaun Stone - Blue Karma
     */
    public class MailAssets
    {
        public static const MAIL_BUTTON:String = "mail-button";
        public static const MISSION_STATEMENT_DAWSON:String = "mission-statement-dawson";

		//create a dictionary class to hold assets
		private static var gameTextures:Dictionary = new Dictionary();

		//create an atlas class
		private static var gameTextureAtlas:TextureAtlas;

        // add Texture atlas for MailAssets
		[Embed(source = "../../../media/mail/Mail.png")]
		public static const MailAssetsTextureAtlas:Class;

        // add Texture Atlas XML for MailAssets
		[Embed(source = "../../../media/mail/Mail.xml", mimeType = "application/octet-stream")]
		public static const MailAssetsTextureAtlasXML:Class;

        // Get the atlas for MailAssets
		public static function getAtlas():TextureAtlas {
			if (gameTextureAtlas == null) {

				var texture:Texture = getTexture("MailAssetsTextureAtlas");
				var xml:XML = XML(new MailAssetsTextureAtlasXML());

				//create a new atlas
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			//return atlas
			return gameTextureAtlas;
		}

        // Get a single texture from this class MailAssets
        public static function getTexture(name:String):Texture {

            if (gameTextures[name] === undefined) {
                var bitmap:Bitmap = new MailAssets[name]();
                gameTextures[name] = Texture.fromBitmap(bitmap);
			}

			return gameTextures[name];
		}
	}
}
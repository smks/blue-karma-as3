package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.text.BitmapFont;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.text.TextField;
    import starling.text.TextField;

    /**
     * @author Shaun Stone
     */
    public class Level1CharacterAssets
    {
        //create a dictionary class
        [Embed(source="../../../media/sprites/characters/slumsstreet/level1Characters.png")]
        public static const CharactersLevel1AtlasTextures:Class;
        //create an atlas class
        [Embed(source="../../../media/sprites/characters/slumsstreet/level1Characters.xml", mimeType="application/octet-stream")]
        public static const Level1CharactersXML:Class;
        //Embed PNG Player Sprites
        private static var characterTextures:Dictionary = new Dictionary();
        //Embed XML Data of Player Sprites
        private static var charactersLevel1TextureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (charactersLevel1TextureAtlas == null) {
                var texture:Texture = getTexture("CharactersLevel1AtlasTextures");
                var xml:XML = XML(new Level1CharactersXML());
                //create a new atlas
                charactersLevel1TextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return charactersLevel1TextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (characterTextures[name] == undefined) {
                var bitmap:Bitmap = new Level1CharacterAssets[name]();
                characterTextures[name] = Texture.fromBitmap(bitmap);
            }
            return characterTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in characterTextures) {
                characterTextures[i].dispose();
            }
        }
    }
}
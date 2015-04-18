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
    public class CharacterDialogueAssets
    {
        //create a dictionary
        [Embed(source="../../../media/images/character-dialogue/level1.png")]
        private static const Level1CharacterDialogueTexture:Class;
        //create an atlas
        [Embed(source="../../../media/images/character-dialogue/level1.xml", mimeType="application/octet-stream")]
        private static const Level1CharacterDialogueXML:Class;
        private static var characterDialogueTextures:Dictionary = new Dictionary();
        private static var characterDialogueAtlas:TextureAtlas;

        public static function getAtlas(name:String = null):TextureAtlas
        {
            if (characterDialogueAtlas == null) {
                var texture:Texture = getTexture("Level1CharacterDialogueTexture");
                var xml:XML = XML(new Level1CharacterDialogueXML());
                //create a new atlas
                characterDialogueAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return characterDialogueAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (characterDialogueTextures[name] == undefined) {
                var bitmap:Bitmap = new CharacterDialogueAssets[name]();
                characterDialogueTextures[name] = Texture.fromBitmap(bitmap);
            }
            return characterDialogueTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i in characterDialogueTextures) {
                characterDialogueTextures[i].dispose();
            }
        }
    }
}
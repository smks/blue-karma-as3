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
    public class PhoneDialogueAssets
    {

        //create a dictionary
        [Embed(source="../../../media/images/phone-dialogue/phone_dialogue.png")]
        private static const PhoneDialogueTexture:Class;
        //create an atlas
        [Embed(source="../../../media/images/phone-dialogue/phone_dialogue.xml", mimeType="application/octet-stream")]
        private static const PhoneDialogueTextureXML:Class;
        [Embed(source="../../../media/images/phone-dialogue/phone_dialogue_bg.jpg")]
        private static const PhoneDialogueBackground:Class;
        private static var phoneDialogueTextures:Dictionary = new Dictionary();
        private static var phoneDialogueAtlas:TextureAtlas;

        public static function getAtlas(name:String = null):TextureAtlas
        {
            if (phoneDialogueAtlas == null) {
                var texture:Texture = getTexture("PhoneDialogueTexture");
                var xml:XML = XML(new PhoneDialogueTextureXML());
                //create a new atlas
                phoneDialogueAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return phoneDialogueAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (phoneDialogueTextures[name] == undefined) {
                var bitmap:Bitmap = new PhoneDialogueAssets[name]();
                phoneDialogueTextures[name] = Texture.fromBitmap(bitmap);
            }
            return phoneDialogueTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in phoneDialogueTextures) {
                phoneDialogueTextures[i].dispose();
            }
        }
    }
}
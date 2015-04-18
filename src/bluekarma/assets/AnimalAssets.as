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
    public class AnimalAssets
    {
        public static const DOG_BOB:String = "";
        public static const DOG_CRUNCH:String = "";
        //create a dictionary class
        [Embed(source="../../../media/sprites/animals/animals.png")]
        public static const AnimalsTextureAtlas:Class;
        //create an atlas class
        [Embed(source="../../../media/sprites/animals/animals.xml", mimeType="application/octet-stream")]
        public static const AnimalsXML:Class;
        //Embed PNG Dog Bob
        private static var animalTextures:Dictionary = new Dictionary();
        //Embed XML Data of Bob the Dog Sprites
        private static var animalTextureAtlas:TextureAtlas;

        public static function getAtlas():TextureAtlas
        {
            if (animalTextureAtlas == null) {
                var texture:Texture = getTexture("AnimalsTextureAtlas");
                var xml:XML = XML(new AnimalsXML());
                //create a new atlas
                animalTextureAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return animalTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (animalTextures[name] == undefined) {
                var bitmap:Bitmap = new AnimalAssets[name]();
                animalTextures[name] = Texture.fromBitmap(bitmap);
            }
            return animalTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in animalTextures) {
                animalTextures[i].dispose();
            }
        }
    }
}
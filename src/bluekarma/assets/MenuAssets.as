package assets
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * @author Shaun Stone - Blue Karma
     */
    public class MenuAssets
    {
        public static const WELCOME:String = "welcome";
        public static const INSTRUCTIONS:String = "instructions";
        //create a dictionary class
        [Embed(source="/../media/images/welcome-menu/welcome-menu.xml", mimeType="application/octet-stream")]
        public static const WelcomeMenuXML:Class;
        //create an atlas class
        /**
         * Get Instruction Screen Sprites
         *
         */

        [Embed(source="../../../media/images/instructions-menu/InstructionsMenu.png")]
        public static const InstructionsScreenAtlas:Class;
        [Embed(source="../../../media/images/instructions-menu/InstructionsMenu.xml", mimeType="application/octet-stream")]
        public static const InstructionsMenuXML:Class;
        //Embed XML Data of Welcome Menu
        /**
         * Get Welcome Screen Sprites
         *
         */

        //Embed PNG Image Sprites
        [Embed(source="/../media/images/welcome-menu/welcome-menu.png")]
        public static const WelcomeMenuAtlasTexture:Class;
        private static var gameTextures:Dictionary = new Dictionary();
        private static var welcomeTextureAtlas:TextureAtlas;
        //generic close button
        private static var instructionsTextureAtlas:TextureAtlas;

        /**
         * Get atlas and texture functions
         *
         */

        public static function getAtlas(name:String = WELCOME):TextureAtlas
        {
            var texture:Texture;
            var xml:XML;
            switch (name) {
                case WELCOME :
                    if (welcomeTextureAtlas == null) {
                        texture = getTexture("WelcomeMenuAtlasTexture");
                        xml = XML(new WelcomeMenuXML());
                        welcomeTextureAtlas = new TextureAtlas(texture, xml);
                    }
                    return welcomeTextureAtlas;
                    break;
                case INSTRUCTIONS :
                    if (instructionsTextureAtlas == null) {
                        texture = getTexture("InstructionsScreenAtlas");
                        xml = XML(new InstructionsMenuXML());
                        instructionsTextureAtlas = new TextureAtlas(texture, xml);
                    }
                    return instructionsTextureAtlas;
                    break;
                default :
                    throw new Error("Menu Assets atlas not found!");
            }
        }

        public static function getTexture(name:String):Texture
        {
            if (gameTextures[name] == undefined) {
                var bitmap:Bitmap = new MenuAssets[name]();
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
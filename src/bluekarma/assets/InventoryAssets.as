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
    public class InventoryAssets
    {

        //create a dictionary class
        [Embed(source="../../../media/images/inventory/inventory.png")]
        public static const InventoryImagesSpriteSheet:Class;
        //create an atlases
        [Embed(source="../../../media/images/inventory/inventory.xml", mimeType="application/octet-stream")]
        public static const InventoryXML:Class;
        [Embed(source="../../../media/images/inventory/mobile_menu/PhoneMenu.png")]
        public static const InventoryMainMenuSpriteSheet:Class;
        /*
         *
         * Embed Inventory Bar
         *
         * */
        [Embed(source="../../../media/images/inventory/mobile_menu/PhoneMenu.xml", mimeType="application/octet-stream")]
        public static const InventoryMainMenuXML:Class;
        //Embed XML Data of Inventory
        private static var inventoryTextures:Dictionary = new Dictionary();
        /*
         *
         * Embed Inventory Main Menu
         *
         * */
        // Add spritesheet
        private static var inventoryTextureAtlas:TextureAtlas;
        // Add XML
        private static var inventoryMainMenuTextureAtlas:TextureAtlas;

        /**
         *
         * @param    name
         * @return
         */
        public static function getAtlas(name:String = null):TextureAtlas
        {
            var texture:Texture;
            var xml:XML;
            if (name == null) {
                if (inventoryTextureAtlas == null) {
                    texture = getTexture("InventoryImagesSpriteSheet");
                    xml = XML(new InventoryXML());
                    inventoryTextureAtlas = new TextureAtlas(texture, xml);
                }
            }
            else if (name == "mainMenu") {
                texture = getTexture("InventoryMainMenuSpriteSheet");
                xml = XML(new InventoryMainMenuXML());
                inventoryMainMenuTextureAtlas = new TextureAtlas(texture, xml);
                return inventoryMainMenuTextureAtlas;
            }
            //return atlas
            return inventoryTextureAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (inventoryTextures[name] == undefined) {
                var bitmap:Bitmap = new InventoryAssets[name]();
                inventoryTextures[name] = Texture.fromBitmap(bitmap);
            }
            return inventoryTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in inventoryTextures) {
                inventoryTextures[i].dispose();
            }
        }
    }
}
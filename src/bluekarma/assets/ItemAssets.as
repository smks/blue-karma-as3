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
    public class ItemAssets
    {
        public static const ITEM_SELECTED:String = "item_selected";
        public static const WORK_CLOTHING:String = "work_clothing";
        public static const PYJAMAS:String = "bedroom_pyjamas";
        public static const KITCHEN_GLASS:String = "kitchen_glass";
        public static const KITCHEN_BOWL:String = "kitchen_bowl";
        public static const KITCHEN_PLATE:String = "kitchen_dish";
        public static const DOG_BOWL:String = "dog_bowl";
        public static const DOG_BOWL_FULL:String = "dog_bowl_full";
        public static const DOG_FOOD:String = "dog_food";
        public static const LOCKPICK:String = "lock_pick";
        public static const DIGICUFFS:String = "digicuffs";
        public static const CHIP:String = "chip";
        public static const BOTTLE:String = "bottle";
        public static const BOTTLE_INV:String = "bottle_inventory";
        public static const CABLE:String = "cable";
        public static const FAN_KEYS:String = "fan-keys";
        public static const TOOLBOX_KEY:String = "toolbox-key";
        public static const CROWBAR:String = "crowbar";
        public static const MASKING_TAPE:String = "masking-tape-item";
        //create a dictionary class
        [Embed(source="../../../media/images/items/item_selected.png")]
        public static const ItemSelected:Class;
        //create an atlases
        [Embed(source="../../../media/images/items/Items.png")]
        public static const ItemsTextureAtlas:Class;
        /*
         * This shows when item is selected
         */
        [Embed(source="../../../media/images/items/Items.xml", mimeType="application/octet-stream")]
        public static const ItemsXML:Class;
        /*
         *
         * Inventory Item Atlas Image
         *
         * */
        private static var itemTextures:Dictionary = new Dictionary();
        private static var itemTexturesAtlas:TextureAtlas;
        /*
         *
         *  Methods to get atlas and textures
         *
         */
        public static function getAtlas():TextureAtlas
        {
            if (itemTexturesAtlas == null) {
                var texture:Texture = getTexture("ItemsTextureAtlas");
                var xml:XML = XML(new ItemsXML());
                //create a new atlas
                itemTexturesAtlas = new TextureAtlas(texture, xml);
            }
            //return atlas
            return itemTexturesAtlas;
        }

        public static function getTexture(name:String):Texture
        {
            if (itemTextures[name] == undefined) {
                var bitmap:Bitmap = new ItemAssets[name]();
                itemTextures[name] = Texture.fromBitmap(bitmap);
            }
            return itemTextures[name];
        }

        /**
         * Free memory up when finished
         */
        public static function cleanUpMemory():void
        {
            for (var i:String in itemTextures) {
                itemTextures[i].dispose();
            }
        }
    }
}
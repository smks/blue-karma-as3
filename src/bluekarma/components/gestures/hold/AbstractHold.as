package components.gestures.hold
{
    import assets.GestureAssets;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.TextureAtlas;

    /**
     * ...
     * @author @shaun
     */
    public class AbstractHold extends Sprite
    {
        protected var expander:Image;
        protected var border:Image;
        protected var duration:uint;
        protected var id:String;

        public function AbstractHold(duration:Number = 3, id:String = 'default')
        {
            this.duration = duration;
        }

        /**
         * Draw the assets
         *
         */
        protected function draw():void
        {
            var atlas:TextureAtlas = GestureAssets.getAtlas();
            border = new Image(atlas.getTexture("hold-border"));
            border.pivotX = border.width / 2;
            border.pivotY = border.height / 2;
            addChild(border);
            expander = new Image(atlas.getTexture("hold-expander"));
            expander.pivotX = expander.width / 2;
            expander.pivotY = expander.height / 2;
            expander.scaleX = 0;
            expander.scaleY = 0;
            addChild(expander);
            this.alpha = 0;
        }
    }
}
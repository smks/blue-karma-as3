package components.gestures.balancer
{
    import global.Global;

    import starling.display.Button;
    import starling.display.Image;
    import starling.filters.BlurFilter;
    import starling.textures.Texture;

    /**
     * @author @shaun
     */
    public class ArrowPush extends Image
    {
        public var id:String = 'na';
        private var holdingDown:Boolean;

        public function ArrowPush(id:String, texture:Texture)
        {
            this.id = id;
            super(texture);
        }

        public function flipLeft():void
        {
            this.scaleX = -1;
            this.x = +this.width;
        }

        public function getId():String
        {
            return id;
        }

        public function setHolding(holdingDown:Boolean):void
        {
            this.holdingDown = holdingDown;
            if (holdingDown) {
                this.filter = BlurFilter.createGlow(Global.BLUE_KARMA_GLOW_YELLOW, 4, 4, 3);
            } else {
                this.filter = null;
            }
        }

        public function isHoldingDown():Boolean
        {
            return this.holdingDown;
        }
    }
}
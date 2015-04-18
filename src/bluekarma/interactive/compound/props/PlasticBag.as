package interactive.compound.props
{
    import assets.CompoundAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: PlasticBag
     * @author Shaun Stone (SMKS)
     * @website http://www.smks.co.uk
     * Created at: 08-01-2015 20:04:38
     */
    public class PlasticBag extends Prop
    {
        /**
         * The image retrieved from Assets
         */
        private var image:Image;
        /**
         * The movieclip of images retrieved from Assets
         */
        //private var animation:MovieClip;
        /*
         * Main Constructor, override any default properties here
         */
        public function PlasticBag(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            setExaminable(true);
            setTouchable(true);
        }

        /**
         * Retrieve Image from assets then draw the prop
         *
         */
        override protected function getPropAsset(id:String):void
        {
            image = new Image(CompoundAssets.getAtlas().getTexture(id));
            image.x = 0;
            image.y = 0;
            image.pivotX = 0;
            image.pivotY = 0;
            image.scaleX = 1;
            image.scaleY = 1;
            addChild(image);
        }

        /**
         * Choose the repo to retrieve the prop from
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.COMPOUND;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        /**
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject();
        }

        /**
         * When TriggerExamine is called, we may want to do
         * something other than what's expected for the prop
         * @param params - pass in parameters we may want to use
         */
        override public function triggerExamine(params:Object = null):void
        {
            super.triggerExamine(params);
        }
    }
}
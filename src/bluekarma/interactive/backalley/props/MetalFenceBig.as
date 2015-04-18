package interactive.backalley.props
{
    import assets.BackAlleyAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: MetalFenceBig
     * @author Shaun Stone
     * Created at: 06-12-2014 17:22:25
     */
    public class MetalFenceBig extends Prop
    {
        /**
         * The image retrieved from Assets
         */
        private var image:Image;
        /*
         * Main Constructor, override any default properties here
         */
        public function MetalFenceBig(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            
            setExaminable(true);
        }

        /**
         * Retrieve Image from assets then draw the prop
         *
         */
        override protected function getPropAsset(id:String):void
        {
            image = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.METAL_FENCE_BIG));
			
			image.scaleX = 2;
			image.scaleY = 2;
			image.width = 379;
			image.height = 691;
            addChild(image);
        }

        /**
         * Choose the repo to retrieve the prop from
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.BACK_ALLEY;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        /*
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
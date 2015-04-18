package interactive.backalley.props
{
    import assets.BackAlleyAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: Roof
     * @author Shaun Stone
     * Created at: 06-12-2014 13:14:22
     */
    public class Roof extends Prop
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
        public function Roof(id:String, examinable:Boolean = false)
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
            if (id === "roof-left") {
                image = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.ROOF_LEFT));
            } else {
                image = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.ROOF_RIGHT));
            }
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
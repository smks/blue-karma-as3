package interactive.backalley.props
{
    import assets.BackAlleyAssets;

    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: Bricks
     * @author Shaun Stone
     * Created at: 01-01-2015 15:18:15
     */
    public class Bricks extends Prop
    {
        /**
         * The brick retrieved from Assets
         */
        private var brick:Image;
        private var brick2:Image;
        private var brick3:Image;
        private var moved:Boolean = false;
        /*
         * Main Constructor, override any default properties here
         */
        public function Bricks(id:String, examinable:Boolean = false)
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
            brick3 = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.BRICK));
            brick3.x = 10;
            brick3.y = 40;
            addChild(brick3);
            brick2 = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.BRICK));
            brick2.x = 0;
            brick2.y = 20;
            addChild(brick2);
            brick = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.BRICK));
            brick.x = 10;
            brick.y = 0;
            addChild(brick);
        }

        /**
         * Choose the repo to retrieve the prop from
         */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.BACK_ALLEY;
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
            if (moved) {
                returnToOriginalPosition();
            } else {
                moveOutOfPosition();
            }
            SoundAssets.bricks.play();
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

        private function moveOutOfPosition():void
        {
            this.x -= brick.width;
            this.moved = true;
        }

        private function returnToOriginalPosition():void
        {
            this.x += brick.width;
            this.moved = false;
        }
    }
}
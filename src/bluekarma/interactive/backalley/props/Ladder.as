package interactive.backalley.props
{
    import assets.BackAlleyAssets;
    import assets.PropAssets;

    import bluekarma.interactive.base.InteractionRepoFactory;

    import global.Global;

    import interactive.base.Prop;

    import starling.display.Image;

    /**
     * Interactive Prop: Ladder
     * @author Shaun Stone
     * Created at: 30-11-2014 18:21:11
     */
    public class Ladder extends Prop
    {
        /**
         * The image retrieved from Assets
         */
        private var image:Image;
        private var currentWall:String = Global.RIGHT;

        /**
         * Main Constructor, override any default properties here
         */
        public function Ladder(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
            setActionable(true);
            setExaminable(true);
            
        }

        /**
         * Retrieve Image from assets then draw the prop
         *
         */
        override protected function getPropAsset(id:String):void
        {
            image = new Image(BackAlleyAssets.getAtlas().getTexture(BackAlleyAssets.LADDER));
            image.pivotX = image.width / 2;
            image.pivotY = image.height / 2;
            image.scaleX = 1;
            image.scaleY = 1;
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

        /**
         * Override Trigger Interaction Object and create new behaviour for Item
         * @examples
         *  params.currentState - trigger an object dependent on the state of level
         *  params.playerPosition - x position to determine if player is near the object
         *  params.* pass in anything necessary
         */
        override public function triggerInteractionObject(params:Object = null):void
        {
            var sideToMove:String;
            if (params.level === undefined) {
                throw new Error("level needs to be defined");
            }
            if (currentWall === Global.LEFT) {
                sideToMove = Global.RIGHT;
            } else {
                sideToMove = Global.LEFT;
            }
            params.level.moveLadder(sideToMove);
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

        /**
         *
         * @param string
         */
        public function changeDirection(direction:String = Global.LEFT):void
        {
            if (direction === Global.RIGHT) {
                image.scaleX = -1;
            } else if (direction === Global.LEFT) {
                image.scaleX = 1;
            }
            setCurrentWall(direction);
        }

        /**
         *
         * @return
         */
        public function getCurrentWall():String
        {
            return currentWall;
        }

        /**
         *
         * @param    direction
         */
        private function setCurrentWall(direction:String):void
        {
            this.currentWall = direction;
        }
    }
}
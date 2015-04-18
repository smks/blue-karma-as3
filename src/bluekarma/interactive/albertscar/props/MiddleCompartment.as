package bluekarma.interactive.albertscar.props
{
    import bluekarma.assets.settings.backgrounds.albertscar.AlbertJourneyAssets;
    import bluekarma.assets.sound.SoundAssets;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import interfaces.IOpenable;

    import starling.display.Image;

    import assets.RileyApartmentAssets;

    import starling.display.MovieClip;

    /**
     * ...
     * @author Shaun Stone
     */
    public class MiddleCompartment extends Prop implements IOpenable
    {
        private var closedComp:Image;
        private var openComp:Image;
        private var opened:Boolean = false;
        private var _attemptedToOpen:Boolean = false;

        public function MiddleCompartment(id:String, _examinable:Boolean = false)
        {
            // call parent
            super(id, _examinable);
            // close by default
            close();
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            if (!hasAttemptedToOpen()) {
                setAttemptedToOpen(true);
            }
            /*

             if (isOpen()) {
             close();
             } else {
             open();
             }
             */
        }

        override public function triggerAction(params:Object = null):void
        {
            super.triggerAction();
        }

        override protected function getPropAsset(id:String):void
        {
            closedComp = new Image(AlbertJourneyAssets.getAtlas().getTexture("middle-compartment"));
            closedComp.y = 100;
            addChild(closedComp);
            openComp = new Image(AlbertJourneyAssets.getAtlas().getTexture("middle-compartment-open"));
            openComp.visible = false;
            addChild(openComp);
        }

        /* INTERFACE Openable */
        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.ALBERTS_CAR;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        public function open():void
        {
            if (!isOpen()) {
                SoundAssets.unlockCompartment.play();
                openComp.visible = true;
                closedComp.visible = false;
                setOpen(true);
                this.touchable = false;
            }
        }

        public function close():void
        {
            if (isOpen()) {
                openComp.visible = false;
                closedComp.visible = true;
                setOpen(false);
                this.touchable = true;
            }
        }

        public function isOpen():Boolean
        {
            return opened;
        }

        public function setOpen(val:Boolean):void
        {
            opened = val;
        }

        public function hasAttemptedToOpen():Boolean
        {
            return _attemptedToOpen;
        }

        public function setAttemptedToOpen(value:Boolean):void
        {
            _attemptedToOpen = value;
        }
    }
}
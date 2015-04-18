package bluekarma.interactive.slumsstreet.props
{
    import bluekarma.interactive.base.InteractionObject;
    import bluekarma.interactive.base.InteractionRepoFactory;

    import interactive.base.Prop;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.core.Starling;
    import starling.events.TouchEvent;
    import starling.events.Touch;
    import starling.events.TouchPhase;

    import events.InteractionEvent;

    import assets.PropAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class CCTV extends Prop
    {
        public var _object:MovieClip;
        private var cctv_frame:Image;

        public function CCTV(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            //add frame
            cctv_frame = new Image(PropAssets.getTexture("CCTVFrame"));
            cctv_frame.x = 145;
            cctv_frame.y = 240;
            addChild(cctv_frame);
            //add moving cctv camera
            _object = new MovieClip(PropAssets.getAtlas().getTextures("cctv"));
            addChild(_object);
            _object.setFrameDuration(1, 2);
            _object.setFrameDuration(19, 2);
            Starling.juggler.add(_object);
        }

        override protected function getRepo():void
        {
            _repoId = InteractionRepoFactory.SLUMS_STREET;
            _repo = InteractionRepoFactory.getInteractionRepo(_repoId);
        }

        override public function triggerInteractionObject(params:Object = null):void
        {
            super.triggerInteractionObject(params);
        }

        public function stopMovement():void
        {
            _object.stop();
        }

        public function startMovement():void
        {
            _object.play();
        }
    }
}
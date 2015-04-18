package players.riley
{
    import assets.PlayerAssets;

    import interactive.base.Prop;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.display.MovieClip;
    import starling.events.Event;

    /**
     * ...
     * @author Shaun Stone
     */
    public class RileyAsleep extends Prop
    {
        //player sleeping movieclip
        protected var _rileyAsleep:MovieClip;
        //player moving to show face
        protected var _rileyAwakeShowFace:MovieClip;
        //player reaching for phone
        protected var _rileyAwakeReachForPhone:MovieClip;
        //player walks over to draw
        protected var _rileyWalkToDrawer:MovieClip;
        //player walks to bathroom
        protected var _rileyWalkToBathroom:MovieClip;

        public function RileyAsleep(id:String, examinable:Boolean = false)
        {
            super(id, examinable);
        }

        override protected function getPropAsset(id:String):void
        {
            //draw sleeping riley
            _rileyAsleep = new MovieClip(PlayerAssets.getAtlas(PlayerAssets.RILEY_SLEEP).getTextures("riley_bed_awake"));
            addChild(_rileyAsleep);
            _rileyAwakeReachForPhone = new MovieClip(PlayerAssets.getAtlas(PlayerAssets.RILEY_SLEEP).getTextures("riley_bed_phone"), 24);
            _rileyAwakeReachForPhone.x = -80;
            _rileyAwakeReachForPhone.y = 10;
            addChild(_rileyAwakeReachForPhone);
            _rileyAwakeReachForPhone.visible = false;
            Starling.juggler.add(_rileyAsleep);
            Starling.juggler.add(_rileyAwakeReachForPhone);
            _rileyAsleep.stop();
            _rileyAwakeReachForPhone.stop();
        }

        public function wakeUpRiley():void
        {
            _rileyAsleep.loop = false;
            _rileyAsleep.play();
        }

        public function makeRileyReachForPhone():void
        {
            _rileyAsleep.visible = false;
            _rileyAwakeReachForPhone.visible = true;
            _rileyAsleep.removeFromParent(true);
            _rileyAwakeReachForPhone.loop = false;
            _rileyAwakeReachForPhone.play();
            _rileyAwakeReachForPhone.addEventListener("complete", whenReachedForPhone);
        }

        private function whenReachedForPhone(e:Event):void
        {
            dispatchEventWith("phoneHasBeenReachedFor", true);
        }
    }
}
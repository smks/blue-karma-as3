package dialogue.subjects
{
    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    /**
     *
     * This is a topic of discussion
     * during a dialogue conversation
     *
     *
     * @TODO
     *
     * @author @shaun
     */
    public class AbstractSubject extends Button
    {
        protected var id:String;
        protected var subject:Button;
        protected var chosen:Boolean = false;
        protected var active:Boolean = true;

        public function AbstractSubject(upState:Texture, text:String, downState:Texture = null, id:String = '')
        {
            super(upState, text, downState);
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        override public function get scaleWhenDown():Number
        {
            return super.scaleWhenDown;
        }

        override public function set scaleWhenDown(value:Number):void
        {
            super.scaleWhenDown = value;
        }

        protected function draw():void
        {
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
        }
    }
}
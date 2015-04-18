/**
 * ollomeijer
 * @modified jangarita
 */
package
{
    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.*;
    import starling.events.Event;

    [Event(name="complete", type="starling.events.Event")]
    public class FrameSprite extends Sprite implements IAnimatable
    {
        private var m_frames:Vector.<Sprite> = new Vector.<Sprite>();
        private var m_currentFrame:uint = 1;
        private var m_totalFrames:uint = 0;
        private var m_fps:Number;
        private var m_currentTime:Number = 0.0;
        private var m_frameTime:Number = 0.0;
        private var m_loop:Boolean = false;
        private var m_isPlaying:Boolean = false;

        public function FrameSprite(_fps:Number = 24)
        {
            super();
            m_fps = _fps;
            m_frameTime = (1000 / m_fps) / 1000;
            addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
        }

        public function get currentFrameSprite():Sprite
        {
            return m_frames[m_currentFrame - 1];
        }

        public function get currentFrame():uint
        {
            return m_currentFrame;
        }

        public function set currentFrame(_val:uint):void
        {
            var frameNum:uint = Math.max(Math.min(_val, m_totalFrames), 1);
            if (frameNum == 0) {
                return;
            }
            if (m_currentFrame != frameNum) {
                m_currentFrame = frameNum;
                removeChildren();
                addChild(m_frames[frameNum - 1]);
            }
        }

        public function get isPlaying():Boolean
        {
            return m_isPlaying;
        }

        public function get currentFrameLabel():String
        {
            return m_frames[m_currentFrame - 1].name;
        }

        public function get totalFrames():int
        {
            return m_totalFrames;
        }

        public function get loop():Boolean
        {
            return m_loop;
        }

        public function set loop(value:Boolean):void
        {
            m_loop = value;
        }

        public function get fps():Number
        {
            return m_fps;
        }

        public function set fps(value:Number):void
        {
            if (value <= 0) {
                value = 1;
            }
            m_fps = value;
            m_frameTime = (1000 / m_fps) / 1000;
        }

        override public function dispose():void
        {
            stop();
            removeChildren(0, -1, true);
            var i:int = m_totalFrames;
            while (i--) {
                m_frames[i].dispose();
            }
            super.dispose();
        }

        public function addFrame(_label:String = ""):void
        {
            var frame:Sprite = new Sprite();
            if (_label !== "") {
                frame.name = _label;
            }
            m_totalFrames = m_frames.push(frame);
            if (m_totalFrames == 1) {
                addChild(frame);
            }
        }

        public function removeFrame(_val:*):void
        {
            var frameNum:uint = getFrame(_val);
            if (frameNum == 0) {
                return;
            }
            if (frameNum == m_currentFrame) {
                prevFrame();
            }
            m_frames.splice(frameNum - 1, 1);
            m_totalFrames = m_frames.length;
        }

        public function nextFrame():void
        {
            gotoAndStop(m_currentFrame + 1);
        }

        public function prevFrame():void
        {
            gotoAndStop(m_currentFrame - 1);
        }

        public function addChildToFrame(mc:DisplayObject, _val:*):void
        {
            var frameNum:uint = getFrame(_val);
            if (frameNum == 0 || !mc) {
                return;
            }
            var frame:Sprite = m_frames[frameNum - 1];
            if (frame) {
                frame.addChild(mc);
            }
        }

        public function gotoAndPlay(_val:*):void
        {
            gotoAndStop(_val);
            play();
        }

        public function gotoAndStop(_val:*):void
        {
            stop();
            var frameNum:uint = getFrame(_val);
            if (frameNum == 0) {
                return;
            }
            currentFrame = frameNum;
        }

        public function play():void
        {
            if (m_isPlaying) {
                return;
            }
            m_isPlaying = true;
            Starling.juggler.add(this);
        }

        public function stop():void
        {
            if (!m_isPlaying) {
                return;
            }
            m_isPlaying = false;
            Starling.juggler.remove(this);
        }

        public function advanceTime(_passedTime:Number):void
        {
            if (!isPlaying || m_totalFrames == 0) {
                return;
            }
            m_currentTime += _passedTime;
            if (m_currentTime > m_frameTime) {
                while (m_currentTime > m_frameTime) {
                    m_currentTime -= m_frameTime;
                    if (m_currentFrame == totalFrames) {
                        if (m_loop) {
                            currentFrame = 1;
                        }
                        else {
                            dispatchEventWith(Event.COMPLETE);
                            stop();
                            return;
                        }
                    }
                    else {
                        currentFrame++;
                    }
                }
            }
        }

        private function getFrame(_val:*):uint
        {
            if (!_val) {
                return 0;
            }
            if (isNaN(_val)) {
                var i:int = m_totalFrames;
                while (i--) {
                    if (m_frames[i].name == _val) {
                        return i + 1;
                    }
                }
            }
            return Math.max(Math.min(_val, m_totalFrames), 1);
        }

        private function onRemoveFromStage(e:Event):void
        {
            stop();
        }
    }
}
package messages
{
    import assets.CharacterDialogueAssets;
    import assets.GameAssets;
    import assets.MenuAssets;

    import bluekarma.assets.sound.SoundAssets;

    import flash.media.Sound;
    import flash.media.SoundChannel;

    import global.Global;

    import starling.display.Button;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractMessage extends Sprite
    {
        private const DEFAULT_FONT:String = "Century Gothic";
        //message array
        protected var _messageArray:Array;
        //bg
        protected var _bgOverlay:Button;
        //create quad
        protected var _messageBox:Quad;
        //messageTextfield to store information
        protected var _messageText:TextField;
        //voice files
        protected var _voiceFiles:Array;
        //button to close
        protected var _closeBtn:Button;
        //message iterator
        protected var _messageI:uint = 0;
        // this will stop sound if necessary
        protected var _voiceChannel:SoundChannel;

        public function AbstractMessage(messageArray:Array, voiceFiles:Array = null)
        {
            _messageArray = messageArray;
            if (voiceFiles != null) {
                trace("voice files is", _voiceFiles);
                _voiceFiles = voiceFiles;
            }
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function terminateMessage():void
        {
            // cease any speech
            _voiceChannel.stop();
            // remove as a new message has precedence
            removeFromParent(true);
        }

        /**
         *
         * @param    message
         */
        protected function createMessageBox():void
        {
            var bgOverlayTexture:Texture = GameAssets.getTexture("Overlay50");
            //create a dark bg
            _bgOverlay = new Button(bgOverlayTexture, "", bgOverlayTexture);
            _bgOverlay.width = Game.STAGE_WIDTH;
            _bgOverlay.height = Game.STAGE_HEIGHT;
            addChild(_bgOverlay);
            _bgOverlay.addEventListener("triggered", messageHandler);
            addMessageBox();
            _messageText = new TextField(1000, 100, "...", Global.DEFAULT_FONT, 20, 0xffffff, false);
            _messageText.border = false;
            _messageText.x = 12;
            _messageText.y = 650;
            addChild(_messageText);
            addCloseButton();
            updateMessageText();
        }

        protected function updateMessageText():void
        {
            //_voiceFiles[_messageI].play();
            if (_messageI >= _messageArray.length) {
                //stop any sounds playing
                _voiceChannel.stop();
                this.removeFromParent(true);
                trace("interaction is now complete from message box");
            }
            else {
                if (_voiceFiles[_messageI] != undefined) {
                    if (_voiceFiles[_messageI] is Sound) {
                        if (_messageI > 0) {
                            _voiceChannel.stop();
                        }
                        _voiceChannel = _voiceFiles[_messageI].play();
                    }
                }
                _messageText.text = _messageArray[_messageI];
                _messageI++;
            }
        }

        protected function addCloseButton():void
        {
            _closeBtn = new Button(GameAssets.getTexture("CloseButton"));
            _closeBtn.x = Game.STAGE_WIDTH - _closeBtn.width;
            _closeBtn.y = Game.STAGE_HEIGHT - (_closeBtn.height * 1.05);
            _closeBtn.scaleX = 0.5;
            _closeBtn.scaleY = 0.5;
            addChild(_closeBtn);
            _closeBtn.addEventListener(Event.TRIGGERED, closeDialogue);
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            // this will listen for sounds
            _voiceChannel = new SoundChannel();
            // create message box
            createMessageBox();
        }

        private function addMessageBox():void
        {
            //create box
            _messageBox = new Quad(1000, 100);
            _messageBox.x = 12;
            _messageBox.y = 650;
            var topColor:uint = 0x191919; // dark grey
            var bottomColor:uint = 0x262626; // darker grey
            _messageBox.setVertexColor(0, topColor);
            _messageBox.setVertexColor(1, topColor);
            _messageBox.setVertexColor(2, bottomColor);
            _messageBox.setVertexColor(3, bottomColor);
            addChild(_messageBox);
        }

        private function messageHandler(e:Event):void
        {
            updateMessageText();
        }

        private function closeDialogue(event:Event):void
        {
            // play sound
            SoundAssets.buttonClick2.play();
            // cease any speech
            _voiceChannel.stop();
            // remove self
            removeFromParent(true);
        }
    }
}
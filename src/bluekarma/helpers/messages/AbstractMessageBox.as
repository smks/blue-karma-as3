package bluekarma.helpers.messages
{
    import assets.GameAssets;

    import flash.utils.ByteArray;

    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.text.TextField;
    import starling.utils.AssetManager;

    import assets.MessageBoxAssets;

    import starling.display.Quad;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    import assets.CharacterDialogueAssets;

    import starling.textures.Texture;

    import states.Level1State;

    import assets.MenuAssets;

    import bluekarma.assets.sound.SoundAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class AbstractMessageBox extends Sprite
    {
        //the target type in focus
        protected var _typeName:String;
        //the target object in focus (item a, item b)
        protected var _objectName:String;
        //interaction type
        protected var _interactionType:String;
        //what message to display (if null fetch list)
        protected var _messageId:uint;
        //Available targets list
        protected var _targetList:Array;
        //message xml list
        protected var _messageList:XMLList
        //message array
        protected var _messageArray:Array;
        //bg
        protected var _bgOverlay:Button;
        //create quad
        protected var _messageBox:Quad;
        //messageTextfield to store information
        protected var _messageText:TextField;
        //button to close
        protected var _closeBtn:Button;
        //message iterator
        protected var message_i:uint = 0;
        /*
         *
         * Constructor
         * @return: none
         */
        public function MessageBox(type:String, object:String, interaction:String, message:uint = 0)
        {
            //type (items, characters, props)
            _typeName = _type;
            //object (item-a, item-b, homelessman1)
            _objectName = _object;
            //interaction (examine, chat, action)
            _interactionType = interaction;
            //assign a specific message if necessary
            _messageId = messageId;
            //wait to be added to the stage
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        /**
         *
         * @param event
         */

        protected function onAdded(event:Event):void
        {
            //remove added listener
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //configure settings before making a messagebox
            setupMessage();
        }

        /**
         * Create the physical message box and textfield
         * then add event listener to listen for touch
         * @param    message
         * @return: void
         */

        protected function createMessageBox(message:XMLList = null):void
        {
            var bgOverlayTexture:Texture = CharacterDialogueAssets.getAtlas().getTexture("bg_overlay");
            //create a dark bg
            bgOverlay = new Button(bgOverlayTexture, "", bgOverlayTexture);
            bgOverlay.width = Game.STAGE_WIDTH;
            bgOverlay.height = Game.STAGE_HEIGHT;
            addChild(bgOverlay);
            //create box
            messageBox = new Quad(1000, 100, 0x333333, true);
            messageBox.x = 12;
            messageBox.y = 650;
            addChild(messageBox);
            messageText = new TextField(1000, 100, "Text", "Blue Highway", 20, 0xffffff, false);
            messageText.x = 12;
            messageText.y = 650;
            addChild(messageText);
            addCloseButton();
            this.addEventListener(TouchEvent.TOUCH, messageHandler);
            updateMessageText();
        }

        /**
         *
         * Configure and setup a message
         * @return: void
         **/

        private function setupMessage():void
        {
            //get xml first
            var messageObject:XML = getMessageXML();
            //get current state
            var state:uint = Level1State.CURRENT_STATE;
            //check if target has messages associated with it
            var checkForMessages:Boolean = checkTargetObject(objectName, targetList);
            //create a new message array
            messageArray = new Array();
            //if target is valid
            if (checkForMessages) {

                //get list of messages
                messageList = searchForMessages(messageObject, typeName, objectName, interactionType, state);
            } else {
                trace("check was not passed");
                //get default message "I don't know what you mean?"
                messageList = this.searchDefaultMessage(messageObject);
            }
            //put xml list into array
            messageArray = arrangeMessages(messageList);
            //return a message default response
            createMessageBox(messageList);
        }

        /**
         * @desc Check if target object exists in array
         * @param    word
         * @param    arr
         * @return Boolean
         */

        private function checkTargetObject(word:String, arr:Array):Boolean
        {
            var exists:Boolean = false;
            for (var i:uint = 0; i < arr.length; i++) {
                if (arr[i] == word) {
                    trace("Element exist on position " + i);
                    exists = true;
                }
            }
            if (exists) {
                return true;
            } else {
                return false;
            }
        }

        /**
         * @desc Look in XML document and traverse through nodes to get correct message
         * @param    xmlObject
         * @param    typeName
         * @param    objectName
         * @param    interactionType
         * @param    stateId
         * @param    defaultMessage
         * @return: XMLList
         */

        private function searchForMessages(xmlObject:XML = null, typeName:String = null, objectName:String = null, interactionType:String = null, stateId:uint = 0, defaultMessage:Boolean = false):XMLList
        {
            var list:XMLList;
            trace(" type: " + typeName + " object: " + objectName + " interaction: " + interactionType + " state: " + stateId + " defaultmessage boolean is: " + defaultMessage);
            //check xml object is not null
            if (xmlObject !== null) {

                //check if there is no state change of object
                if (defaultMessage == false) {
                    //dynamically retrieve xml data based on what is passed in
                    list = xmlObject.type[typeName].object.(@name == objectName).interact[interactionType].state.(@id == stateId).message.text();
                } else {
                    list = xmlObject.type[typeName].object.(@name == objectName).interact[interactionType].fallback.message.text();
                }
            } else {
                //if no object passed in return default text "I don't know what you mean?"
                //trace(xmlObject);
            }
            //return results
            return list;
        }

        private function searchDefaultMessage(xmlObject:XML):XMLList
        {
            return xmlObject.type.none.message.text();
        }

        /**
         * Create an array of messages to use for interaction
         * @param    list
         * @return array
         */

        private function arrangeMessages(list:XMLList):Array
        {
            var _array:Array = new Array();
            //push all messages into it
            for (var i:uint; i < list.length(); i++) {
                _array.push(list[i]);
            }
            return _array;
        }

        /**
         * @desc add a button to close message box
         */

        private function addCloseButton():void
        {
            closeBtn = new Button(GameAssets.getTexture("CloseButton"));
            closeBtn.x = Game.STAGE_WIDTH - closeBtn.width;
            closeBtn.y = Game.STAGE_HEIGHT - closeBtn.height;
            closeBtn.scaleX = 0.5;
            closeBtn.scaleY = 0.5;
            this.addChild(closeBtn);
            closeBtn.addEventListener(Event.TRIGGERED, closeDialogue);
        }

        /**
         * @desc close when close button triggered
         * @param event
         */

        private function closeDialogue(event:Event):void
        {
            //play sound
            SoundAssets.buttonClick2.play();
            //acknowledge the interaction is over
            dispatchEventWith("InteractionComplete", true);
            //remove self
            removeFromParent(true);
        }

        /**
         *
         * @desc get XML object of messages
         * @return: XML
         */

        private function getMessageXML():XML
        {
            //fetch xml object from assets
            var messageXML:XML = MessageBoxAssets.getXMLData("Level-1");
            //return xml object
            return messageXML;
        }

        /**
         *
         * @desc when a touch is triggered update message text
         * @return: void
         */

        private function messageHandler(e:TouchEvent):void
        {
            var proceedTouch:Touch = e.getTouch(this, TouchPhase.ENDED);
            if (proceedTouch) {
                updateMessageText();
            }
        }

        /**
         * @desc check if end of messages then remove object
         * otherwise show the next message in sequence
         * @return: void
         */

        private function updateMessageText():void
        {
            if (message_i >= messageArray.length) {
                dispatchEventWith("InteractionComplete", true);
                this.removeFromParent();
                trace("interaction is now complete from message box");
            } else {
                messageText.text = messageArray[message_i];
                message_i++;
            }
        }
    }
}
/*
 Debug
 //trace("xml: " + messageObject + " type: " + typeName + " object: " + objectName + " interaction: " + interactionType + " state: " + state);
 ...
 */
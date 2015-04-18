package notifications.reminders
{
    import assets.InventoryAssets;

    import com.greensock.TweenLite;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    /**
     * ...
     * @author @shaun
     */
    public class Reminder extends Sprite
    {
        public static const CRITICAL:String = "critical";
        public static const HIGH:String = "high";
        public static const FINE:String = "fine";
        private var TRANSITION_TIME:Number = 0.5;
        private var id:String;
        private var message:String;
        private var priority:String;
        private var container:Quad;
        private var priorityArrow:Image;
        private var reminderText:TextField;
        private var closeButton:Button;

        public function Reminder(_id:String, _message:String, _priority:String)
        {
            id = _id;
            message = _message;
            priority = _priority;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function getId():String
        {
            return id;
        }

        public function setId(value:String):void
        {
            id = value;
        }

        public function destroy():void
        {
            parent.dispatchEventWith("dismissed", true, {reminder: this});
            removeFromParent(true);
        }

        /**
         *
         * @return string
         */
        public function getMessage():String
        {
            return message;
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
        }

        private function draw():void
        {
            container = new Quad(360, 40, 0x111111);
            addChild(container);
            priorityArrow = getPriority();
            addChild(priorityArrow);
            reminderText = new TextField(300, 40, message.toUpperCase(), "Verdana", 12, 0xeeeeee);
            reminderText.x = 50;
            reminderText.hAlign = HAlign.LEFT;
            addChild(reminderText);
            var closeTexture:Texture = InventoryAssets.getAtlas("mainMenu").getTexture("close")
            closeButton = new Button(closeTexture, "", closeTexture);
            closeButton.x = 328;
            closeButton.y = 10;
            closeButton.addEventListener("triggered", dismiss);
            addChild(closeButton);
        }

        private function dismiss(e:Event):void
        {
            TweenLite.to(this, TRANSITION_TIME, {alpha: 0, onComplete: destroy});
        }

        private function getPriority():Image
        {
            var texture:Texture;
            switch (priority) {
                case FINE:
                    texture = InventoryAssets.getAtlas("mainMenu").getTexture(FINE);
                    break;
                case HIGH:
                    texture = InventoryAssets.getAtlas("mainMenu").getTexture(HIGH);
                    break;
                case CRITICAL:
                    texture = InventoryAssets.getAtlas("mainMenu").getTexture(CRITICAL);
                    break;
                default:
                    throw new Error("PRIORITY DOESN'T EXIST");
            }
            return new Image(texture);
        }

        private function capitalizeWords(message:String):String
        {
            var cap:String = String(message).substr(0, 1);
            cap = String(cap).toUpperCase() + String(message).slice(1);
            return cap;
        }
    }
}
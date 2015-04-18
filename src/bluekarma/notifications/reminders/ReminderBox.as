package notifications.reminders
{
    import assets.InventoryAssets;

    import com.greensock.TweenLite;

    import flash.utils.Dictionary;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     * ...
     * @author @shaun
     */
    public class ReminderBox extends Sprite
    {
        private const POSITION_X:uint = 13;
        private const POSITION_Y_0:uint = 11;
        private const POSITION_Y_1:uint = 66;
        private const POSITION_Y_2:uint = 120;
        private const POSITION_Y_3:uint = 174;
        private const POSITION_Y_4:uint = 227;
        private const POSITION_Y_5:uint = 281;
        private const POSITION_Y_6:uint = 335;
        private const POSITION_Y_7:uint = 389;
        private const MAX_REMINDERS:uint = 8;
        private var TRANSITION_TIME:Number = 0.75;
        private var container:Image;
        private var remindersList:Array = new Array();
        private var noNotifications:TextField;
        private var reminderToRemove:uint;

        public function ReminderBox()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function addReminder(id:String, message:String, priority:String):void
        {
            var len:uint = remindersList.length;
            if (len == MAX_REMINDERS) {
                len--;
                removeChild(remindersList[len]);
                // remove oldest message
                remindersList.pop();
            }
            if (noNotifications.alpha > 0) {
                TweenLite.to(noNotifications, TRANSITION_TIME, {alpha: 0});
            }
            var reminderExists:Boolean = false;
            for (var i:uint = 0; i < len; i++) {
                if (remindersList[i].getId() === id) {
                    reminderExists = true;
                    break;
                }
            }
            if (reminderExists) {
                return;
            }
            var reminder:Reminder = new Reminder(id, message, priority);
            reminder.x = POSITION_X;
            reminder.y = POSITION_Y_0;
            addChild(reminder);
            remindersList.unshift(reminder);
            repositionReminders();
        }

        public function addReminders(list:Array):void
        {
            var len:int = list.length;
            for (var i:int = 0; i < len; i++) {
                addReminder(list[i].id, list[i].message, list[i].priority);
            }
        }

        public function countReminders():uint
        {
            return remindersList.length;
        }

        /**
         *
         * @return string
         */
        public function getLatestReminder():String
        {
            var len:int = countReminders();
            if (len === 0) {
                return "No Hints Available";
            }
            return remindersList[0].getMessage();
        }

        public function removeLatest():void
        {
            if (remindersList[0] !== undefined) {
                remindersList[0].destroy();
                repositionReminders();
            }
        }

        /*
         * Pass in array of objects
         *
         * object = new Object;
         * object.id = "clothing";
         * object.message = "get clothes";
         * object.priority = "high";
         *
         * add to array
         * array = [object, object2, object3];
         * pass in
         */
        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            draw();
            initialise();
        }

        private function initialise():void
        {
            addEventListener("dismissed", positionReminders);
            if (remindersList.length === 0) {
                noNotifications = new TextField(382, 60, "No Notifications", "Verdana", 30, 0xffffff);
                noNotifications.y = POSITION_Y_0;
                addChild(noNotifications);
            }
        }

        private function positionReminders(e:Event):void
        {
            trace("REMINDERS LENGTH", remindersList.length);
            var index:uint = remindersList.indexOf(e.data.reminder);
            remindersList.splice(index, 1);
            if (countReminders() <= 0) {
                TweenLite.to(noNotifications, TRANSITION_TIME, {alpha: 1});
            } else {
                repositionReminders();
            }
        }

        private function draw():void
        {
            container = new Image(InventoryAssets.getAtlas("mainMenu").getTexture("reminder-container"));
            addChild(container);
        }

        /**
         * Loop backwards
         */
        private function repositionReminders():void
        {
            var len:int = countReminders() - 1;
            for (var i:int = len; i >= 0; --i) {
                var yPos:uint = this["POSITION_Y_" + i];
                trace("yPos s: ", yPos);
                TweenLite.to(remindersList[i], TRANSITION_TIME, {y: yPos});
                trace("element ", remindersList[i]);
            }
        }
    }
}
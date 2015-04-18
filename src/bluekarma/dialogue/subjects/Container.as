package dialogue.subjects
{
    import flash.events.Event;

    import starling.display.Sprite;

    /**
     * ...
     * @author @shaun
     */
    public class Container extends Sprite
    {
        private var active;

        public function Container(active:Boolean = true)
        {
            this.active = active;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function addSubjects(subjects:Array):void
        {
        }

        public function add(subject:Subject):void
        {
            //check if item exists in inventory already
            if (item in itemCollection) {
                trace("item is in array");
            } else {
                //add item to inventory collection
                itemCollection[item._id] = item;
                itemCollection[item._id].scaleX = 1;
                itemCollection[item._id].scaleY = 1;
                itemCollection[item._id].alpha = 0;
                addChild(itemCollection[item._id]);
            }
            organiseLayering();
            trace("adding item to inventory #################");
            trace(item + " has been added to inventory");
            updateItemPositions();
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            //create dictionary to hold subjects
            itemCollection = new Dictionary();
        }
    }
}
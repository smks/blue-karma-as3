package loaders
{
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.display.Loader;

    public class Preloader extends Sprite
    {
        private var textLoaded:TextField;
        private var textFormat:TextFormat;
        //set to one to prevent infinity problem
        private var total:Number = 1;
        private var loaded:Number = 1;

        public function Preloader()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:Event):void
        {
            // remove added to stage listener
            this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            //add textfield
            textLoaded = new TextField();
            textLoaded.border = true;
            textLoaded.textColor = 0xEEEEEE;
            textLoaded.x = (stage.stageWidth / 2) - (textLoaded.width / 2);
            textLoaded.y = (stage.stageHeight / 2) - (textLoaded.height / 2);
            textLoaded.border = false;
            textLoaded.autoSize = "center";
            addChild(textLoaded);
            //format text
            var textFormat:TextFormat = new TextFormat();
            textFormat.size = 32;
            textLoaded.defaultTextFormat = textFormat;
            //loop current load state
            this.addEventListener(Event.ENTER_FRAME, loadGame);
            this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }

        private function onRemovedFromStage(event:Event):void
        {
            this.removeEventListener(Event.ENTER_FRAME, loadGame);
            this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }

        private function loadGame(e:Event):void
        {
            total = stage.loaderInfo.bytesTotal;
            loaded = stage.loaderInfo.bytesLoaded;
            textLoaded.text = Math.floor((loaded / total) * 100) + "%  The total is : " + total + " and loaded is: " + loaded;
            if (total >= loaded || isNaN(total)) {
                initializeGame();
            }
            if (total == 0) {
                initializeGame();
            }
        }

        private function initializeGame():void
        {
            trace("the total is current " + total);
            trace("the loaded is current " + loaded);
            this.removeEventListener(Event.ENTER_FRAME, loadGame);
            trace("game has loaded");
            //dispatch event to say game has loaded
            this.dispatchEvent(new Event("loaded_game"));
        }
    }
}
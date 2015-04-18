package bluekarma.gui.phone.applications
{
    import adobe.utils.CustomActions;

    import assets.GameAssets;
    import assets.InventoryAssets;
    import assets.MenuAssets;

    import com.greensock.easing.Expo;
    import com.greensock.TweenLite;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     * ...
     * @author Shaun Stone
     */
    public class ApplicationMenu extends Sprite
    {
        private const MAX_CONTACTS:uint = 11;
        private const TRANSITION_TIME:Number = 0.75;
        private const POSITION_Y_0:uint = 12;
        private const POSITION_Y_1:uint = 163;
        private const POSITION_Y_2:uint = 315;
        private const POSITION_Y_3:uint = 466;
        private const POSITION_Y_4:uint = 617;
        private var bg:Image;
        private var closeBtn:Button;
        private var appsList:Array;
        private var noContacts:TextField;
        private var debug:Boolean;

        public function ApplicationMenu(_appsList:Array = null, _debug:Boolean = false)
        {
            trace("instance of contact menu");
            // will contain list of contacts
            appsList = new Array();
            if (_appsList !== null) {
                appsList = _appsList;
            }
            debug = _debug;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function addApp(id:String, active:Boolean):void
        {
            var len:uint = countApps();
            if (len <= 5) {
                var app:Application = new Application(id, active);
                app.x = 10;
                appsList.push(app);
                addChild(app);
                repositionApps();
            } else {
                trace("apps menu full");
            }
        }

        public function removeApp(id:String):void
        {
            var len:uint = countApps();
            for (var i:uint = 0; i < len; i++) {
                if (appsList[i].getId() == id) {
                    removeChild(appsList[i], true);
                    appsList.splice(appsList[i], 1);
                }
            }
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            drawMenu();
            if (debug) {
                addDummyApps();
            }
        }

        private function addDummyApps(active:Boolean = true):void
        {
            var app:Application;
            app = new Application(Application.BANKING, active);
            app.x = 10;
            appsList.push(app);
            addChild(app);
            app = new Application(Application.CAMERA, active);
            app.x = 10;
            appsList.push(app);
            addChild(app);
            app = new Application(Application.MICROPHONE, active);
            app.x = 10;
            appsList.push(app);
            addChild(app);
            app = new Application(Application.SOCIAL, active);
            app.x = 10;
            appsList.push(app);
            addChild(app);
            app = new Application(Application.VIDEO, active);
            app.x = 10;
            appsList.push(app);
            addChild(app);
            repositionApps();
        }

        private function repositionApps():void
        {
            var len:int = countApps();
            len--;
            for (var i:int = len; i >= 0; --i) {
                var yPos:uint = this["POSITION_Y_" + i];
                trace("yPos s: ", yPos);
                TweenLite.to(appsList[i], TRANSITION_TIME, {y: yPos});
                trace("element ", appsList[i]);
            }
        }

        private function drawMenu():void
        {
            bg = new Image(InventoryAssets.getAtlas("mainMenu").getTexture("apps_menu"));
            addChild(bg);
            closeBtn = new Button(GameAssets.getTexture("CloseButton"));
            closeBtn.width = 50;
            closeBtn.height = 50;
            closeBtn.x = 160;
            addChild(closeBtn);
            closeBtn.addEventListener("triggered", closeContactMenu);
        }

        private function closeContactMenu(e:Event):void
        {
            // inform parent to remove overlay
            dispatchEventWith("closingSubMenu", true, {menu: "applications"});
            TweenLite.to(this, 0.6, {x: -this.width, ease: Expo.easeInOut});
        }

        private function countApps():uint
        {
            return appsList.length;
        }
    }
}
package screens
{
    import assets.GameAssets;
	import global.Global;

    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import starling.display.Button;
    import starling.display.Image;
    import starling.textures.TextureAtlas;
    import starling.utils.deg2rad;

    //starling imports
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.display.Stage;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;

    import com.greensock.TweenLite;
    import com.greensock.easing.*;

    import assets.MenuAssets;

    /**
     * ...
     * @author Shaun Stone
     */
    public class Instructions extends Sprite
    {
        private const SCREEN_TRANSITION:uint = 1.4;
        private var bg:Image;
        private var title:TextField;
        private var screen1:Image;
        private var screen2:Image;
        private var screen3:Image;
		private var screen4:Image
        private var screenObject1:Object;
        private var screenObject2:Object;
        private var screenObject3:Object;
        private var screenObject4:Object;
        private var closeBtn:Button;
        private var arrowRight:Button;
        private var arrowLeft:Button;
        private var screenList:Array = new Array();
        private var currentScreen:uint = 0;
        private var middleXPos:uint;
        private var middleYPos:uint;;

        public function Instructions()
        {
            super();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            setUp();
        }

        public function goToPreviousScreen():void
        {
            var len:uint = getScreensCount();
            // Move all to the right
            for (var i:uint = 0; i < len; i++) {
                if (currentScreen !== i) {
                    screenList[i].screen.x = -Game.STAGE_WIDTH * 2;
                }
            }
            TweenLite.to(screenList[currentScreen].screen, SCREEN_TRANSITION, {x: Game.STAGE_WIDTH * 2, y: middleYPos});
            if (currentScreen <= 0) {
                currentScreen = len - 1;
                TweenLite.to(screenList[currentScreen].screen, SCREEN_TRANSITION, {x: middleXPos, y: middleYPos});
            } else {
                currentScreen--;
                TweenLite.to(screenList[currentScreen].screen, SCREEN_TRANSITION, {x: middleXPos, y: middleYPos});
            }
            title.text = screenList[currentScreen].title;
        }

        public function goToNextScreen():void
        {
            var len:uint = getScreensCount();
            // Move all to the right
            for (var i:uint = 0; i < len; i++) {
                if (currentScreen !== i) {
                    screenList[i].screen.x = Game.STAGE_WIDTH * 2;
                }
            }
            TweenLite.to(screenList[currentScreen].screen, SCREEN_TRANSITION, {
                x: -Game.STAGE_WIDTH * 2,
                y: middleYPos
            });
            if (currentScreen >= len - 1) {
                currentScreen = 0;
                TweenLite.to(screenList[currentScreen].screen, SCREEN_TRANSITION, {x: middleXPos, y: middleYPos});
            } else {
                currentScreen++;
                TweenLite.to(screenList[currentScreen].screen, SCREEN_TRANSITION, {x: middleXPos, y: middleYPos});
            }
            title.text = screenList[currentScreen].title;
        }

        public function getScreensCount():uint
        {
            return screenList.length;
        }

        private function setUp():void
        {
            middleXPos = Game.STAGE_WIDTH  - 60;
            middleYPos = Game.STAGE_HEIGHT - 30;
        }

        private function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addInstructionsScreen();
            startPositionScreens(currentScreen);
        }

        private function addInstructionsScreen():void
        {
            var atlas:TextureAtlas = MenuAssets.getAtlas(MenuAssets.INSTRUCTIONS);
            bg = new Image(atlas.getTexture("instructions-bg"));
			bg.width = 930;
			bg.height = 670;
            bg.x = 50;
            bg.y = 50;
            addChild(bg);
            title = new TextField(595, 50, "", Global.DEFAULT_FONT, 36, 0xffffff, true);
            title.x = 215;
            title.y = 60;
            addChild(title);
            // add screen 1
            screen1 = new Image(atlas.getTexture("screen1"));
			screen1.width = 771;
			screen1.height = 733;
            screen1.pivotX = screen1.width / 2 + 35;
            screen1.pivotY = screen1.height / 2;
            screen1.x = middleXPos;
            screen1.y = middleYPos;
            addChild(screen1);
            screenObject1 = new Object();
            screenObject1.title = "Decision Wheel";
            screenObject1.screen = screen1;
            // add screen 2
            screen2 = new Image(atlas.getTexture("screen2"));
			screen2.width = 916;
			screen2.height = 564;
            screen2.pivotX = screen2.width / 2;
            screen2.pivotY = screen2.height / 2 + 20;
            screen2.x = middleXPos;
            screen2.y = middleYPos - 20;
            addChild(screen2);
            screenObject2 = new Object();
            screenObject2.title = "Inventory";
            screenObject2.screen = screen2;
            // add screen 3
            screen3 = new Image(atlas.getTexture("screen3"));
			screen3.width = 881;
			screen3.height = 560;
            screen3.pivotX = screen3.width / 2;
            screen3.pivotY = screen3.height / 2 + 20;
            screen3.x = middleXPos;
            screen3.y = middleYPos;
            addChild(screen3);
            screenObject3 = new Object();
            screenObject3.title = "Phone Menu";
            screenObject3.screen = screen3;
			// add screen 4
			screen4 = new Image(atlas.getTexture("medals"));
			screen4.scaleX = 2;
			screen4.scaleY = 2;
            screen4.pivotX = screen4.width / 2 + 120;
            screen4.pivotY = screen4.height / 2 + 60;
            screen4.x = middleXPos;
            screen4.y = middleYPos;
            addChild(screen4);
			screenObject4 = new Object();
            screenObject4.title = "Objective";
            screenObject4.screen = screen4;
            // add to list
            screenList = [screenObject1, screenObject2, screenObject3, screenObject4];
            closeBtn = new Button(GameAssets.getTexture("CloseButton"));
            closeBtn.scaleX = 0.6;
            closeBtn.scaleY = 0.6;
            closeBtn.x = 900;
            closeBtn.y = 60;
            addChild(closeBtn);
            closeBtn.addEventListener(Event.TRIGGERED, closeInstructionsScreen);
            addScreenNavigation();
        }

        private function addScreenNavigation():void
        {
            var arrowUpState:Texture = GameAssets.getTexture("ArrowGameButtonUp");
            var arrowDownDown:Texture = GameAssets.getTexture("ArrowGameButtonDown");
            arrowLeft = new Button(arrowUpState, "", arrowDownDown);
            arrowLeft.pivotX = arrowLeft.width / 2;
            arrowLeft.pivotY = arrowLeft.height / 2;
            arrowLeft.x = 50;
            arrowLeft.y = 384;
            arrowLeft.rotation = deg2rad(270);
            
            addChild(arrowLeft);
            arrowLeft.addEventListener("triggered", previousHandler);
            arrowRight = new Button(arrowUpState, "", arrowDownDown);
            arrowRight.pivotX = arrowRight.width / 2;
            arrowRight.pivotY = arrowRight.height / 2;
            arrowRight.x = 974;
            arrowRight.y = 384
            arrowRight.rotation = deg2rad(90);
            addChild(arrowRight);
            arrowRight.addEventListener("triggered", nextHandler);
        }

        private function nextHandler(e:Event):void
        {
            goToNextScreen();
        }

        private function previousHandler(e:Event):void
        {
            goToPreviousScreen();
        }

        private function closeInstructionsScreen(e:Event):void
        {
            parent.dispatchEventWith("closeInstructionsMenu");
        }

        private function startPositionScreens(index:uint):void
        {
            var len:uint = getScreensCount();
            for (var i:uint = 0; i < len; i++) {
                if (index !== i) {
                    screenList[i].screen.x = Game.STAGE_WIDTH * 2;
                }
            }
            title.text = screenList[currentScreen].title;
        }
    }
}
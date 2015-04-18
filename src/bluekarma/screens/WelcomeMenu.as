package screens
{
    import bluekarma.helpers.transitions.Fader;
	import global.Global;

    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.media.Sound;
    import flash.media.SoundChannel;

    import settings.foregrounds.Overlay;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.display.Button;
    import starling.display.Quad;

    import flash.net.URLRequest;

    //import media
    import assets.MenuAssets;

    import bluekarma.assets.sound.SoundAssets;

    //import library for tweening
    import com.greensock.TweenLite;
    import com.greensock.easing.Expo;

    //fade in
    /**
     * ...
     * @author Shaun Stone
     */
    public class WelcomeMenu extends Sprite
    {
        //images
        private var mainMenuBackground:Image;
        private var title:Image;
        private var brothers:Image;
        private var _fader:Fader;
        //buttons
        private var get_book:Button;
        private var social_smks:Button;
        private var social_facebook:Button;
        private var social_twitter:Button;
        private var social_youtube:Button;
        private var playBtn:Button;
        private var instructionsBtn:Button;
        //url requests
        private var bookUrl:URLRequest;
        private var smksUrl:URLRequest;
        private var facebookUrl:URLRequest;
        private var twitterUrl:URLRequest;
        private var youTubeUrl:URLRequest;
        //classes
        private var instructions:Instructions;
        private var musicChannel:SoundChannel;
        private var overlay:Overlay;

        public function WelcomeMenu()
        {
            super();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        public function cleanUp():void
        {
            MenuAssets.cleanUpMemory();
        }

        private function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            //add graphics to screen
            drawScreen();
        }

        private function drawScreen():void
        {
            //add background
            mainMenuBackground = new Image(MenuAssets.getAtlas().getTexture("main_menu_background"));
            addChild(mainMenuBackground);
            //add game title
            title = new Image(MenuAssets.getAtlas().getTexture("title"));
            title.x = 0;
            title.y = -800;
            title.scaleX = 1.2;
            title.scaleY = 1.2;
            addChild(title);
            //add brothers image
            brothers = new Image(MenuAssets.getAtlas().getTexture("brothers"));
            brothers.x = 0;
            brothers.y = 440;
            brothers.scaleX = 1.4;
            brothers.scaleY = 1.4;
            addChild(brothers);
            //add get book button
            get_book = new Button(MenuAssets.getAtlas().getTexture("get_book"));
            get_book.x = 600;
            get_book.y = 80;
            addChild(get_book);
            //add social button
            social_smks = new Button(MenuAssets.getAtlas().getTexture("social_smks"));
            social_smks.x = 600;
            social_smks.y = 160;
            addChild(social_smks);
            //add social button
            social_facebook = new Button(MenuAssets.getAtlas().getTexture("social_facebook"));
            social_facebook.x = 690;
            social_facebook.y = 160;
            addChild(social_facebook);
            //add social button
            social_twitter = new Button(MenuAssets.getAtlas().getTexture("social_twitter"));
            social_twitter.x = 780;
            social_twitter.y = 160;
            addChild(social_twitter);
            //add social button
            social_youtube = new Button(MenuAssets.getAtlas().getTexture("social_youtube"));
            social_youtube.x = 870;
            social_youtube.y = 160;
            addChild(social_youtube);
            //add play button
            playBtn = new Button(MenuAssets.getAtlas().getTexture("play_off_button"), "", MenuAssets.getAtlas().getTexture("play_on_button"));
            playBtn.x = 600;
            playBtn.y = 281;
            addChild(playBtn);
            //add instructions button
            instructionsBtn = new Button(MenuAssets.getAtlas().getTexture("instructions_off_button"), "", MenuAssets.getAtlas().getTexture("instructions_on_button"));
            instructionsBtn.x = 600;
            instructionsBtn.y = 500;
            addChild(instructionsBtn);
            //add black overlay to fade in
            _fader = new Fader();
            addChild(_fader);
            _fader.fadeOut(5, 1, false);
            initialiseObjects();
            //play music
            playMenuMusicTrack();
            //assign event listeners to buttons
            addListeners();
            addEventListener(Event.ENTER_FRAME, animateObjects)
            addInstructions();
        }

        private function addInstructions():void
        {
            overlay = new Overlay(1, 0.2);
            overlay.visible = false;
            addChild(overlay);
            instructions = new Instructions();
            instructions.y = Game.STAGE_HEIGHT;
            addChild(instructions);
        }

        private function playMenuMusicTrack():void
        {
            musicChannel = SoundAssets.welcomeMenuTheme.play(0, 1);
        }

        private function initialiseObjects():void
        {
            TweenLite.to(title, 4, {x: 60, y: 60, scaleX: 1, scaleY: 1});
            TweenLite.to(brothers, 4, {x: 0, y: 220, scaleX: 1, scaleY: 1});
        }

        private function animateObjects(e:Event):void
        {
            var currentDate:Date = new Date();
            playBtn.y = 281 + (Math.cos(currentDate.getTime() * 0.0010) * 5);
            instructionsBtn.y = 500 + (Math.cos(currentDate.getTime() * 0.0010) * 5);
            brothers.x = 0 + (Math.cos(currentDate.getTime() * 0.0010) * 5);
            title.y = 60 + (Math.cos(currentDate.getTime() * 0.0005) * 5);
            get_book.y = 80 + (Math.cos(currentDate.getTime() * 0.0005) * 5);
            social_smks.y = 160 + (Math.cos(currentDate.getTime() * 0.0005) * 5);
            social_facebook.y = 160 + (Math.cos(currentDate.getTime() * 0.0005) * 5);
            social_twitter.y = 160 + (Math.cos(currentDate.getTime() * 0.0005) * 5);
            social_youtube.y = 160 + (Math.cos(currentDate.getTime() * 0.0005) * 5);
        }

        private function addListeners():void
        {
            //add listener to play button
            playBtn.addEventListener(Event.TRIGGERED, playGame);
            //add listener to instructions
            instructionsBtn.addEventListener(Event.TRIGGERED, showInstructions);
            //add external links
            bookUrl = new URLRequest(Global.BOOK_URL);
            smksUrl = new URLRequest(Global.SMKS_URL);
            facebookUrl = new URLRequest(Global.FACEBOOK_URL);
            twitterUrl = new URLRequest(Global.TWITTER_URL);
            youTubeUrl = new URLRequest(Global.YOUTUBE_URL);
            //assign links to buttons
            get_book.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            social_smks.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            social_facebook.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            social_twitter.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            social_youtube.addEventListener(Event.TRIGGERED, navigateToExternalLink);
            addEventListener("closeInstructionsMenu", onInstructionsMenuClose);
        }

        private function navigateToExternalLink(e:Event):void
        {
            if (get_book.contains(e.currentTarget as Button)) {
                navigateToURL(bookUrl, "_blank");
            } else if (social_smks.contains(e.currentTarget as Button)) {
                navigateToURL(smksUrl, "_blank");
            } else if (social_facebook.contains(e.currentTarget as Button)) {
                navigateToURL(facebookUrl, "_blank");
            } else if (social_twitter.contains(e.currentTarget as Button)) {
                navigateToURL(twitterUrl, "_blank");
            } else if (social_youtube.contains(e.currentTarget as Button)) {
                navigateToURL(youTubeUrl, "_blank");
            }
        }

        private function playGame(e:Event):void
        {
            SoundAssets.buttonClick1.play();
            //fade to black
            _fader.fadeIn(2, 0);
            //fade out music
            if (musicChannel !== null) {
                TweenLite.to(musicChannel, 3, {volume: 0, onComplete: removeMenu});
            } else {
                removeMenu();
            }
        }

        private function removeMenu():void
        {
            if (musicChannel !== null) {
                musicChannel.stop();
            }
            parent.dispatchEventWith(Game.SCREEN_CHANGE, false, {screen: Game.WELCOME});
        }

        private function showInstructions(e:Event):void
        {
            SoundAssets.buttonClick1.play();
            overlay.visible = true;
            openInstructionsMenu();
        }

        private function onInstructionsMenuClose(e:Event):void
        {
            SoundAssets.buttonClick1.play();
            overlay.visible = false;
            closeInstructionsMenu();
        }

        private function closeInstructionsMenu():void
        {
            TweenLite.to(instructions, 1.4, {x: 0, y: Game.STAGE_HEIGHT, ease: Expo.easeInOut});
        }

        private function openInstructionsMenu():void
        {
            TweenLite.to(instructions, 1.4, {x: 0, y: 0, ease: Expo.easeInOut});
        }
    }
}
package bluekarma.settings.backgrounds.albertscar.movingbg
{
    import adobe.utils.CustomActions;

    import assets.GameAssets;
    import assets.Level1Assets;
    import assets.settings.backgrounds.albertscar.moving.MovingBackgroundSlumsAssets;

    import com.greensock.loading.data.ImageLoaderVars;

    import flash.geom.Point;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.utils.Dictionary;

    import settings.backgrounds.albertscar.movingbg.AbstractMovingBackground;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    /**
     * ...
     * @author Shaun Stone
     */
    public class MovingBackgroundSlums extends AbstractMovingBackground
    {
        private const WIDTH:Number = 1024;
        private const HEIGHT:Number = 384;
        public const MAX_HOUSES:uint = 9;
        public const MIN_HOUSES:uint = 0;
        public const RIGHT:String = "RIGHT";
        public const LEFT:String = "LEFT";
        public const MAX_COLLECTION:uint = 12;
        public const COLLECTION_MIDWAY:uint = 6;
        /**
         * This is where houses get positioned
         */
        private const LEFT_HOUSE_0_X:int = 444;
        private const LEFT_HOUSE_0_Y:int = 168
        private const LEFT_HOUSE_0_WIDTH:int = 0.06;
        private const LEFT_HOUSE_0_HEIGHT:int = 0.06;
        private const LEFT_HOUSE_1_X:Number = 326;
        private const LEFT_HOUSE_1_Y:Number = 143;
        private const LEFT_HOUSE_1_WIDTH:Number = 0.12;
        private const LEFT_HOUSE_1_HEIGHT:Number = 0.12;
        private const LEFT_HOUSE_2_X:Number = 402;
        private const LEFT_HOUSE_2_Y:Number = 160;
        private const LEFT_HOUSE_2_WIDTH:Number = 0.24;
        private const LEFT_HOUSE_2_HEIGHT:Number = 0.24;
        private const LEFT_HOUSE_3_X:Number = 176;
        private const LEFT_HOUSE_3_Y:Number = 108;
        private const LEFT_HOUSE_3_WIDTH:Number = 0.48;
        private const LEFT_HOUSE_3_HEIGHT:Number = 0.48;
        private const LEFT_HOUSE_4_X:Number = -13;
        private const LEFT_HOUSE_4_Y:Number = 71;
        private const LEFT_HOUSE_4_WIDTH:Number = 0.72;
        private const LEFT_HOUSE_4_HEIGHT:Number = 0.72;
        private const LEFT_HOUSE_5_X:Number = -500;
        private const LEFT_HOUSE_5_Y:Number = -80;
        private const LEFT_HOUSE_5_WIDTH:Number = 1.44;
        private const LEFT_HOUSE_5_HEIGHT:Number = 1.44;
        private const RIGHT_HOUSE_0_X:Number = 580;
        private const RIGHT_HOUSE_0_Y:Number = 168;
        private const RIGHT_HOUSE_0_WIDTH:Number = -0.06;
        private const RIGHT_HOUSE_0_HEIGHT:Number = 0.06;
        private const RIGHT_HOUSE_1_X:Number = 698;
        private const RIGHT_HOUSE_1_Y:Number = 143;
        private const RIGHT_HOUSE_1_WIDTH:Number = -0.12;
        private const RIGHT_HOUSE_1_HEIGHT:Number = 0.12;
        private const RIGHT_HOUSE_2_X:Number = 622;
        private const RIGHT_HOUSE_2_Y:Number = 160;
        private const RIGHT_HOUSE_2_WIDTH:Number = -0.24;
        private const RIGHT_HOUSE_2_HEIGHT:Number = 0.24;
        private const RIGHT_HOUSE_3_X:Number = 848;
        private const RIGHT_HOUSE_3_Y:Number = 108;
        private const RIGHT_HOUSE_3_WIDTH:Number = -0.48;
        private const RIGHT_HOUSE_3_HEIGHT:Number = 0.48;
        private const RIGHT_HOUSE_4_X:Number = 1037;
        private const RIGHT_HOUSE_4_Y:Number = 71;
        private const RIGHT_HOUSE_4_WIDTH:Number = -0.72;
        private const RIGHT_HOUSE_4_HEIGHT:Number = 0.72;
        private const RIGHT_HOUSE_5_X:Number = 1024;
        private const RIGHT_HOUSE_5_Y:Number = -80;
        private const RIGHT_HOUSE_5_WIDTH:Number = -1.44;
        private const RIGHT_HOUSE_5_HEIGHT:Number = 1.44;
        public const HOUSE_1:String = "house-1";
        public const HOUSE_2:String = "house-2";
        public const HOUSE_3:String = "house-3";
        public const HOUSE_4:String = "house-4";
        public const HOUSE_5:String = "house-5";
        public const HOUSE_6:String = "house-6";
        public const HOUSE_7:String = "house-7";
        public const HOUSE_8:String = "house-8";
        public const HOUSE_9:String = "house-9";
        public const HOUSE_10:String = "house-10";
        public const SKY:String = "sky";
        public const KERB_SLAB:String = "kerb-slab";
        public const ROAD_MARKING:String = "road-marking";
        public const ROAD:String = "road";
        public const DARKNESS:String = "darkness";
        public const LANDSCAPE:String = "moving-layer-1";
        private var centerPoint:Point;
        private var house1:Texture;
        private var house2:Texture;
        private var house3:Texture;
        private var house4:Texture;
        private var house5:Texture;
        private var house6:Texture;
        private var house7:Texture;
        private var house8:Texture;
        private var house9:Texture;
        private var house10:Texture;
        private var roadMarking1:Image;
        private var roadMarking2:Image;
        private var roadMarking3:Image;
        private var cctvLeft:Image;
        private var cctvRight:Image;
        private var road:Image;
        private var skyBg:Image;
        private var landscapeLeft:MovieClip;
        private var landscapeRight:MovieClip;
        private var darkness:Image;
        private var pavingSlab:Image;
        private var houseCollection:Dictionary;
        private var randomHouseCollection:Array;
        private var roadMarkingCollection:Array;
        private var cctvCollection:Array;
        private var text1:TextField;
        private var text2:TextField;
        private var text3:TextField;
        private var text4:TextField;
        private var text5:TextField;
        private var text6:TextField;
        private var text7:TextField;

        public function MovingBackgroundSlums(_speed:uint = 10, _debug:Boolean = false)
        {
            super(_speed, _debug);
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        public function stopMoving():void
        {
            landscapeLeft.stop();
            landscapeRight.stop();
            setSpeed(0);
        }

        public function increaseSpeed(_speed:uint):void
        {
            if (speed > 0) {
                if (!landscapeLeft.isPlaying) {
                    landscapeLeft.play();
                }
                if (!landscapeRight.isPlaying) {
                    landscapeRight.play();
                }
            }
            speed += _speed;
        }

        public function decreaseSpeed(_speed:uint):void
        {
            speed -= _speed;
            if (speed <= 0) {
                stopMoving();
            }
        }

        private function onAdded(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            composeBackground();
            createHouses();
            drawBackground();
			setUpHousesMovement();
            if (debug) {
                addTweaking();
            }
            addDarkness();
        }
		
		private function setUpHousesMovement():void 
		{
			createRandomHouseCollection();
            createRoadMarkings();
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

        private function addDarkness():void
        {
            darkness = new Image(MovingBackgroundSlumsAssets.getAtlas().getTexture(DARKNESS));
            darkness.x = 451;
            darkness.y = 90;
            addChild(darkness);
            var filter:Image = new Image(GameAssets.getTexture("GradientOverlaySlums"));
            addChild(filter);
        }

        private function composeBackground():void
        {
            // This will hold all houses
            houseCollection = new Dictionary();
            // This will create a random list of houses to animate through
            randomHouseCollection = new Array();
            // centre point for where houses should move towards to
            centerPoint = new Point(512, 170);
        }

        private function createHouses():void
        {
            houseCollection[0] = house1 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_1);
            houseCollection[1] = house2 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_2);
            houseCollection[2] = house3 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_3);
            houseCollection[3] = house4 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_4);
            houseCollection[4] = house5 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_5);
            houseCollection[5] = house6 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_6);
            houseCollection[6] = house7 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_7);
            houseCollection[7] = house8 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_8);
            houseCollection[8] = house9 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_9);
            houseCollection[9] = house10 = MovingBackgroundSlumsAssets.getAtlas().getTexture(HOUSE_10);
        }

        private function drawBackground():void
        {
            // First draw sky
            skyBg = new Image(MovingBackgroundSlumsAssets.getAtlas().getTexture(SKY));
            skyBg.scaleX = 4;
            skyBg.scaleY = 4;
			addChild(skyBg);
            landscapeLeft = new MovieClip(MovingBackgroundSlumsAssets.getAtlas().getTextures(LANDSCAPE), 5);
            landscapeLeft.y = 135;
			landscapeLeft.scaleX = 2;
			landscapeLeft.scaleY = 2;
            addChild(landscapeLeft);
            Starling.juggler.add(landscapeLeft);
            landscapeLeft.play();
            landscapeRight = new MovieClip(MovingBackgroundSlumsAssets.getAtlas().getTextures(LANDSCAPE), 5);
            landscapeRight.scaleX = -2;
			landscapeRight.scaleY = 2;
            landscapeRight.x = Game.STAGE_WIDTH;
            landscapeRight.y = 135;
            addChild(landscapeRight);
            Starling.juggler.add(landscapeRight);
            landscapeRight.play();
        }

        private function createCCTVPosts():void
        {
            cctvLeft = new Image(MovingBackgroundSlumsAssets.getAtlas().getTexture("cctv_angle"));
            cctvLeft.scaleX = -1;
            cctvLeft.x = -(cctvLeft.width * 4);
            cctvLeft.y = -100;
            addChild(cctvLeft);
            cctvRight = new Image(MovingBackgroundSlumsAssets.getAtlas().getTexture("cctv_angle"));
            cctvRight.x = 1024 + (cctvRight.width * 4);
            cctvRight.y = -100;
            addChild(cctvRight);
            var leftCamera:Object = new Object();
            leftCamera.id = LEFT;
            leftCamera.image = cctvLeft;
            var rightCamera:Object = new Object();
            rightCamera.id = RIGHT;
            rightCamera.image = cctvRight;
            cctvCollection = new Array(leftCamera, rightCamera);
        }

        private function setSpeed(speed:uint):void
        {
            this.speed = speed;
        }

        private function createRoadMarkings():void
        {
            roadMarking1 = new Image(MovingBackgroundSlumsAssets.getAtlas().getTexture("road-marking"));
            roadMarking1.pivotX = (roadMarking1.width / 2);
            roadMarking1.pivotY = (roadMarking1.height / 2);
            roadMarking1.x = 512;
            roadMarking1.y = 200
            roadMarking1.scaleY = 0.2;
            roadMarking1.scaleY = 0.1;
            addChild(roadMarking1);
            /*
             roadMarking2 = new Image(MovingBackgroundSlumsAssets.getAtlas().getTexture("road-marking"));
             roadMarking2.pivotX = (roadMarking2.width / 2);
             roadMarking2.pivotY = (roadMarking2.height / 2);
             roadMarking2.x = 512;
             roadMarking2.y = 300;
             roadMarking2.scaleY = 0.6;
             roadMarking2.scaleY = 0.3;
             addChild(roadMarking2);

             roadMarking3 = new Image(MovingBackgroundSlumsAssets.getAtlas().getTexture("road-marking"));
             roadMarking3.pivotX = (roadMarking3.width / 2);
             roadMarking3.pivotY = (roadMarking3.height / 2);
             roadMarking3.x = 512;
             roadMarking3.y = 400;
             roadMarking3.scaleY = 0.8;
             roadMarking3.scaleX = 1;
             addChild(roadMarking3);
             */
            //roadMarkingCollection = new Array(
            //	roadMarking1, roadMarking2, roadMarking3
            //);
            roadMarkingCollection = new Array(roadMarking1);
        }

        private function createRandomHouseCollection():void
        {
            var i:uint = 0;
            // get 20 indexes for 20 random houses
            while (i < MAX_COLLECTION) {
                var house:Object = new Object();
                //Determine what side the house should be on
                if (i >= COLLECTION_MIDWAY) {
                    house.side = RIGHT;
                } else {
                    house.side = LEFT;
                }
                // get random number
                var n:uint = getRandomNumber(MIN_HOUSES, MAX_HOUSES);
                // give object image
                house.image = new Image(houseCollection[n]);
                // set index position
                house.position = allocateHousePosition(i);
                // add object to dictionary
                randomHouseCollection[i] = house;
                // position house based on properties
                house = positionHouse(randomHouseCollection[i]);
                addChild(house.image);
                // trace out for debuggin
                trace(house.side);
                trace(house.image);
                trace(house.image.x);
                trace(house.image.y);
                //trace(randomHouseCollection[i].side);
                //trace(randomHouseCollection[i].image);
                //trace("i is", i);
                i++;
            }
        }

        private function allocateHousePosition(i:uint):uint
        {
            switch (i) {
                case (i > 5 && i < 12) :
                    return i - 6;
                case (i > 11 && i < 18) :
                    return i - 12;
                case (i > 17 && i < 21) :
                    return i - 18;
            }
            switch (i) {
                case 6 :
                    return 0;
                case 7 :
                    return 1;
                case 8 :
                    return 2;
                case 9 :
                    return 3;
                case 10 :
                    return 4;
                case 11 :
                    return 5;
                case 12 :
                    return 0;
                case 13 :
                    return 1;
                case 14 :
                    return 2;
                case 15 :
                    return 3;
                case 16 :
                    return 4;
                case 17 :
                    return 5;
                case 18 :
                    return 0;
                case 19 :
                    return 1;
                case 20 :
                    return 2;
            }
            return i;
        }

        private function positionHouse(house:Object):Object
        {
            if ((house.name || house.side || house.image) === null) {
                throw new Error("All house properties need to be set");
            }
            var position:uint = allocateHousePosition(house.position);
            var image:Image = house.image;
            /*
             trace("house position", house.position);
             trace("number of children", this.numChildren);
             trace("what side", house.side);
             trace("x Position", this[house.side+"_HOUSE_"+position+"_X"]);
             trace("y Position", this[house.side+"_HOUSE_"+position+"_Y"]);
             trace("WIDTH", this[house.side+"_HOUSE_"+position+"_WIDTH"]);
             trace("HEIGHT", this[house.side + "_HOUSE_" + position + "_HEIGHT"]);
             */
            trace("positioning house now");
            trace(house.side + "_HOUSE_" + position + "_X");
            trace(this[house.side + "_HOUSE_" + position + "_X"]);
            trace(house.side + "_HOUSE_" + position + "_Y");
            trace(this[house.side + "_HOUSE_" + position + "_Y"]);
            image.x = this[house.side + "_HOUSE_" + position + "_X"];
            if (house.side === RIGHT) {
                //image.x -= house.image.width;
            }
            image.y = this[house.side + "_HOUSE_" + position + "_Y"];
            image.scaleX = this[house.side + "_HOUSE_" + position + "_WIDTH"] * 4;
            image.scaleY = this[house.side + "_HOUSE_" + position + "_HEIGHT"] * 4;
            return house;
        }

        private function enterFrameHandler(e:Event):void
        {
            var len:uint = randomHouseCollection.length;
            var speedValue:Number;
            var XValue:Number;
            var YValue:Number;
            var scaleXValue:Number;
            var scaleYValue:Number;
            var rightOffsetX:Number;
            var rightOffsetY:Number;
            /*******************************************************/
            if (debug) {
                speedValue = Number(text1.text) // 10
                XValue = Number(text2.text) // 1.1
                YValue = Number(text3.text) // 3.9
                scaleXValue = Number(text4.text); //* 0.00105;
                scaleYValue = Number(text5.text); // 0.00105;
                rightOffsetX = Number(text6.text); // 0.00105;
                rightOffsetY = Number(text7.text); // 0.00105;
            } else {
                speedValue = speed; // 10
                XValue = 1.04 // 1.1
                YValue = 3.9 // 3.9
                scaleXValue = 0.001060; //* 0.00105;
                scaleYValue = 0.001060; // 0.00105;
                rightOffsetX = speedValue / 10;
                rightOffsetY = speedValue / 100;
            }
            /************
             * Houses
             */
            for (var i:uint = 0; i < len; i++) {
                var house:Object = randomHouseCollection[i];
                var image:Image = house.image;
                if (house.side == LEFT) {
                    if (image.scaleX <= 0) {
                        image.scaleX = 4;
                        image.scaleY = 4;
                        image.x = -image.width;
                        image.y = LEFT_HOUSE_5_Y;
                        setChildIndex(image, getChildIndex(darkness) - 1);
                    }
                    if (image.scaleY <= 0) {
                        image.scaleX = -4;
                        image.scaleY = -4;
                        image.x = -image.width;
                        image.y = LEFT_HOUSE_5_Y;
                        setChildIndex(image, getChildIndex(darkness) - 1);
                    }
                    if (image.x < (centerPoint.x - image.width)) {
                        image.x += speedValue * XValue;
                    }
                    // make sure doesn't go below vanishing point
                    if (image.y < centerPoint.y) {
                        image.y += speedValue / YValue;
                    }
                    image.scaleX -= (speedValue * scaleXValue) * 4;
                    image.scaleY -= (speedValue * scaleYValue) * 4;
                }
                if (house.side == RIGHT) {
                    if (image.scaleX >= 0) {
                        image.scaleX = -4;
                        image.scaleY = 4;
                        image.x = RIGHT_HOUSE_5_X + image.width;
                        image.y = RIGHT_HOUSE_5_Y;
                        setChildIndex(image, getChildIndex(darkness) - 1);
                    }
                    if (image.scaleY <= 0) {
                        image.scaleX = -4;
                        image.scaleY = 4;
                        image.x = RIGHT_HOUSE_5_X + image.width;
                        image.y = RIGHT_HOUSE_5_Y;
                        setChildIndex(image, getChildIndex(darkness) - 1);
                    }
                    if (image.x > centerPoint.x + image.width) {
                        if (speedValue > 0) {
                            image.x -= speedValue * XValue;
                        }
                    }
                    // make sure doesn't go below vanishing point
                    if (image.y < centerPoint.y) {
                        if (speedValue > 0) {
                            image.y += speedValue / YValue;
                        }
                    }
                    image.scaleX += (speedValue * scaleXValue) * 4;
                    image.scaleY -= (speedValue * scaleYValue) * 4;
                }
            }
            /************
             * Road Markings
             */

            var rLen:uint = roadMarkingCollection.length;
            for (var j:uint = 0; j < rLen; j++) {
                if (roadMarkingCollection[j].scaleX <= 0) {
                    roadMarkingCollection[j].scaleX = 1;
                    roadMarkingCollection[j].scaleY = 1;
                    roadMarkingCollection[j].y = skyBg.height;
                }
                roadMarkingCollection[j].y -= speedValue;
                roadMarkingCollection[j].scaleX -= speedValue * (scaleXValue * 2);
                roadMarkingCollection[j].scaleY -= speedValue * (scaleXValue * 2);
                if (roadMarkingCollection[j].y < (centerPoint.y + roadMarkingCollection[j].height)) {
                    roadMarkingCollection[j].y = (centerPoint.y + roadMarkingCollection[j].height);
                }
            }
            /******
             * CCTV
             */
            /*
             var cctvLen:uint = cctvCollection.length;

             for (var k:uint = 0; k < cctvLen; k++)
             {
             var cc_id:String = cctvCollection[k].id;
             var cc_image:Image = cctvCollection[k].image;

             if (cc_id == LEFT)
             {

             if (cc_image.scaleX <= 0)
             {
             cc_image.scaleX = 1;
             cc_image.scaleY = 1;
             cc_image.x = -(cc_image.width * 2);
             cc_image.y = 150;

             setChildIndex(cc_image, getChildIndex(darkness) - 1);
             }

             if (cc_image.scaleY <= 0)
             {
             cc_image.scaleX = 1;
             cc_image.scaleY = 1;
             cc_image.x = -(cc_image.width * 2);
             cc_image.y = 150;

             setChildIndex(cc_image, getChildIndex(darkness) - 1);
             }

             if (cc_image.x < (centerPoint.x - cc_image.width))
             {
             cc_image.x += speedValue * XValue;
             }

             if (cc_image.y < centerPoint.y)
             {
             cc_image.y += speedValue / YValue;
             }

             cc_image.scaleX -= speedValue * scaleXValue;
             cc_image.scaleY -= speedValue * scaleYValue;
             }

             if (cc_id == RIGHT)
             {

             if (cc_image.scaleX >= 0)
             {
             cc_image.scaleX = -1;
             cc_image.scaleY = 1;
             cc_image.x = stage.stageWidth + (cc_image.width * 2);
             cc_image.y = -200;

             setChildIndex(cc_image, getChildIndex(darkness) - 1);
             }

             if (cc_image.scaleY <= 0)
             {
             cc_image.scaleX = -1;
             cc_image.scaleY = 1;
             cc_image.x = stage.stageWidth + (cc_image.width * 2);
             cc_image.y = -200;

             setChildIndex(cc_image, getChildIndex(darkness) - 1);
             }

             if (cc_image.x > centerPoint.x + cc_image.width)
             {
             if (speedValue > 0)
             {
             cc_image.x -= speedValue * XValue;

             }
             }

             // make sure doesn't go below vanishing point
             if (cc_image.y < centerPoint.y)
             {
             if (speedValue > 0)
             {
             cc_image.y += speedValue / YValue;

             }

             }

             cc_image.scaleX += speedValue * scaleXValue;
             cc_image.scaleY -= speedValue * scaleYValue;
             }
             */
            //}
        }

        /**
         * Used for Debugging
         */
        private function addTweaking():void
        {
            text1 = new flash.text.TextField();
            // Create default text format
            var textFormat:TextFormat = new TextFormat("Arial", 10, 0x000000);
            textFormat.align = TextFormatAlign.LEFT;
            text1.defaultTextFormat = textFormat;
            text1.type = TextFieldType.INPUT;
            text1.x = 100;
            text1.y = 300;
            text1.background = true;
            text1.backgroundColor = 0xffffff;
            text1.text = "0";
            var label1:TextField = new TextField();
            label1.text = "speed";
            label1.textColor = 0xfffff;
            label1.x = 0;
            label1.y = 280;
            Starling.current.nativeOverlay.addChild(label1);
            /*********************************/
            text2 = new flash.text.TextField();
            // Create default text format
            var textFormat2:TextFormat = new TextFormat("Arial", 10, 0x000000);
            textFormat2.align = TextFormatAlign.LEFT;
            text2.defaultTextFormat = textFormat;
            text2.type = TextFieldType.INPUT;
            text2.x = 100;
            text2.y = 400;
            text2.background = true;
            text2.backgroundColor = 0xffffff;
            text2.text = "1.04";
            var label2:TextField = new TextField();
            label2.text = "Y Speed";
            label2.textColor = 0xffffff;
            label2.x = 10;
            label2.y = 380;
            Starling.current.nativeOverlay.addChild(label2);
            /*********************************/
            text3 = new flash.text.TextField();
            // Create default text format
            var textFormat3:TextFormat = new TextFormat("Arial", 10, 0x000000);
            textFormat3.align = TextFormatAlign.LEFT;
            text3.defaultTextFormat = textFormat;
            text3.type = TextFieldType.INPUT;
            text3.x = 100;
            text3.y = 500;
            text3.background = true;
            text3.backgroundColor = 0xffffff;
            text3.text = "3.9";
            var label3:TextField = new TextField();
            label3.text = "X Speed";
            label3.textColor = 0xffffff;
            label3.x = 10;
            label3.y = 480;
            Starling.current.nativeOverlay.addChild(label3);
            /*********************************/
            text4 = new flash.text.TextField();
            // Create default text format
            var textFormat4:TextFormat = new TextFormat("Arial", 10, 0x000000);
            textFormat4.align = TextFormatAlign.LEFT;
            text4.defaultTextFormat = textFormat;
            text4.type = TextFieldType.INPUT;
            text4.x = 100;
            text4.y = 600;
            text4.background = true;
            text4.backgroundColor = 0xffffff;
            text4.text = "0.001055";
            var label4:TextField = new TextField();
            label4.text = "X Scale";
            label4.textColor = 0xffffff;
            label4.x = 10;
            label4.y = 580;
            Starling.current.nativeOverlay.addChild(label4);
            /*********************************/
            text5 = new flash.text.TextField();
            var textFormat5:TextFormat = new TextFormat("Arial", 10, 0x000000);
            textFormat5.align = TextFormatAlign.LEFT;
            text5.defaultTextFormat = textFormat;
            text5.type = TextFieldType.INPUT;
            text5.x = 100;
            text5.y = 700;
            text5.background = true;
            text5.backgroundColor = 0xffffff;
            text5.text = "0.001055";
            var label5:TextField = new TextField();
            label5.text = "Y Scale";
            label5.textColor = 0xffffff;
            label5.x = 10;
            label5.y = 680;
            Starling.current.nativeOverlay.addChild(label5);
            /*********************************/
            text6 = new flash.text.TextField();
            var textFormat6:TextFormat = new TextFormat("Arial", 10, 0x000000);
            textFormat6.align = TextFormatAlign.LEFT;
            text6.defaultTextFormat = textFormat;
            text6.type = TextFieldType.INPUT;
            text6.x = 300;
            text6.y = 700;
            text6.background = true;
            text6.backgroundColor = 0xffffff;
            text6.text = "2";
            var label6:TextField = new TextField();
            label6.text = "X Offset Scale Right";
            label6.textColor = 0xffffff;
            label6.x = 200;
            label6.y = 680;
            Starling.current.nativeOverlay.addChild(label6);
            /*********************************/
            text7 = new flash.text.TextField();
            var textFormat7:TextFormat = new TextFormat("Arial", 10, 0x000000);
            textFormat7.align = TextFormatAlign.LEFT;
            text7.defaultTextFormat = textFormat;
            text7.type = TextFieldType.INPUT;
            text7.x = 300;
            text7.y = 400;
            text7.background = true;
            text7.backgroundColor = 0xffffff;
            text7.text = "0.2";
            var label7:TextField = new TextField();
            label7.text = "Y Offset Scale Right";
            label7.textColor = 0xffffff;
            label7.x = 300;
            label7.y = 380;
            Starling.current.nativeOverlay.addChild(label7);
            /*********************************/
            Starling.current.nativeOverlay.addChild(text1);
            Starling.current.nativeOverlay.addChild(text2);
            Starling.current.nativeOverlay.addChild(text3);
            Starling.current.nativeOverlay.addChild(text4);
            Starling.current.nativeOverlay.addChild(text5);
            Starling.current.nativeOverlay.addChild(text6);
            Starling.current.nativeOverlay.addChild(text7);
        }
    }
}
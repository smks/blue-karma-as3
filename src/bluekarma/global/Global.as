package global
{
    /**
     * @author Shaun Stone
     */
    public class Global
    {
        public static const LEFT:String = "left";
        public static const RIGHT:String = "right";
        public static const UP:String = "up";
        public static const DOWN:String = "down";
        public static const CONTEXT_PROFILE:String = "baseline";
        public static const DEFAULT_FONT:String = "Century Gothic";
        public static const ZERO_SCORE:int = 0;
        /**
         * Colour Scheme
         */
        public static const BLUE_KARMA_BLUE:uint = 0x3a6684;
        public static const BLUE_KARMA_WHITE:uint = 0xffffff;
        public static const BLUE_KARMA_LIGHT_GREY:uint = 0xeeeeee;
        public static const BLUE_KARMA_GREEN:uint = 0x488351;
        public static const BLUE_KARMA_RED:uint = 0xdd4e3f;
        public static const BLUE_KARMA_BLACK:uint = 0x000000;
        static public const BLUE_KARMA_GOLD:uint = 0X8f8f55;
        static public const BLUE_KARMA_DIALOGUE_BLUE:uint = 0xbacedc;
        static public const BLUE_KARMA_GLOW_YELLOW:uint = 0xe6e09d;
		
		static public const BOOK_URL:String = "http://www.smks.co.uk";
		static public const SMKS_URL:String = "http://www.smks.co.uk";
		static public const FACEBOOK_URL:String = "http://www.facebook.com/BlueKarma2013";
		static public const TWITTER_URL:String = "http://www.twitter.com/shaunmstone";
		static public const YOUTUBE_URL:String = "http://www.youtube.com/user/ishaunay89";

        /**
         * Checks to see if a supplied element is in an array.
         * the indexOf function returns -1 if it doesn't find the
         * element in array, so we check if indexOf returns 0 or greater.
         *
         * @param element * (any object) The element we are checking for
         * @param array Array The array to see if element is in
         * @return Boolean True if element is found in array, False if not
         */
        public static function inArray(element:*, array:Array):Boolean
        {
            return (array.indexOf(element) >= 0);
        }

        /**
         *
         * @param    min
         * @param    max
         * @return
         */
        public static function getRandomNumber(low:Number = 0, high:Number = 1):Number
        {
            return Math.floor(Math.random() * (1 + high - low)) + low;
        }

        /**
         * Acts need to be done by a certain time of the day/night
         *
         * @param    currentTime
         * @param    timeDeadline
         * @return
         */
        public static function stillHasTimeToContinue(currentTime:Date, timeDeadline:Date):Boolean
        {
            var date1Timestamp:Number = currentTime.getTime();
            var date2Timestamp:Number = timeDeadline.getTime();
            if (date1Timestamp >= date2Timestamp) {
                return false;
            }
            return true;
        }

        public static function mergeArrays(a1:Array, a2:Array):Array
        {
            var result:Array = [];
            var i1:int = 0, i2:int = 0;
            while (i1 < a1.length && i2 < a2.length) {
                if (a1[i1] < a2[i2]) {
                    result.push(a1[i1]);
                    i1++;
                } else if (a2[i2] < a1[i1]) {
                    result.push(a2[i2]);
                    i2++;
                } else {
                    result.push(a1[i1]);
                    i1++;
                    i2++;
                }
            }
            while (i1 < a1.length) {
                result.push(a1[i1++]);
            }
            while (i2 < a2.length) {
                result.push(a2[i2++]);
            }
            return result;
        }

        /**
         *
         * @param    arr
         * @return
         */
        public static function removeDuplicates(arr:Array):Boolean
        {
            var dupe:Boolean = false;
            var i:int;
            var j:int;
            for (i = 0; i < arr.length - 1; i++) {
                for (j = i + 1; j < arr.length; j++) {
                    if (arr[i] === arr[j]) {
                        arr.splice(j, 1);
                        dupe = true;
                    }
                }
            }
            return dupe;
        }
		
		public static function formatWithCommas(x:Number):String {
			var s:String;
			return (s=int(x).toString()).substring(0, s.length%3) + (s.length > 3 ? "," : "") + (s=s.substring(s.length%3).split(/.{3}/).join(",")).substring(0, s.length-1) + (x != int(x) ? "." + (x-int(x)) : "");
		}
    }
}
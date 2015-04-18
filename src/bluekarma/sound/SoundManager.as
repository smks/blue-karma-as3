/**
 * This class is manage the tracks that loop
 * but we may want to fade in or out.
 */
package sound 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	/**
	 * @author @shaun
	 */
	public class SoundManager 
	{
		/**
		 * Container for all our sounds
		 */
		private static var soundManager:Dictionary = new Dictionary();
		
		/**
		 * 
		 * @param name
		 * @param sound
		 */
		public static function addSound(name:String, soundToPlay:Sound, loopCount:uint = 1, volume:Number = 1):void
		{
			if (soundManager[name] !== undefined) {
				trace("This sound has been already added");
				return;
			}
			
			// add the sound to a channel so we can make amendments
			var soundChannel:SoundChannel = new SoundChannel();
			var soundTransform:SoundTransform = new SoundTransform();
			soundTransform.volume = volume;
			soundChannel.soundTransform = soundTransform;
			soundManager[name] = soundChannel = soundToPlay.play(0, loopCount);
		}
		
		/**
		 * 
		 * @param name
		 */
		public static function stopSound(name:String, remove:Boolean = false):void
		{
			soundManager[name].stop();
			
			if (remove) {
				delete soundManager[name];
			}
		}
		
		public static function fadeIn(name:String, duration:uint = 5):void 
		{
			TweenLite.to(soundManager[name], duration, {volume: 1});
		}
		
		/**
		 * 
		 * @param name
		 */
		public static function fadeOutAndRemove(name:String, duration:uint = 5):void
		{
			if (soundManager[name] === undefined) {
				trace("Sound is not being faded out, doesn't exist");
				return;
			}
			
			TweenMax.to(soundManager[name], duration, { volume: 0, onComplete: function():void {
				stopSound(name, true);
			}});
		}
		
	}

}
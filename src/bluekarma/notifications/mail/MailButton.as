package notifications.mail 
{
	import assets.MailAssets;
	import starling.display.Button;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Shaun Stone
	 */
	public class MailButton extends Button 
	{
		public function MailButton(upState:Texture = null, text:String="", downState:Texture=null, overState:Texture=null, disabledState:Texture=null)
		{
			upState = MailAssets.getAtlas().getTexture(MailAssets.MAIL_BUTTON);
			super(upState, text, downState, overState, disabledState);
		}
	}

}
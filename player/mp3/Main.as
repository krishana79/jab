﻿package  {
	
	import flash.display.MovieClip;
	import Mp3Player;
	import flash.events.MouseEvent;
	
	public class Main extends MovieClip {
		var player:Mp3Player;
		
		public function Main() {
			// constructor code
			player = new Mp3Player();
			pause_btn.addEventListener(MouseEvent.CLICK, onPause);
			play_btn.addEventListener(MouseEvent.CLICK, onPlay);
			vol_mc.addEventListener(MouseEvent.CLICK, onVolToggle);
			
			pause_btn.mouseChildren = false;
			play_btn.mouseChildren = false;
			
			playMusic();
		}
		public function playMusic():void
		{
			trace("Initiating Music!!")
			player.play('https://dhcjctspyg3hl.cloudfront.net/sample_audio.mp3');
		}
		public function onPause(e:MouseEvent):void
		{
			player.pause();
		}
		public function onPlay(e:MouseEvent):void
		{
			player.unpause();
		}
		public function onVolToggle(e:MouseEvent):void
		{
			if(player.volume == 1){
				player.volume = 0
				vol_mc.gotoAndStop(2)
			}else{
				player.volume = 1
				vol_mc.gotoAndStop(1)
			}
		}
	}
	
}

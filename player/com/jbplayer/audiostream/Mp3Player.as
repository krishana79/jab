﻿package com.jbplayer.audiostream
{

	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;

	public class Mp3Player extends EventDispatcher
	{
		static public const EVENT_TIME_CHANGE:String = 'Mp3Player.TimeChange';
		static public const EVENT_VOLUME_CHANGE:String = 'Mp3Player.VolumeChange';
		static public const EVENT_PAN_CHANGE:String = 'Mp3Player.PanningChange';
		static public const EVENT_PAUSE:String = 'Mp3Player.Pause';
		static public const EVENT_UNPAUSE:String = 'Mp3Player.Unpause';
		static public const EVENT_PLAY:String = 'Mp3Player.Play';

		public var playing:Boolean;
		public var playlist:Array;
		public var currentUrl:String;
		public var playlistIndex:int = -1;

		private var sound:Sound;
		private var soundChannel:SoundChannel;
		private var soundTrans:SoundTransform;
		private var progressInt:Number;

		/*public function Mp3Player() {
		// constructor code
		trace("hello")
		
		}*/
		public function play(url:String ):void
		{
			//trace(url+" - "+sound);
			//clearInterval(progressInt);
			if (sound)
			{
				soundChannel.stop();
				try
				{
					sound.close();
				}
				catch (error:Error)
				{
					trace(error);
				}
			}
			currentUrl = url;

			sound = new Sound();
			sound.addEventListener(Event.SOUND_COMPLETE, onLoadSong);
			sound.addEventListener(Event.ID3, onId3Info);

			sound.load(new URLRequest(currentUrl));

			soundChannel = sound.play();

			if (soundTrans)
			{
				soundChannel.soundTransform = soundTrans;
			}
			else
			{
				soundTrans = soundChannel.soundTransform;
			}
			soundChannel.addEventListener(Event.COMPLETE, onSongEnd);
			soundChannel.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			playing = true;
			clearInterval(progressInt);
			progressInt = setInterval(updateProgress,30);
			dispatchEvent(new Event(EVENT_PLAY));

		}
		public function pause():void
		{
			if (soundChannel)
			{
				soundChannel.stop();
				dispatchEvent(new Event(EVENT_PAUSE));
				playing = false;
			}
		}
		public function unpause():void
		{
			if (playing)
			{
				return;
			}
			if (soundChannel.position < sound.length)
			{
				soundChannel = sound.play(soundChannel.position);
				soundChannel.soundTransform = soundTrans;
			}
			else
			{
				soundChannel = sound.play();
			}
			dispatchEvent(new Event(EVENT_UNPAUSE));
			playing = true;
		}
		public function seek( percent:Number ):void
		{
			soundChannel.stop();
			soundChannel = sound.play(sound.length * percent);
		}
		public function get volume():Number
		{
			if (! soundTrans)
			{
				return 0;
			}
			return soundTrans.volume;
		}
		public function set volume( n:Number ):void
		{
			if (! soundTrans)
			{
				return;
			}
			soundTrans.volume = n;
			trace("sound vol "+n)
			soundChannel.soundTransform = soundTrans;
			dispatchEvent(new Event(EVENT_VOLUME_CHANGE));
		}
		public function get pan():Number
		{
			if (! soundTrans)
			{
				return 0;
			}
			return soundTrans.pan;
		}
		public function set pan( n:Number ):void
		{
			if (! soundTrans)
			{
				return;
			}
			soundTrans.pan = n;
			soundChannel.soundTransform = soundTrans;
			dispatchEvent(new Event(EVENT_PAN_CHANGE));
		}
		public function get length():Number
		{
			return sound.length;
		}
		public function get time():Number
		{
			return soundChannel.position;
		}
		protected function onLoadSong( e:Event ):void
		{
			trace("End of song!! - onLoadSong");
		}
		protected function onSongEnd( e:Event ):void
		{
			trace("End of song!! - onSongEnd");
		}
		protected function onIOError(e:Event):void
		{
			dispatchEvent(new Event("ERROR_AUDIO_FILE"));
			trace("IOError Handled here!!");
		}
		protected function onId3Info( e:Event ):void
		{
			dispatchEvent(new Event(Event.ID3, e.target.id3));
		}
		protected function updateProgress():void
		{
			//trace("timePercent: "+timePercent);
			dispatchEvent(new Event(EVENT_TIME_CHANGE));
			if ( timePercent >= .99 )
			{
				onSongEnd(new Event(Event.COMPLETE));
				clearInterval(progressInt);
			}
		}
		public function get timePercent():Number
		{
			if (! sound.length)
			{
				return 0;
			}
			return soundChannel.position / sound.length;
		}
	}

}
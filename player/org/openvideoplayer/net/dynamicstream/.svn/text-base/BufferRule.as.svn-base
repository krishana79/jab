package org.openvideoplayer.net.dynamicstream 
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	
	import org.openvideoplayer.events.OvpEvent;

	/**
	 * Dispatched when a debug message is being sent. The message itself will
	 * be carried by the contents of the data property.
	 * 
	 * @see org.openvideoplayer.events.OvpEvent
	 */
 	[Event (name="debug", type="org.openvideoplayer.events.OvpEvent")]
 	
	/**
	 * Switching rule for Buffer detection.
	 */
	public class BufferRule extends EventDispatcher implements ISwitchingRule {

		
		/* TUNABLE PARAMETERS FOR THIS RULE */
		
		private const PANIC_BUFFER_LEVEL:Number = 2;
		
		/* END TUNABLE PARAMETERS */
		

		private var _metrics:INetStreamMetrics;
		private var _panic:Boolean;
		private var _reason: String;
		
		/**
		 * Constructor
		 * 
		 * @param a metrics provider which implements the INetStreamMetrics interface
		 */
		public function BufferRule(metrics:INetStreamMetrics):void {
			super(null);
			_metrics = metrics;
			_metrics.netStream.addEventListener(NetStatusEvent.NET_STATUS,monitorNetStatus);
			_panic = false;
		}
		
		/**
		 * The new bitrate index to which this rule recommends switching. If the rule has no change request, either up or down, it will
		 * return a value of -1. 
		 * 
		 */
        public function getNewIndex():int { 
			if (!_panic) {
				_reason = "Buffer  of " + Math.round(_metrics.bufferLength)  + " < " + PANIC_BUFFER_LEVEL + " seconds";
			}
			return _panic  || (_metrics.bufferLength < PANIC_BUFFER_LEVEL && _metrics.reachedTargetBufferFull)? 0:-1;
		}
		
		/** 
		 * @private
		 */
		private function monitorNetStatus(e:NetStatusEvent):void {
			switch (e.info.code) {
				case "NetStream.Buffer.Full":
					_panic = false;
				break;
				case "NetStream.Buffer.Empty":
				if (Math.round(_metrics.netStream.time) != 0) {
					_panic = true;
					_reason = "Buffer was empty";
				}
				break;
				case "NetStream.Play.InsufficientBW":
					_panic = true;
					_reason = "Stream had insufficient bandwidth";
				break;
			}
		}
		
		/**
		 * Returns the reason the rule is suggesting the new index. This information is intended to be read by humans
		 * and may be used during the debugging process. 
		 */
		public function get reason():String {
			return _reason;
		}
    }
}

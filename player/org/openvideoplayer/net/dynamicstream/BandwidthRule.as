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
	 * Switching rule for Bandwidth detection.
	 */
	public class BandwidthRule extends EventDispatcher implements ISwitchingRule {
		
		/* TUNABLE PARAMETERS FOR THIS RULE */
		
		private const BANDWIDTH_SAFETY_MULTIPLE:Number = 1.15;
		
		/* END TUNABLE PARAMETERS */
		
		private var _metrics:INetStreamMetrics;
		private var _panicMode:Boolean;
		private var _reason:String;
		
		/**
		 * Constructor
		 * 
		 * @param a metrics provider which implements the INetStreamMetrics interface
		 */
		public function BandwidthRule(metrics:INetStreamMetrics):void {
			super(null);
			_metrics = metrics;
		}
		
		/**
		 * The new bitrate index to which this rule recommends switching. If the rule has no change request, either up or down, it will
		 * return a value of -1. 
		 * 
		 */
        public function getNewIndex():int {
        	var newIndex:int = -1;
        	// Wait until the metrics class can calculate a stable average bandwidth
        	if (_metrics.averageMaxBandwidth != 0) {
				// First find the preferred bitrate level
				for (var i:int = _metrics.dynamicStreamItem.streamCount-1; i >= 0; i--) {
							if (_metrics.averageMaxBandwidth > _metrics.dynamicStreamItem.getRateAt(i)*BANDWIDTH_SAFETY_MULTIPLE ) {
								newIndex = i;
								_reason = "Average bandwidth of " + Math.round(_metrics.averageMaxBandwidth) + " < " + BANDWIDTH_SAFETY_MULTIPLE + " * rendition bitrate";
								break;
							}
				}
				if (newIndex > _metrics.currentIndex) {
	        		// We switch up only if conditions are perfect - no framedrops and a stable buffer
	        		newIndex = (_metrics.droppedFPS < 2 && _metrics.bufferLength > _metrics.targetBufferTime) ? newIndex:-1;
					_reason = "Move up since avg dropped FPS " + Math.round(_metrics.droppedFPS) + " < 2 and bufferLength > " + _metrics.targetBufferTime;
	        	}
        	} 
        	 
        	 return newIndex;
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


package org.openvideoplayer.net.dynamicstream
{
	import flash.events.IEventDispatcher;
	
	/**
	 * Rules Interface
     * Defines an interface for heuristics switching rules to implement in order
     * to be callable by the managing dynamic stream class. 
	 */
	public interface ISwitchingRule extends IEventDispatcher {
		

		/**
		 * Returns the index value in the active DSI to which this heuristics implementation thinks
		 * the bitrate should shift.  It's up to the calling function to act on this. This index 
		 * will range in value from -1 to n-1,where n is the number of bitrate items available.
		 * A value of -1 means that this rule does not suggest a switch away from the current item. A
		 * value from 0 to n-1 indicates that the caller should switch to that index immediately.
		 */
        function getNewIndex():int;
		
		/**
		 * Returns the reason the rule is suggesting the new index. This information is intended to be read by humans
		 * and may be used during the debugging process. 
		 */
		function get reason():String;
    }
}

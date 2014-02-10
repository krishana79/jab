
package org.openvideoplayer.net.dynamicstream
{
	import flash.net.NetStream;
	
	/**
	 * NetStream Metrics Interface
     * Defines an interface that a class must implement to provide netstream metrics
     * for dynamic switching rules. 
	 */
	public interface INetStreamMetrics
	{
		function get reachedTargetBufferFull():Boolean;
		
		function set targetBufferTime(targetBufferTime:Number):void;
		
		function get targetBufferTime():Number;
		
		function get expectedFPS():Number;
		
		function get droppedFPS():Number;
		
		function get maxBandwidth():Number;
		
		function get averageMaxBandwidth():Number;
		
		function get averageDroppedFPS():Number;
		
		function get currentIndex():uint;
		
		function get maxIndex():uint;
		
		function get dynamicStreamItem():DynamicStreamItem;
		
		function get bufferLength():Number;
		
		function get bufferTime():Number;
		
		function get netStream():NetStream;
		
		function get optimizeForLivebandwidthEstimate ():Boolean;
		
		function set optimizeForLivebandwidthEstimate (optimizeForLivebandwidthEstimate:Boolean):void;
		
		function enable():void;
		
		function disable():void
		

	}
}

package org.openvideoplayer.net
{
	import flash.events.IEventDispatcher;
	import flash.net.Responder;
	
	//-----------------------------------------------------------------
	//
	// Events
	//
	//-----------------------------------------------------------------
	
 	/**
	 * Dispatched when an exception is thrown asynchronously — that is, from native asynchronous code.
	 * 
	 * @eventType flash.events.AsyncErrorEvent.ASYNC_ERROR
	 */
 	[Event (name="asyncError", type="flash.events.AsyncErrorEvent.ASYNC_ERROR")]
	
	/**
	 * 	Dispatched when an input or output error occurs that causes a network operation to fail.
	 *
	 * @eventType flash.events.IOErrorEvent.IO_ERROR
	 */
	[Event (name="ioError", type="flash.events.IOErrorEvent.IO_ERROR")]
	
	/**
	 * 	Dispatched when a NetConnection object is reporting its status or error condition.
	 * 
	 * @eventType flash.events.NetStatusEvent.NET_STATUS
	 */
	[Event (name="netStatus", type="flash.events.NetStatusEvent.NET_STATUS")]
	
	/**
	 * Dispatched if a call to NetConnection.call() attempts to connect to a server outside the caller's security sandbox.		
	 */
	 [Event (name="securityError", type="flash.events.SecurityErrorEvent.SECURITY_ERROR")]
	 
	/**
	 * The INetConnection interface declares the properties and methods for a class implementing NetConnection behavior.
	 */
	public interface INetConnection extends IEventDispatcher
	{
		//-----------------------------------------------------------------
		//
		// Properties
		//
		//-----------------------------------------------------------------
		
		/**
		 * Indicates whether the application is connected to a server through a persistent RTMP connection (true) or not (false).
		 */
 	 	function get connected():Boolean;
 	 	
		/**
		 * If a successful connection is made, indicates the method that was used to make it: a direct connection, the CONNECT method, or HTTP tunneling.
		 */
 	 	function get connectedProxyType():String;
	
		/**
		 * The object encoding for this NetConnection instance.
		 */
 	 	function get objectEncoding():uint;
 	 	function set objectEncoding(value:uint):void;
	
		/**
		 * Determines which fallback methods are tried if an initial connection attempt to the server fails.
		 */
 	 	function get proxyType():String;
 	 	function set proxyType(value:String):void;
	
		/**
		 * The URI passed to the NetConnection.connect() method.
		 */
 	 	function get uri():String;
 	 	
 	 	/**
 	 	 * Indicates whether a secure connection was made using native Transport Layer Security (TLS) rather than HTTPS.
 	 	 */
		function get usingTLS():Boolean;
		
		//-----------------------------------------------------------------
		//
		// Methods
		//
		//-----------------------------------------------------------------
		
		/**
		 * Adds a context header to the Action Message Format (AMF) packet structure.
		 */
 	 	function addHeader(operation:String, mustUnderstand:Boolean = false, param:Object = null):void;
	
		/**
		 * Invokes a command or method on Flash Media Server or on an application server running Flash Remoting.
		 */
 	 	function call(command:String, responder:Responder, ... arguments):void;
	
		/**
		 * Closes the connection that was opened locally or to the server and dispatches a netStatus event with a code property of NetConnection.Connect.Closed.
		 */
 	 	function close():void;
	
		/**
		 * Creates a bidirectional connection between a Flash Player or an AIR application and a Flash Media Server application.		
		 */
 	 	function connect(command:String, ... arguments):void;
	}
}

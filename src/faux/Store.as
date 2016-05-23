package faux
{
	import com.demonsters.debugger.MonsterDebugger;

	public class Store
	{
		private var state:Object;
		private var subscribers:Vector.<Function>;
		
		public function Store(initialState:Object = null)
		{
			this.state = initialState;
			this.subscribers = new <Function>[];
		}
		
		public function setState(state:Object):void {
			this.state = state;
			this.subscribers.forEach(function(subscriber:Function, i:*, v:*):void {
				subscriber(this.state);
			}, this);
			MonsterDebugger.inspect(this.state);
		}
		
		public function getState():Object
		{
			return this.state;
		}
		
		public function subscribe(subscriber:Function):void {
			this.subscribers.push(subscriber);
		}
	}
}
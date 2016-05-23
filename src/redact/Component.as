package redact
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Component extends Sprite
	{
		protected var props:Object;
		
		public function Component(props:Object = null)
		{
			super();
			
			this.props = props;
			
			addEventListener(Event.ADDED_TO_STAGE, _onAdded, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, _onRemoved, false, 0, true);
		}
		
		private function _onAdded(e:Event):void {
			this.onAdded();
			
			update();
		}
		
		private function _onRemoved(e:Event):void {
			this.onRemoved();
			this.props = null;
		}
		
		public function setProps(props:Object):void {
			
			const newProps:Object = props;
			const needsUpdate:Boolean = shouldUpdate(newProps);
			
			this.props = newProps;
			
			if(needsUpdate) {
				update();
			}
		}
		
		public function getProps():Object {
			return this.props;
		}
		
		public function shouldUpdate(newProps:Object):Boolean {
			return true;
		}
		
		public function update():void {	}
		public function onAdded():void { }
		public function onRemoved():void {}
	}
}
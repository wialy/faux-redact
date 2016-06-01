package redact {
import faux.ObjectUtil;

import flash.display.Sprite;
import flash.events.Event;

public class Component extends Sprite {
    protected var props:Object;
    protected var state:Object;

    public function Component(props:Object = null) {
        super();

        this.props = props;

        addEventListener(Event.ADDED_TO_STAGE, _onAdded);
    }

    private function _onAdded(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, _onAdded);

        this.onAdded();
        update();

        addEventListener(Event.REMOVED_FROM_STAGE, _onRemoved);
    }

    private function _onRemoved(e:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, _onRemoved);

        this.onRemoved();
        this.props = null;
    }

    /* Props */
    public function setProps(props:Object):void {

        const newProps:Object = props;
        const needsUpdate:Boolean = shouldUpdate(newProps);

        this.props = newProps;

        if (needsUpdate) {
            update();
        }
    }

    public function mergeProps(props:Object):void {
        setProps(ObjectUtil.merge(this.props, props));
    }

    public function getProps():Object {
        return this.props;
    }

    /* state */

    public function setState(state:Object):void {
        const newState:Object = state;
        const needsUpdate:Boolean = shouldUpdate(this.props, newState);

        this.state = newState;

        if (needsUpdate) {
            update();
        }
    }

    public function mergeState(state:Object):void {
        setState(ObjectUtil.merge(this.state || {}, state));
    }

    public function getState():Object {
        return this.state;
    }

    public function shouldUpdate(newProps:Object = null, newState:Object = null):Boolean {
        return true;
    }

    public function update():void {
    }

    public function onAdded():void {
    }

    public function onRemoved():void {
    }
}
}
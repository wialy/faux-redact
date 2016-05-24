package faux {
import com.demonsters.debugger.MonsterDebugger;

public class Store {
    private var state:Object;
    private var subscribers:Vector.<Function>;

    private var reducer:Reducer;

    public function Store(reducer:Reducer, initialState:Object = null) {
        this.reducer = reducer;

        this.state = initialState;
        this.subscribers = new <Function>[];
    }

    public function setState(state:Object):void {
        if (this.state == state)
            return;
        this.state = state;
        this.subscribers.forEach(function (subscriber:Function, i:*, v:*):void {
            subscriber(this.state);
        }, this);
        MonsterDebugger.inspect(this.state);
    }

    public function mergeState(state:Object):void {
        setState(ObjectUtil.merge(this.getState(), state));
    }

    public function getState():Object {
        return this.state;
    }

    public function dispatch(action:Object):void {
        setState(reducer.reduce(getState(), action));
    }

    public function subscribe(subscriber:Function):void {
        this.subscribers.push(subscriber);
    }
}
}
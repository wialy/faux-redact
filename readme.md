# Faux + Redact
This is an attempt to recreate the basics of [Redux](https://github.com/reactjs/redux) and [React](https://facebook.github.io/react/) in ActionScript3. Treat it like an experiment.

## NB
- States are not trully immutable, this is just a convention.
- While in development stage, there's a [Monster Debugger](http://www.monsterdebugger.com/) dependecy in classes.

## TODO
- [x] Store
- [x] Actions
    - [ ] Async actions
- [x] Reducers
    - [x] Combined reducers
* [x] Component
    - [x] Props
    - [x] State
    - [x] Lifetime cycle methods

## Faux
Faux is an ActionScript3 nanoframework inspired by Redux. The primary goal is to have all data stored in one `store` object and subscribe to it's `states` changes via `subscribe` method.

### Store

#### Create store
The constructor takes two params: `reducer` (described below) and optional `initialState`:
```
public function Store(reducer:Reducer, initialState:Object = null)
```
Initializing a simple store looks like:
```
const store: Store = new Store( new Reducer(), { count:0 });
```
#### Change state
```
store.setState({ count: 1 });
store.getState();
```
In real application, setting the store's stated should not be made directly.
Instead, use a `dispatch` method described later.

#### Subscribe to changes
Every time setState is performed, the `subscribers` are called with a new state.
```
store.subscribe( function (state: Object):void { ... } );
```
#### ObjectUtil.as
There's an object util class included with Faux, which has, for now, one important method `merge` :

```
public static function merge(...objects):Object { ... }
```
This method merges several objects into a new one.
This is useful when settings store's state, for example:

```
const initialState: Object = { count: 0, title: 'Just a counter store' };
const store: Store = new Store( initialState );
...
const state: Object = store.getState();
store.setState(
	ObjectUtil.merge( state, { count: state.count + 1 } )
);
store.getState(); // { count: 1, title: 'Just a counter store' }
```
[Monster Debugger](http://www.monsterdebugger.com/) users bonus: store's `state` is inspected in debugger.

### Reducer

Reducer performs calculation of next state to be set after executunig an action. The `reduce` method take two params: `state` - the current store's state, and `actions` - an object describing the action made on store.

Calling the `reduce` method of base reducer returns current state, so no update will happen:

```
public function reduce(state:Object, action:Object):Object {
    return state;
}
```

An example of performing simple action:
```
override public function reduce(state:Object, action:Object):Object {
    var result:Object = state;
    switch (action.type) {
        case Action.SET_CURRENT_SECTION:
            result = ObjectUtil.merge(result, {
                currentSection: action.payload
            })
            break;
    }
    return result;
}
```

Nested reducers are easy to implement:
```
override public function reduce(state:Object, action:Object):Object {
	return ObjectUtil.merge(
		appState: appState.reduce(state.appState),
		userState: userReducer.reduce(state.userState)
	);
}
```

### Action
Action is an object, containig data for the reducer. By [Flux Standard Action](https://github.com/acdlite/flux-standard-action) design the action consists of:

```
{
	type: 'ACTION_TYPE',	// a string with action type name
							// the only required field

	payload: { ... },		// data to passed to stored

	error: true,			// set only when error occures
							// In that case, the payload contains error data
							// null when no error

	meta: { ... }			// other action data, that is not stored in states
							// async action may contain their status here:
							// 'start' | 'progress' | 'success' | 'error'
}
```

#### Dispatching an action
To perform an action, store's `dispatch` method should be called:
```
store.dispatch(action);
```

You may pass a store's `dispach` method to component via it's props. It allows calling a store update form view:
```
const app: App = new App({
	dispatch: store.dispatch,
	otherData: ...
})
```

Somewhere in App.as
```
const menu: Menu = new Menu({
	onClickItem: function(itemId):void {
		props.dispatch({ type: Action.SET_SECTION, payload: {
			sectionId: itemId,
			otherData: ...
		})
	}
}
})
```

Menu.as:
```
class Menu extends Component {
...
private function onButtonTriggered( btn:SomeButton ):void {
	this.props.onClickItem( btn.id );
}
...
}
```

#### Action creators
Sometimes, when action have complicated logic, it is useful to create an action creator (or factory function):
```
function changeSection(sectionId:String, sectionData:Object): Object {
	return {
		type: 'SET_SECTION',
		payload: { ... }
	}
}
```
The action creator should be a [pure function](https://en.wikipedia.org/wiki/Pure_function), i.e. don't depend on some external data.

## Redact
AS3 component-thinking approach of building apps inspired by React. The best approach of making it in Flash is still to be discovered.

#### Component
The base class is `Component`, which receives initial propertines in it's constructor:

```
public function Component(props:Object = null) { ... }
```

#### Change properties
```
public function setProps(props:Object):void 
public function getProps():Object
```

#### Component lifecycle
Functions to override:
```
// Best place for update logic
public function update():void {	}

// These two are called just after the component
// is added/removed to/from stage
public function onAdded():void { }
public function onRemoved():void { }

// Determine, if the update function should be called when
// new properties are set.
// Default is always true.
public function shouldUpdate(newProps:Object):Boolean { return true }
```

### Thoughts and ideas?
Feel free to add any [issues!](https://github.com/wialy/faux-redact/issues)








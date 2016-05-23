# Faux + Redact
This is an attempt to recreate the basics of [Redux](https://github.com/reactjs/redux) and [React](https://facebook.github.io/react/) in ActionScript3. Treat it like an experiment.

## NB
- States are not trully immutable, this is just a convention.
- While in development stage, there's a [Monster Debugger](http://www.monsterdebugger.com/) dependecy in classes.

## TODO
* [x] Faux Store
* [ ] Faux actions
* [ ] Faux reducers
* [x] Redact Component

## Faux
Faux is an ActionScript3 nanoframework inspired by Redux. The primary goal is to have all data stored in one `store` object and subscribe to it's `states` changes via `subscribe` method.

#### Create store
```
const store: Store = new Store({ count:0 });
```
#### Change state
```
store.setState({ count: 1 });
store.getState();
```
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
This method merges several objects into one new. It is useful when settings store's state, for example:

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


## Redact
AS3 component-thinking approach of building apps inspired by React.

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








package faux {
public class ObjectUtil {
    public function ObjectUtil() {
    }

    public static function merge(...objects):Object {

        var result:Object = {};

        for (var i:uint = 0; i < objects.length; i++) {
            for (var k:String in objects[i]) {
                if (result[k]) {
                    if (isSimple(objects[i][k])) {
                        result[k] = objects[i][k];
                    } else {
                        result[k] = merge(result[k], objects[i][k]);
                    }
                } else {
                    result[k] = objects[i][k];
                }
            }
        }

        return result;
    }

    public static function isSimple(o:*):Boolean {
        return o is String || o is int || o is uint || o is Date || o is Array || o is Boolean
    }

    public static function mergeArrays(...args):Array {
        var retArr:Array = new Array();
        for each (var arg:* in args) {
            if (arg is Array) {
                for each (var value:* in arg) {
                    if (retArr.indexOf(value) == -1)
                        retArr.push(value);
                }
            }
        }
        return retArr;
    }

    public static function same(o1:*, o2:*):Boolean {
        return JSON.stringify(o1) === JSON.stringify(o2)
    }
}
}
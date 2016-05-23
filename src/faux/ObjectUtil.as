package faux
{
	public class ObjectUtil
	{
		public function ObjectUtil()
		{
		}
		
		public static function merge(...objects):Object {
			
			var result:Object = {};
			
			for(var i:uint = 0; i<objects.length; i++) {
				for(var k:String in objects[i]) {
					if(result[k]) {
						if(isSimple(objects[i][k])) {
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
	}
}
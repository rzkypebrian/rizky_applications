class ArrayUtil{
  
  static bool checkIndexArray({List list, int index}){
    return list.asMap().containsKey(index) ? true : false;
  }
}
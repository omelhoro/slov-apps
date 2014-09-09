import 'package:polymer/polymer.dart';
import 'dart:math' show Random;

@CustomTag("pic-item")
class PicItem extends PolymerElement with ChangeNotifier {
  @reflectable @published Map<String,dynamic> get picMap => __$picMap; Map<String,dynamic> __$picMap; @reflectable set picMap(Map<String,dynamic> value) { __$picMap = notifyPropertyChange(#picMap, __$picMap, value); }
  @reflectable @published bool get isPic => __$isPic; bool __$isPic; @reflectable set isPic(bool value) { __$isPic = notifyPropertyChange(#isPic, __$isPic, value); }
  @reflectable @observable bool get isVisible => __$isVisible; bool __$isVisible=false; @reflectable set isVisible(bool value) { __$isVisible = notifyPropertyChange(#isVisible, __$isVisible, value); }
  @reflectable @published String get picClass => __$picClass; String __$picClass= ''; @reflectable set picClass(String value) { __$picClass = notifyPropertyChange(#picClass, __$picClass, value); }
  @reflectable @observable String get picPath => __$picPath; String __$picPath; @reflectable set picPath(String value) { __$picPath = notifyPropertyChange(#picPath, __$picPath, value); }
  set gotRight(bool b){
    if (b){
      picClass='right';      
      shadowRoot.querySelectorAll("a").classes.add("right");
    }
    else
      print("False");
  }
  PicItem.created():super.created(){
  }
  picMapChanged(var v){
    String p=picMap['downloaded'] ;
    if (p.contains(",")){
      List<String> parts=p.split(",");
      int randIx=new Random().nextInt(parts.length);
      picMap['downloaded']=p.split(",")[randIx];
      print(picPath);
      print(parts);
    }
    picPath="./static/data/memory/pics/${picMap['downloaded']}.jpg";
      
  }



}
import 'package:polymer/polymer.dart';
import 'dart:math' show Random;

@CustomTag("pic-item")
class PicItem extends PolymerElement{
  @published Map<String,dynamic> picMap;
  @published bool isPic;
  @observable bool isVisible=false;
  @published String picClass= '';
  @observable String picPath;
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
    picPath="/static/data/memory/pics/${picMap['downloaded']}.jpg";
      
  }



}
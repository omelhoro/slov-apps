import 'package:polymer/polymer.dart';
//import 'dart:html';

@CustomTag("pic-item")
class PicItem extends PolymerElement{
  @published String picSrc,picText;
  @published bool isPic;
  @observable bool isVisible=false;

  PicItem.created():super.created(){
  }



}
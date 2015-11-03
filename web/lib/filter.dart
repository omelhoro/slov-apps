library filter_tmp;
import 'package:polymer/polymer.dart';
import '../globals.dart';
import 'dart:html';

@CustomTag("filter-tmp")
class Filter extends PolymerElement {
  static String locale="en";
  Map<String,Map<String,dynamic>> lesCats=getLang(locale, LESLABELS) ;
  Map<String,Map<String,dynamic>> posMap=getLang(locale, POSLABELS) ;
  Map<String,Map<String,dynamic>> genMap=getLang(locale, GENMAP) ;
  Map<String,Map<String,dynamic>> caseMap=getLang(locale, CASUS) ;
  Map<String,Map<String,dynamic>> levelMap=getLang(locale, HARDNESS) ;
  @published Map<String,Map<String,String>> filters;//={"a":{"b":"c"},"d":{"e":"h"}};
  Filter.created(): super.created(){
    //posMap["mix"]="Konjuktionen, Interjektionen, Partikel...";
    filters={"a":{"b":"c"},"d":{"e":"h"}};
  }
  filter(Event e){
    if (e.path.first is InputElement)
         filterDelegate();
  }
  filterDelegate(){
    
  }
}
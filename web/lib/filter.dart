library filter_tmp;
import 'package:polymer/polymer.dart';
import '../globals.dart';
@CustomTag("filter-tmp")
abstract class Filter extends PolymerElement {
  Map<String,String> lesCats=getLang("en", LESLABELS) ;
  Map<String,dynamic> posMap=getLang("en", POSLABELS) ;
  Map<String,String> genMap=getLang("en", GENMAP) ;
  Map<String,String> caseMap=getLang("en", CASUS) ;
  Map<String,String> levelMap=getLang("en", HARDNESS) ;
  @published Map<String,Map<String,String>> filters;//={"a":{"b":"c"},"d":{"e":"h"}};
  Filter.created(): super.created(){
    //posMap["mix"]="Konjuktionen, Interjektionen, Partikel...";
    filters={"a":{"b":"c"},"d":{"e":"h"}};
  }
}
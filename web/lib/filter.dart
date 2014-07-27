library filter_tmp;
import 'package:polymer/polymer.dart';

@CustomTag("filter-tmp")
abstract class Filter extends PolymerElement {
  @published Map<String,Map<String,String>> filters;//={"a":{"b":"c"},"d":{"e":"h"}};
  Filter.created(): super.created(){
    filters={"a":{"b":"c"},"d":{"e":"h"}};
  }
}
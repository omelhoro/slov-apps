import 'package:polymer/polymer.dart';
import '../lib/filter.dart';

@CustomTag("one-app")
class OnePanel extends Filter {
  String dummy="Bloedmann";
  OnePanel.created() : super.created(){
    filters={"a":{"b":"c"},"d":{"e":"h"}};
  }

  next(){
  }

}

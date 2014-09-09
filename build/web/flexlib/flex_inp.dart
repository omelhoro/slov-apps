import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('flex-inp')
class ParItem extends PolymerElement with ChangeNotifier  {
  @reflectable @published String get stem => __$stem; String __$stem; @reflectable set stem(String value) { __$stem = notifyPropertyChange(#stem, __$stem, value); } @reflectable @published String get flx => __$flx; String __$flx; @reflectable set flx(String value) { __$flx = notifyPropertyChange(#flx, __$flx, value); }
  @reflectable @published bool get hid => __$hid; bool __$hid; @reflectable set hid(bool value) { __$hid = notifyPropertyChange(#hid, __$hid, value); }

  ParItem.created() : super.created() {
  }

  void control() {
    InputElement e = shadowRoot.querySelector(".flex");
    try {
      String corFlex = e.dataset["sol"];
      String userFlex = e.value.trim();
      if (corFlex == userFlex) e
          ..classes.add("right")
          ..classes.remove("false"); else e
          ..classes.add("false")
          ..classes.remove("right");
    } on NoSuchMethodError catch (e) {
    }
    ;
  }

}

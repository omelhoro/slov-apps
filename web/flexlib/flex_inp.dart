import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('flex-inp')
class ParItem extends PolymerElement {
  @published String stem, flx;
  @published bool hid;

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

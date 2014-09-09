import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag("word-voc")
class Task extends PolymerElement {
  @published bool isSingleView;
  @published List<String> alternatives;
  @published Map<String, dynamic> wordMap;

  Task.created() : super.created();

  checkMulti(Event evt) {
    TableCellElement t = evt.target;
    t.dataset["sol"] == "true" ? t.classes.add("success") : t.classes.add("danger");
  }

  checkSingle(Event evt) {
    InputElement t = evt.target;
    if (t.dataset["sol"] == t.value) {
      t.parent.classes
          ..remove("has-error")
          ..add("has-success");
    } else {
      t.parent.classes
          ..remove("has-success")
          ..add("has-error");
    }
  }


  reset(List<String> l) {
    InputElement el = shadowRoot.querySelector(".singleinput");
    el.value = "";
    el.classes
        ..remove("right")
        ..remove("false"); //has a dummy argument for updating when alternatives got updated
  }
  switchView() {
    isSingleView = !isSingleView;
  }
  checkall() {
  }

}

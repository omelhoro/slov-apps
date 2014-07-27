import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag("word-voc")
class Task extends PolymerElement {
  @observable bool isSingleView = true;
  @published List<String> alternatives;
  @published Map<String, dynamic> wordMap;

  Task.created() : super.created();

  checkSingle() {
    InputElement inp = shadowRoot.querySelector(".singleinput");
    assert(inp is InputElement);
    if (inp.dataset["sol"] == inp.value) inp.classes
        ..add("right")
        ..remove("false"); else inp.classes
        ..add("false")
        ..remove("right");
  }

  checkMulti() {
    List<InputElement> inp = shadowRoot.querySelectorAll(".multiinput");
    List<InputElement> checked = inp.where((e) => e.checked).toList();
    if (checked.isEmpty) window.alert("Nothing selected"); else checked[0].dataset["sol"] == "true"
        ? checked[0].classes.add("right") : checked[0].classes.add("false");
  }

  check(Event e) {
    isSingleView ? checkSingle() : checkMulti();
  }
  reset(List<String> l) {
    InputElement el = shadowRoot.querySelector(".singleinput");
    el.value = "";
    el.classes
        ..remove("right")
        ..remove("false"); //has a dummy argument for updating when alternatives got updated
  }
  switchView() {
    shadowRoot.querySelector(".singleinp").hidden = isSingleView;
    shadowRoot.querySelector(".multiinp").hidden = !isSingleView;
    isSingleView = !isSingleView;
  }
  checkall() {
  }

}

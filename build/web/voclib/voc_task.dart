import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag("word-voc")
class Task extends PolymerElement with ChangeNotifier  {
  @reflectable @published bool get isSingleView => __$isSingleView; bool __$isSingleView; @reflectable set isSingleView(bool value) { __$isSingleView = notifyPropertyChange(#isSingleView, __$isSingleView, value); }
  @reflectable @published List<String> get alternatives => __$alternatives; List<String> __$alternatives; @reflectable set alternatives(List<String> value) { __$alternatives = notifyPropertyChange(#alternatives, __$alternatives, value); }
  @reflectable @published Map<String, dynamic> get wordMap => __$wordMap; Map<String, dynamic> __$wordMap; @reflectable set wordMap(Map<String, dynamic> value) { __$wordMap = notifyPropertyChange(#wordMap, __$wordMap, value); }

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

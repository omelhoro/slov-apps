library wordform;
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:bootjack/bootjack.dart';
import './wordf_app.dart';
@CustomTag("word-form")
class WordForm extends PolymerElement with ChangeNotifier  {
  static List<WordForm> allForms = [];
  @reflectable @published bool get isSelected0 => __$isSelected0; bool __$isSelected0 = false; @reflectable set isSelected0(bool value) { __$isSelected0 = notifyPropertyChange(#isSelected0, __$isSelected0, value); }
  @published get isSelected => isSelected0;
  @published set isSelected(bool c) {
    assert(c is bool);
    assert(grammarAtrs != null);
    isSelected0 = c;
    String pos = grammarAtrs['Pos'].toLowerCase();
    String caseWord = pos == "noun" ? grammarAtrs['Case'].substring(0, 3).toLowerCase() : "";
    c ? this.classes.addAll([pos, caseWord]) : this.classes.removeAll([pos, caseWord]);
  }

  String atrsTab;
  @reflectable @published String get gramTagSl => __$gramTagSl; String __$gramTagSl; @reflectable set gramTagSl(String value) { __$gramTagSl = notifyPropertyChange(#gramTagSl, __$gramTagSl, value); } @reflectable @published String get gramTagEn => __$gramTagEn; String __$gramTagEn; @reflectable set gramTagEn(String value) { __$gramTagEn = notifyPropertyChange(#gramTagEn, __$gramTagEn, value); } @reflectable @published String get lemma => __$lemma; String __$lemma; @reflectable set lemma(String value) { __$lemma = notifyPropertyChange(#lemma, __$lemma, value); } @reflectable @published String get tonal => __$tonal; String __$tonal; @reflectable set tonal(String value) { __$tonal = notifyPropertyChange(#tonal, __$tonal, value); }
  @reflectable @published Map<String, String> get grammarAtrs => __$grammarAtrs; Map<String, String> __$grammarAtrs; @reflectable set grammarAtrs(Map<String, String> value) { __$grammarAtrs = notifyPropertyChange(#grammarAtrs, __$grammarAtrs, value); }

  WordForm.created() : super.created() {
    //print(WordForm.allForms.length);
    allForms.add(this);
  }

  attached() {
    grammarAtrs = WordfApp.grammarAtrs.putIfAbsent(gramTagEn, () => {
      "Pos": "SENT"
    });
  }

  domReady() {
    /*
    Popover.wire(this, () => new Popover(this,placement: (e) => "bottom", trigger: "click", title:
        (el) => "Grammar", html: true, content: (el) => this.atrsTab == null ? tableFromAtrs(grammarAtrs) :
        this.atrsTab));
        */
    SpanElement elm = shadowRoot.querySelector("span#word");
    Tooltip.wire(elm, () => new Tooltip(elm, placement: (e) => "top", trigger: "hover", title: (el) => lemma, html: true));
  }

  String tableFromAtrs(Map atrs) {
    HtmlElement atrsTab = shadowRoot.querySelector(".tabled");
    String rows = "";
    grammarAtrs.forEach((k, v) => rows += "<tr><td>$k</td><td>$v</td></tr>");
    String tab = "<table class='table'>$rows</table>";
    this.atrsTab = this.atrsTab == null ? tab : "";
    return tab;
  }
}

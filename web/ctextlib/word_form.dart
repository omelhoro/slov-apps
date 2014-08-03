library wordform;
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'package:bootjack/bootjack.dart';
import './wordf_app.dart';
@CustomTag("word-form")
class WordForm extends PolymerElement {
  static List<WordForm> allForms = [];
  @published bool isSelected0 = false;
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
  @published String gramTagSl, gramTagEn, lemma, tonal;
  @published Map<String, String> grammarAtrs;

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

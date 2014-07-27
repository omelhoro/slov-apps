import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import '../lib/filter.dart';
import './word_form.dart';

@CustomTag("wordf-app")
class WordfApp extends Filter {
  Map<String,Map<String,String>> oriDb;
  Map<String,String> curTask;
  static Map<String, Map<String, String>> grammarAtrs;
  List<String> poss = ["Verb", "Adjective", "Noun", "Pronoun", "Preposition"];
  @published List<String> less;
  @published List<String> lessTitle;
  DivElement textField;
  WordfApp.created() : super.created() {
    setTextField();
    //reqDb();
  }

  setTextField()=>textField=shadowRoot.querySelector("#text");

  reqDb() => HttpRequest.getString("/static/data/tagged_text.json").then(reqDb1);

  reqDb1(String texts) => HttpRequest.getString("/static/data/engtags_dict.json").then(setDbPre(
      texts));

  setDbPre(String textval) {
    setDb(String value) {
      assert(value != "");
      oriDb = JSON.decode(textval);
      less = oriDb.keys.toList();
      lessTitle=less.map((e)=>oriDb[e]["title"]).toList();
      grammarAtrs = JSON.decode(value);
      setText(less.last);
      print("Text ready");
    }
    return setDb;
  }
  domReady() {
    print("Use dom1");
    reqDb();
  }
  WordForm _createWordForm(SpanElement sp) {
    WordForm wf = new Element.tag("word-form");
    wf
        ..text = sp.text
        ..gramTagEn = sp.dataset["gramtagen"]
        ..lemma = sp.dataset["lemma"]
        ..gramTagSl = sp.dataset["gramtagsl"]
        ..grammarAtrs = WordfApp.grammarAtrs.putIfAbsent(sp.dataset["gramtagen"], () => {
          "Pos": "SENT"
        });
    return wf;
  }
  detached(){
    super.detached();
    WordForm.allForms = [];
  }

  void setText(String k) {
    final NodeValidatorBuilder parser = new NodeValidatorBuilder.common()..allowElement('word-form',
        attributes: ['gramTagSl', 'gramTagEn', 'lemma', 'tonal']);
    curTask = oriDb[k];
    Element task = new Element.html(curTask["body"], validator: parser);
    textField.children = [task];
  }
  changeText(Event e) {
    assert(e.target is RadioButtonInputElement);
    RadioButtonInputElement t = e.target;
    WordForm.allForms = [];
    setText(t.dataset["les"]);
    shadowRoot.querySelectorAll(".active").forEach((Element e) => e.classes.remove("active"));
  }

  filter(Event e) {
    Element et = e.target;
    if (et is LIElement) {
      et.classes.contains("active") ? et.classes.remove("active") : et.classes.add("active");
      Set<String> posFilters = shadowRoot.querySelectorAll(".posfilter.active").map((Element e) =>
          e.dataset["fltr"]).toSet();
      List<dynamic> fs = shadowRoots['wordf-app'].querySelectorAll("word-form");
      WordForm.allForms.forEach((WordForm e) {
        e.isSelected = posFilters.contains(e.grammarAtrs["Pos"]);
      });
    }
  }

}

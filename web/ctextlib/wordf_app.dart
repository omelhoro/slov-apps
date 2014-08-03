import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import '../lib/filter.dart';
import '../lib/filter-item.dart';
import './word_form.dart';

@CustomTag("wordf-app")
class WordfApp extends Filter {
  Map<String, Map<String, String>> oriDb;
  Map<String, String> curTask;
  static Map<String, Map<String, String>> grammarAtrs;
  Map<String, String> textMap = toObservable({});
  DivElement textField;
  WordfApp.created() : super.created() {
    setTextField();
  }

  setTextField() => textField = shadowRoot.querySelector("#text");

  reqDb() => HttpRequest.getString("/static/data/tagged_text.json").then(reqDb1);

  reqDb1(String texts) => HttpRequest.getString("/static/data/engtags_dict.json").then(setDbPre(texts));

  setDbPre(String textval) {
    setDb(String value) {
      assert(value != "");
      oriDb = JSON.decode(textval);
      for (String k in oriDb.keys) textMap[k] = oriDb[k]["title"];
      grammarAtrs = JSON.decode(value);
      setTextFirst(textMap.keys.last);
    }
    return setDb;
  }

  void setTextFirst(String s) {
    shadowRoot.querySelector("#texts").click();
  }

  domReady() {
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
  detached() {
    super.detached();
    WordForm.allForms = [];
  }

  void setText(String k) {
    WordForm.allForms = [];
    final NodeValidatorBuilder parser = new NodeValidatorBuilder.common()..allowElement('word-form', attributes: ['gramTagSl', 'gramTagEn', 'lemma', 'tonal']);
    curTask = oriDb[k];
    Element task = new Element.html(curTask["body"], validator: parser);
    textField.children.add(task);
    textField.children = [task];
  }
  changeText(Event e) {
    assert(e.target is RadioButtonInputElement);
    RadioButtonInputElement t = e.target;
    setText(t.dataset["les"]);
    shadowRoot.querySelectorAll(".active").forEach((Element e) => e.classes.remove("active"));
  }

  filter(Event e) {
    FilterItem textFilter = shadowRoot.querySelector("#texts");
    FilterItem posFilter = shadowRoot.querySelector("#pos-mark");
    assert(textFilter is FilterItem && posFilter is FilterItem);
    assert(textFilter.activeCats is Set && posFilter.activeValues is Set);
    if ((e.target as FilterItem).id == 'texts') setText(textFilter.activeCats.first);
    // else {
    WordForm.allForms.forEach((e) => e.isSelected = posFilter.activeValues.contains(e.grammarAtrs["Pos"]));
    //}
  }
}

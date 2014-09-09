import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:convert';
import '../lib/filter.dart';
import '../lib/filter-item.dart';
import '../lib/filter-panel.dart';
import './word_form.dart';

@CustomTag("wordf-app")
class WordfApp extends Filter {
  Map<String, Map<String, String>> oriDb;
  Map<String, String> curTask;
  static Map<String, Map<String, String>> grammarAtrs;
  String curText;
  Map<String, Map<String, dynamic>> textMap = toObservable({
    "meta": {
      "title": "Texts",
      "id": "text-filter",
      "type": "radio"
    },
    "cats": {}
  });
  DivElement textField;
  WordfApp.created() : super.created() {
    setTextField();
  }

  setTextField() => textField = shadowRoot.querySelector("#text");

  reqDb() => HttpRequest.getString("./static/data/tagged_text.json").then(reqDb1);

  reqDb1(String texts) => HttpRequest.getString("./static/data/engtags_dict.json").then(setDbPre(texts));

  setDbPre(String textval) {
    setDb(String value) {
      assert(value != "");
      oriDb = JSON.decode(textval);
      for (String k in oriDb.keys) textMap["cats"][k] = oriDb[k]["title"];
      grammarAtrs = JSON.decode(value);
      setTextFirst();
    }
    return setDb;
  }

  void setTextFirst() {
    filterDelegate();
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
    textField.children = [task];
  }
  changeText(Event e) {
    assert(e.target is RadioButtonInputElement);
    RadioButtonInputElement t = e.target;
    setText(t.dataset["les"]);
    shadowRoot.querySelectorAll(".active").forEach((Element e) => e.classes.remove("active"));
  }

  filterDelegate() {
    FilterPanel p = shadowRoot.querySelector('filter-panel');
    FilterItem textFilter = p.filters["text-filter"];
    FilterItem posFilter = p.filters["pos-filter"];
    var posActive = posFilter.activeValues;
    assert(textFilter is FilterItem && posFilter is FilterItem);
    assert(textFilter.activeCats is Set && posFilter.activeValues is Set);
    Set<String> activeText=textFilter.activeCats;
    String filterText = activeText.isNotEmpty ? activeText.last : textMap["cats"].keys.last;
    if (curText != filterText) {
      curText = filterText;
      setText(curText);
    }
    if (WordForm.allForms.isEmpty) {
      var timer = new Timer(const Duration(milliseconds: 500), () {
        print("NOW");
        WordForm.allForms.forEach((e) => e.isSelected = posActive.contains(e.grammarAtrs["Pos"]));
      });
    } else {
      WordForm.allForms.forEach((e) => e.isSelected = posActive.contains(e.grammarAtrs["Pos"]));
    }
  }
}

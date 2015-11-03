import 'package:polymer/polymer.dart';
import './wordf_app.dart';
import 'dart:html';
import './word_form.dart';
import '../lib/filter-item.dart';
import '../lib/filter-panel.dart';
import 'dart:async';

@CustomTag("marknoun-app")
class NounMarker extends WordfApp {
  List<WordForm> allNouns;
  List<LIElement> allCases;
  int curIx, curCaseIx = 0;
  @observable String curCaseClass;
  List<String> poss = [];
  @observable Map<String, List<dynamic>> stats = toObservable({
    "Unmarked": ["label-default", 0],
    "Correct": ["label-success", 0],
    "False": ["label-danger", 0]
  });
  var keyListener;
  Map<String, int> nounMovers = {"back": 65, "next": 68};
  Map<String, int> caseMovers = {"back": 87, "next": 83};

  NounMarker.created() : super.created() {}

  SelectElement caseSelector;

  setSelection(bool isSet, bool isNoun) {
    if (isNoun) isSet
        ? allNouns[curIx].classes.add("selectedcase")
        : allNouns[curIx].classes.remove("selectedcase");
    else {
      caseSelector = shadowRoots["marknoun-app"].querySelector("select");
      caseSelector.selectedIndex = curCaseIx;
      caseSelector.click();
    }
    //isSet ?  allCases[curCaseIx].classes.add("selectedcase") : allCases[curCaseIx].classes.remove("selectedcase");
  }

  domReady() {
    super.domReady();
    keyListener = window.onKeyUp.listen(moveSelection);
    (shadowRoots['wordf-app'].querySelector("filter-panel") as FilterPanel)
        .filters["pos-filter"].remove();
    //shadowRoots["wordf-app"].querySelector("#pos-mark").remove();
    //caseSelector = shadowRoots["marknoun-app"].querySelector("select")..click();
  }

  setTextField() => textField = shadowRoots['wordf-app'].querySelector("#text");

  detached() {
    super.detached();
    keyListener.cancel();
  }

  updateCase(Event evt) {
    SelectElement s = evt.target;
    curCaseClass = s.value;
    curCaseIx = s.selectedIndex;
  }

  markCase() {
    WordForm curTask = allNouns[curIx];
    //String caseClass=curCaseClass;//casus[curCaseIx].substring(0,3).toLowerCase();
    String userTagged = curTask.dataset.putIfAbsent("usercase", () => "");
    if (curCaseClass != userTagged) {
      curTask.classes
        ..remove(userTagged)
        ..addAll(["noun", curCaseClass]);
      curTask.dataset["usercase"] = curCaseClass;
      curTask.dataset["sol"] =
          curTask.grammarAtrs["Case"].substring(0, 3).toLowerCase();
    }
  }

  checkall() {
    List<WordForm> marked = WordForm.allForms
        .where((e) => e.dataset.containsKey("usercase"))
        .toList();
    marked.forEach((e) {
      e.dataset["usercase"] == e.dataset["sol"]
          ? e.classes.add("rightmarked")
          : e.classes.add("falsemarked");
    });
    stats["Unmarked"][1] = allNouns.length - marked.length;
    int correctTags =
        marked.where((WordForm e) => e.classes.contains("rightmarked")).length;
    stats["Correct"][1] = correctTags;
    stats["False"][1] = marked.length - correctTags;
  }

  setText(String k) {
    super.setText(k);
    curIx = 0;
    for (k in stats.keys) stats[k][1] = 0;
    //the timer is workaround for the difference in class instantiation of polymer elements: fx app -> item , chrome: app (partly) ->,items-> rest app
    var timer = new Timer(const Duration(seconds: 1), () {
      allNouns = WordForm.allForms
          .where((WordForm e) => e.grammarAtrs["Pos"] == "Noun")
          .toList();
      allCases = shadowRoots["marknoun-app"].querySelectorAll(".noun");
      assert(allNouns.length != 0 && allCases.length != 0);
      setSelection(true, true);
      setSelection(true, false);
    });
  }

  filterDelegate() {
    FilterItem textFilter = (shadowRoots['wordf-app']
        .querySelector("filter-panel") as FilterPanel).filters["text-filter"];
    Set<String> activeText = textFilter.activeCats;
    String filterText =
        activeText.isNotEmpty ? activeText.last : textMap["cats"].keys.last;
    setText(filterText);
  }

  void moveCase(bool next) {
    int curPoolLength = caseMap["cats"].length;
    setSelection(false, false);
    curCaseIx += next ? 1 : -1;
    curCaseIx = curCaseIx >= curPoolLength
        ? 0
        : (curCaseIx < 0 ? curPoolLength - 1 : curCaseIx);
    setSelection(true, false);
  }

  void moveNoun(bool next) {
    int curPoolLength = allNouns.length;
    setSelection(false, true);
    curIx += next ? 1 : -1;
    curIx =
        curIx >= curPoolLength ? 0 : (curIx < 0 ? curPoolLength - 1 : curIx);
    setSelection(true, true);
  }

  void moveSelection(KeyboardEvent event) {
    int char = event.keyCode;
    if (nounMovers.values.contains(char)) {
      moveNoun(char == nounMovers["next"]);
    } else if (caseMovers.values.contains(char)) {
      moveCase(char == caseMovers["next"]);
    }
    if (char == 32) markCase();
  }
}

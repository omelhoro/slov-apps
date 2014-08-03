import 'package:polymer/polymer.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:math' show Random;
import 'dart:html';
import '../globals.dart';
import '../lib/filter.dart';
//import '../lib/inpool_label.dart';
import '../lib/filter-item.dart';

@CustomTag('desc-app')
class DescApp extends Filter {
  List<Map<String, dynamic>> DESCS;
  List<Map<String, dynamic>> subDESCS;
  Map<String, List<List<String>>> FLEXS;
  @observable List<List<String>> firstTdOrder;
  bool isWordCentric;
  double probabCase = 0.25;
  @observable Map<String, dynamic> curTask;
  @observable int nInPool = 0;
  @observable List<List<String>> curParadigm;

  DescApp.created() : super.created() {
    reqDb();
  }
  Future reqDb({String src: "/static/data/descApp.json"}) => HttpRequest.getString(src).then(setDb);

  setLevel(Event evt) {
    print((evt.target as SelectElement).value);
    probabCase = double.parse((evt.target as SelectElement).value);

  }

  setDb(String value) {
    var DB = JSON.decode(value);
    FLEXS = DB["flexions"];
    DESCS = DB["words"];
    DESCS.shuffle();
    subDESCS = DESCS;
    shadowRoot.querySelector(".wordcentric").click();
  }


  changeMod(Event evt) {
    assert(evt.target is ButtonElement);
    ButtonElement b = evt.target;
    isWordCentric = b.classes.contains("wordcentric");
    //isWordCentric? b.classes.add("active");
    next();
  }

  _built_par(Map wordMap) {
    List<List<String>> flx = FLEXS[wordMap["classification"]];
    String nomStem = wordMap["nominativeStem"];
    List<int> numerus = wordMap["numerus"];
    bool unreg = wordMap["hasStemAlt"];
    List<List<String>> fullPar = wordMap["stem"];
    var casVals = CASUS.values.toList();
    Random rand = new Random();
    List<dynamic> stemWithFlexions = [];
    List<List<int>> possibleInputs = [];
    for (var i = 0; i < flx[0].length; i++) {//[1,2,3] [4,5,6] [7,8,9] ->
      var sublist = [];
      stemWithFlexions.add(sublist);
      for (var j = 0; j < flx.length; j++) if (numerus.contains(j)) {
        var itm = [!unreg ? nomStem : fullPar[j][i], flx[j][i], rand.nextDouble() < probabCase ? true : false];
        sublist.add(itm);
        possibleInputs.add([i, j]);
      } else {
        var itm = ["", flx[j][i], false];
        sublist.add(itm);
      }
    }
    if (isWordCentric) return stemWithFlexions; else {
      int rowIx = rand.nextInt(stemWithFlexions.length);
      List<List<dynamic>> r = stemWithFlexions[rowIx];
      List<String> caseKeys = caseMap.keys.toList();
      return [[caseKeys[rowIx], nomStem], r];
    }
  }
  filter(Event e) {
    assert(e.target is FilterItem);
    FilterItem genF = shadowRoot.querySelector("#genus-filter");
    Set<String> activeGens = genF.activeCats;
    print(activeGens);
    subDESCS = activeGens.length > 0 ? (genF.isSubset ? subDESCS : DESCS).where((e) => activeGens.contains(e["genus"])).toList() : [];
    subDESCS.shuffle();
    nInPool = subDESCS.length;
  }

  void next() {
    if (isWordCentric) {
      try {
        curTask = subDESCS.removeLast();
        nInPool = subDESCS.length;
      } on NoSuchMethodError catch (e) {
        curTask = DESCS[0];
        nInPool = DESCS.length;
      } finally {
        firstTdOrder = caseMap.keys.map((e) => [e, caseMap[e]]).toList();
        curParadigm = _built_par(curTask);
      }
    } else {
      var taskList = subDESCS.take(10).map((e) => _built_par(e));
      subDESCS.removeRange(0, 10);
      firstTdOrder = taskList.map((e) => [e[0][0], e[0][1]]).toList();
      curParadigm = taskList.map((e) => e[1]).toList();
      nInPool = subDESCS.length;
    }
  }
}

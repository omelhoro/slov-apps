import 'package:polymer/polymer.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:html';
import '../globals.dart';
import '../lib/filter.dart';

@CustomTag('desc-app')
class DescApp extends Filter {
  List<Map<String, dynamic>> DESCS;
  List<Map<String, dynamic>> subDESCS;
  Map<String, List<List<String>>> FLEXS;
  List<String> casusOrder = CASUS.values.toList();
  int _inputs = 4;
  List<CheckboxInputElement> genFilters;
  @observable Map<String,dynamic> curTask;

  @observable int nInPool1 = 0;

  set nInPool(int n) {
    (shadowRoots["filter-tmp"].querySelector(".nextpar") as ButtonElement).disabled = n == 0 ? true
        : false;
    nInPool1 = n;
    return n;
  }

  @observable List<List<String>> curParadigm;
  @observable set ninputs(v) {
    v = v.toString();
    try {
      _inputs = int.parse(v);
    } catch (e) {
      _inputs = 4;
    }
  }
  @observable int get ninputs => _inputs;

  DescApp.created() : super.created() {
    filters={"genfilter":GENMAP};
    reqDb();
  }

  Future reqDb({String src: "/static/data/descApp.json"}) => HttpRequest.getString(src).then(setDb);

  setDb(String value) {
    var DB = JSON.decode(value);
    FLEXS = DB["flexions"];
    DESCS = DB["words"];
    subDESCS = DESCS;
    next();//call first paradigm
  }
  _setHideRandom(List<dynamic> lst, List<List<int>> poss) {
    poss.shuffle();
    poss.take(ninputs).map((e) => lst[e[0]][e[1]][2] = true).toList(
        );//set hidden (3.element) to true
    return lst;
  }

  _built_par(Map wordMap) {
    List<List<String>> flx = FLEXS[wordMap["classification"]];
    String nomStem = wordMap["nominativeStem"];
    List<int> numerus = wordMap["numerus"];
    bool unreg = wordMap["hasStemAlt"];
    List<List<String>> fullPar = wordMap["stem"];
    var casVals = CASUS.values.toList();
    List<dynamic> stemWithFlexions = [];
    List<List<int>> possibleInputs = [];
    for (var i = 0; i < flx.length; i++) {
      var sublist = [];
      stemWithFlexions.add(sublist);
      for (var j = 0; j < flx[0].length; j++) if (numerus.contains(i)) {
        var itm = [!unreg ? nomStem : fullPar[i][j], flx[i][j], false];
        sublist.add(itm);
        possibleInputs.add([i, j]);
      } else {
        var itm = ["", flx[i][j], false];
        sublist.add(itm);
      }
    }
    var transposed = transpose(_setHideRandom(stemWithFlexions, possibleInputs));
    return transposed;
  }
  filter(Event e) {
    genFilters = shadowRoots["filter-tmp"].querySelectorAll(".genfilter");
    assert(e.target is CheckboxInputElement);
    List<String> activeGens = genFilters.where((e) => e.checked == true).map((e) => e.dataset["fltr"]).toList();
    subDESCS = activeGens.length > 0 ? ((e.target as CheckboxInputElement).checked ? DESCS :
        subDESCS).where((e) => activeGens.contains(e["genus"])).toList() : [];
    subDESCS.shuffle();
    nInPool = subDESCS.length;
  }

  void next() {
    try {
      curTask = subDESCS.removeLast();
      nInPool = subDESCS.length;
    } on NoSuchMethodError catch (e) {
      curTask = DESCS[0];
      nInPool = DESCS.length;
    } finally {
      curParadigm = _built_par(curTask);
    }
  }
}

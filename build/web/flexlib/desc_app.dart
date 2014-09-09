import 'package:polymer/polymer.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:math' show Random;
import 'dart:html';
import '../globals.dart';
import '../lib/filter.dart';
//import '../lib/inpool_label.dart';
import '../lib/filter-item.dart';
import '../lib/filter-panel.dart';
import './desct_table.dart';

@CustomTag('desc-app')
class DescApp extends Filter with ChangeNotifier  {
  List<Map<String, dynamic>> DESCS;
  List<Map<String, dynamic>> subDESCS;
  Map<String, List<List<String>>> FLEXS;
  @reflectable @observable List<String> get firstTdOrder => __$firstTdOrder; List<String> __$firstTdOrder; @reflectable set firstTdOrder(List<String> value) { __$firstTdOrder = notifyPropertyChange(#firstTdOrder, __$firstTdOrder, value); }
  bool isWordCentric;
  double probabCase = 0.25;
  @reflectable @observable Map<String, dynamic> get curTask => __$curTask; Map<String, dynamic> __$curTask; @reflectable set curTask(Map<String, dynamic> value) { __$curTask = notifyPropertyChange(#curTask, __$curTask, value); }
  @reflectable @observable int get nInPool => __$nInPool; int __$nInPool = 0; @reflectable set nInPool(int value) { __$nInPool = notifyPropertyChange(#nInPool, __$nInPool, value); }
  @reflectable @observable List<List<String>> get curParadigm => __$curParadigm; List<List<String>> __$curParadigm; @reflectable set curParadigm(List<List<String>> value) { __$curParadigm = notifyPropertyChange(#curParadigm, __$curParadigm, value); }

  DescApp.created() : super.created() {
    reqDb();
  }
  Future reqDb({String src: "./static/data/descApp.json"}) => HttpRequest.getString(src).then(setDb);

  setLevel(Event evt) {
    probabCase = double.parse((evt.target.value as String));
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
    print(probabCase);
    for (var i = 0; i < flx[0].length; i++) {//[1,2,3] [4,5,6] [7,8,9] -> zipped
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
      List<String> caseKeys = caseMap["cats"].keys.toList();
      return [[caseKeys[rowIx], nomStem], r];
    }
  }
  filterDelegate() {
    //assert(e.target is FilterItem);
    FilterPanel p= shadowRoot.querySelector('filter-panel');
    FilterItem genFilter=p.filters["gen-filter"]; 
    Set<String> activeGens = genFilter.activeCats;

    subDESCS = activeGens.length > 0 ? (genFilter.isSubset ? subDESCS : DESCS).where((e) => activeGens.contains(e["genus"])).toList() : [];
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
        firstTdOrder = caseMap["cats"].keys.map((e) => [e, caseMap["cats"][e]]).toList();
        curParadigm = _built_par(curTask);
      }
    } else {
      var taskList = subDESCS.take(10).map((e) => _built_par(e));
      subDESCS.removeRange(0, 10);
      firstTdOrder = taskList.map((e) => [e[0][0], e[0][1]]).toList();
      curParadigm = taskList.map((e) => e[1]).toList();
      nInPool = subDESCS.length;
    }
    DescTable tab=(new Element.tag("desct-table") as DescTable)
      ..curParadigm=curParadigm
      ..wordData=curTask
      ..firstTdOrder=firstTdOrder;
    shadowRoot.querySelector(".desc-table").children.add(tab);
    shadowRoot.querySelector(".desc-table").children=[tab];
    shadowRoot.querySelector(".desc-table").children.add(tab);
  }
}

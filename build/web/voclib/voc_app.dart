import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:math' show Random;
import '../globals.dart';
import '../lib/filter.dart';
import './voc_task.dart';
import '../lib/inpool_label.dart';
import '../lib/filter-item.dart';
import '../lib/filter-panel.dart';
//import 'dart:async';


@CustomTag("voc-app")
class VocApp extends Filter with ChangeNotifier  {
  List<Map<String, dynamic>> curDb, oriDb;
  Task curTask;
  List<String> alternatives;
  @reflectable @observable int get nInPool => __$nInPool; int __$nInPool = 0; @reflectable set nInPool(int value) { __$nInPool = notifyPropertyChange(#nInPool, __$nInPool, value); }

  VocApp.created() : super.created() {
    reqDb();
  }

  reqDb() => HttpRequest.getString("./static/data/vocApp.json").then(setDb);

  setDb(String value) {
    assert(value != "");
    oriDb = JSON.decode(value);
    curDb = oriDb;
    shadowRoot.querySelector("inpool-label").click();
  }

  void next(Event evt) {
    if ((evt.target is InpoolLabel || (evt.path.first as Element).classes.contains("next")) && curDb.length > 0) {
      Map<String,dynamic> wordMap= curDb.removeLast();
      alternatives = [];
      for (var i = 0; i < 3; i++) {
        int ix = new Random().nextInt(oriDb.length);
        alternatives.add(oriDb[ix]["nativeWord"]);
      }
      alternatives
          ..add(wordMap["nativeWord"])
          ..shuffle();
      Task lastTask=curTask;
      curTask= (new Element.tag("word-voc") as Task)
          ..isSingleView= lastTask!=null ? lastTask.isSingleView : true
          ..wordMap = wordMap
          ..alternatives = alternatives
          ..onClick.listen(next);
      shadowRoot.querySelector(".task").children = [curTask];
      nInPool = curDb.length;
    }
  }

  filterDelegate() {
    print("Am Filtering");
    FilterPanel p= shadowRoot.querySelector('filter-panel');
    FilterItem posFilter=p.filters["pos-filter"]; 
    FilterItem lesFilter= p.filters["les-filter"];
    List<int> validLessons = [];
    var posActive = posFilter.activeCats;
    var lesActive = lesFilter.activeCats;
    for (String lesInp in lesActive) validLessons.addAll(LESSECMAP[lesInp]);
    curDb = (posFilter.isSubset && lesFilter.isSubset ? curDb : oriDb)
        .where((elm) => posActive.contains(elm['pos'] as String) && validLessons.contains(int.parse(elm['les'] as String))).toList();
    curDb.shuffle();
    nInPool = curDb.length;
  }

}

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import '../globals.dart';
import '../lib/filter.dart';

@CustomTag("excs-app")
class ExcsApp extends Filter {
  List<CheckboxInputElement> lesFilter, posFilter;
  List<Map<String, dynamic>> curDb, oriDb;
  Map<String,String> lesCats=LESLABELS;
  Map<String,String> posMap=POSLABELS;
  @observable Map<String,dynamic> curTask;

  @observable int nInPool1 = 0;
  set nInPool(int i) {
    nInPool1 = i;
    (shadowRoots["filter-tmp"].querySelector(".nextpar") as ButtonElement).disabled = nInPool1 == 0;
  }

  ExcsApp.created() : super.created() {
    filters={"lesfilter":LESLABELS,'posfilter':POSLABELS};
    reqDb();
  }
  reqDb() => HttpRequest.getString("/static/data/excsApp.json").then(setDb);

  setDb(String value) {
    assert(value!="");
    oriDb = JSON.decode(value);
    curDb = oriDb;
    next();
  }

  next(){
    assert(curDb.length > 0);
    curTask=curDb.removeLast();
    nInPool=curDb.length;
  }

  filter(Event e) {
    lesFilter = shadowRoots["filter-tmp"].querySelectorAll('.lesfilter');
    posFilter = shadowRoots["filter-tmp"].querySelectorAll('.posfilter');
    assert(lesFilter.length>0 && posFilter.length >0);
    assert(e.target is CheckboxInputElement);
    CheckboxInputElement t = e.target;
    List<int> validLessons = [];
    for (var lesInp in lesFilter) if (lesInp.checked) validLessons.addAll(LESSECMAP[lesInp.dataset["fltr"]]);
    var validPos = posFilter.where((e) => e.checked).map((e) => e.dataset['fltr']).toList();
    curDb = (t.checked ? oriDb : curDb).where((elm) => validPos.contains(elm['pos'] as String) &&
        validLessons.contains(int.parse(elm['les'] as String))).toList();
    nInPool=curDb.length;
  }
}

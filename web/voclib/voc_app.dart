import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:math' show Random;
import '../globals.dart';
import '../lib/filter.dart';

@CustomTag("voc-app")
class VocApp extends Filter{
  List<Map<String, dynamic>> curDb, oriDb;
  @observable Map<String,dynamic> curTask;
  List<CheckboxInputElement> lesFilter, posFilter;
  Map<String,String> lesCats=LESLABELS;
  Map<String,String> posMap=POSLABELS;
  @observable List<String> alternatives;
  @observable int nInPool1 = 0;
  set nInPool(int i) {
    nInPool1 = i;
    (shadowRoots["filter-tmp"].querySelector(".nextpar") as ButtonElement).disabled = nInPool1 == 0;
  }

  VocApp.created(): super.created(){
    filters={"lesfilter":LESLABELS,"posfilter":POSLABELS};
    posMap["mix"]="Konjuktionen, Interjektionen, Partikel...";
    reqDb();
  }

  reqDb() => HttpRequest.getString("/static/data/vocApp.json").then(setDb);

  setDb(String value) {
    assert(value!="");
    oriDb = JSON.decode(value);
    curDb = oriDb;
    next();
  }

  void next() {
    curTask= curDb.removeLast();
    alternatives=[];
    for (var i=0;i < 3 ;i++){
      int ix=new Random().nextInt(oriDb.length);
      alternatives.add(oriDb[ix]["nativeWord"]);
    }
    alternatives.add(curTask["nativeWord"]);
    alternatives.shuffle();
    assert(alternatives.length >0);
    nInPool=curDb.length;

  }

  filter(Event e) {
    assert(e.target is CheckboxInputElement);
    print(e);
    lesFilter = shadowRoots["filter-tmp"].querySelectorAll('.lesfilter');
    posFilter = shadowRoots["filter-tmp"].querySelectorAll('.posfilter');
    CheckboxInputElement t = e.target;
    List<int> validLessons = [];
    for (var lesInp in lesFilter) if (lesInp.checked) validLessons.addAll(LESSECMAP[lesInp.dataset["fltr"]]);
    var validPos = posFilter.where((e) => e.checked).map((e) => e.dataset['fltr']).toList();
    curDb = (t.checked ? oriDb : curDb).where((elm) => validPos.contains(elm['pos'] as String) &&
        validLessons.contains(int.parse(elm['les'] as String))).toList();
    curDb.shuffle();
    nInPool=curDb.length;
  }

}
import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:math' show Random;
import '../globals.dart';
import '../lib/filter.dart';
import '../lib/filter-item.dart';

@CustomTag("voc-app")
class VocApp extends Filter{
  List<Map<String, dynamic>> curDb, oriDb;
  @observable Map<String,dynamic> curTask;
  @observable List<String> alternatives;
  @observable int nInPool = 0;

  VocApp.created(): super.created(){
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
    FilterItem lesFilter = shadowRoot.querySelector('#lessons-filter');
    FilterItem posFilter = shadowRoot.querySelector('#pos-filter');
    List<int> validLessons = [];
    for (String lesInp in lesFilter.activeCats){ print(lesInp);validLessons.addAll(LESSECMAP[lesInp]);};
    print(lesFilter.activeCats);
    curDb = ((e.target as FilterItem).isSubset ? curDb : oriDb).where((elm) => posFilter.activeCats.contains(elm['pos'] as String) &&
        validLessons.contains(int.parse(elm['les'] as String))).toList();
    curDb.shuffle();
    nInPool=curDb.length;
  }

}
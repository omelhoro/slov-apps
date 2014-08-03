import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import '../globals.dart';
import '../lib/filter.dart';
import '../lib/filter-item.dart';

@CustomTag("excs-app")
class ExcsApp extends Filter {
  List<CheckboxInputElement> lesFilter, posFilter;
  List<Map<String, dynamic>> curDb, oriDb;
  @observable Map<String,dynamic> curTask;

  @observable int nInPool = 0;

  ExcsApp.created() : super.created() {
    //filters={"lesfilter":LESLABELS,'posfilter':POSLABELS};
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
    FilterItem lesFilter = shadowRoot.querySelector('#lessons-filter');
    FilterItem posFilter = shadowRoot.querySelector('#pos-filter');
    assert(lesFilter is FilterItem && posFilter is FilterItem);
    assert(lesFilter.activeCats is Set && posFilter.activeCats is Set);
    //assert(lesFilter.length>0 && posFilter.length >0);
    //assert(e.target is CheckboxInputElement);
    //CheckboxInputElement t = e.target;
    List<int> validLessons = [];
    for (String lesInp in lesFilter.activeCats) validLessons.addAll(LESSECMAP[lesInp]);
    //var validPos = posFilter.where((e) => e.checked).map((e) => e.dataset['fltr']).toList();
    curDb = ((e.target as FilterItem).isSubset ? curDb : oriDb).where((elm) => posFilter.activeCats.contains(elm['pos'] as String) &&
        validLessons.contains(int.parse(elm['les'] as String))).toList();
    nInPool=curDb.length;
  }
}

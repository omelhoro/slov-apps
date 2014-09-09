import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import '../globals.dart';
import '../lib/filter.dart';
import '../lib/filter-item.dart';
import '../lib/filter-panel.dart';

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

  filterDelegate() {
    FilterPanel p= shadowRoot.querySelector('filter-panel');
    FilterItem lesFilter=p.filters["les-filter"]; 
    FilterItem posFilter=p.filters["pos-filter"]; 
    var posActive=posFilter.activeCats;
    assert(lesFilter is FilterItem && posFilter is FilterItem);
    assert(lesFilter.activeCats is Set && posFilter.activeCats is Set);
    List<int> validLessons = [];
    for (String lesInp in lesFilter.activeCats) validLessons.addAll(LESSECMAP[lesInp]);
    curDb = ( lesFilter.isSubset && posFilter.isSubset ? curDb : oriDb).where((elm) => posActive.contains(elm['pos'] as String) &&
        validLessons.contains(int.parse(elm['les'] as String))).toList();
    nInPool=curDb.length;
  }
}

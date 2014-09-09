library filter_panel;
import 'package:polymer/polymer.dart';
import 'dart:html';
import './filter-item.dart';

@CustomTag("filter-panel")
class FilterPanel extends PolymerElement {
  @published List<Map<String, dynamic>> filtermapList;
  @published int colWidth;
  Map<String,FilterItem> filterCats=toObservable({});
  Map<String,FilterItem> get filters{
    var m={};
    for (FilterItem itm in shadowRoot.querySelectorAll("filter-item"))
      m[itm.filtermap["meta"]["id"]]=itm;
    return m;
  }

  FilterPanel.created() : super.created() {
  }

  void filtermapListChanged(oldValue) {
    colWidth=  (12/ filtermapList.length).ceil();
    for (Map<String,dynamic> map in filtermapList) 
      filterCats[map["meta"]["id"]]= (new Element.tag("filter-item") as FilterItem)..filtermap=map;
  }
}

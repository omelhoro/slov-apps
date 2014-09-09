library filter_panel;
import 'package:polymer/polymer.dart';
import 'dart:html';
import './filter-item.dart';

@CustomTag("filter-panel")
class FilterPanel extends PolymerElement with ChangeNotifier  {
  @reflectable @published List<Map<String, dynamic>> get filtermapList => __$filtermapList; List<Map<String, dynamic>> __$filtermapList; @reflectable set filtermapList(List<Map<String, dynamic>> value) { __$filtermapList = notifyPropertyChange(#filtermapList, __$filtermapList, value); }
  @reflectable @published int get colWidth => __$colWidth; int __$colWidth; @reflectable set colWidth(int value) { __$colWidth = notifyPropertyChange(#colWidth, __$colWidth, value); }
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

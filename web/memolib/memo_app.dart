import 'package:polymer/polymer.dart';
import '../lib/filter.dart';
import './pic_item.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';

@CustomTag("memo-app")
class MemoApp extends Filter {
  Map<String, String> oriDb;
  @published List<List<String>> rows = toObservable([]);
  List<PicItem> curVisibles = [];

  MemoApp.created() : super.created() {
    reqDb();
  }

  reqDb() => HttpRequest.getString("/static/data/pics_map.json").then(setDb);

  setDb(String value) {
    assert(value != "");
    oriDb = JSON.decode(value);
    renderGrid();
  }

  controlPics() {
    if (curVisibles[0].picText == curVisibles[1].picText) {
      curVisibles.map((e) => e.classes.add("right")).toList();
      curVisibles=[];
    } else {
      var timer = new Timer(const Duration(seconds: 2), (){curVisibles.map((e) => e.isVisible = false).toList();
        curVisibles=[];
        });
      }
    
  }


  pickPic(Event e) {
    assert(e.target is PicItem);
    PicItem t = e.target;
    if (!t.isVisible && curVisibles.length <2) {
      t.isVisible = true;
      curVisibles.add(t);
      if (curVisibles.length == 2) controlPics();
    }
  }

  renderGrid() {
    List<String> ks = oriDb.keys.toList();
    List<String> ksSubset = ks
        ..shuffle()
        ..take(8);
    List<String> flatRows = ksSubset.map((e) => [oriDb[e], e, true]).toList();
    String flatRowsText = "asd";
    flatRows.addAll(flatRows.map((e) => [e[0], e[1], false]).toList());
    flatRows.shuffle();
    var row = [];
    for (var i = 0; i < flatRows.length; i++) {
      row.add(flatRows[i]);
      if (((i + 1) % 4) == 0) {
        rows.add(row);
        row = [];
      }
    }
  }

}

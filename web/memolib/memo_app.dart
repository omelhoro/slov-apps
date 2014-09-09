import 'package:polymer/polymer.dart';
import '../lib/filter.dart';
import './pic_item.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';

@CustomTag("memo-app")
class MemoApp extends Filter {
  List<Map<String, dynamic>> oriDb;
  @published List<List<dynamic>> rows = toObservable([]);
  List<PicItem> curVisibles = [];

  MemoApp.created() : super.created() {
    reqDb();
  }

  reqDb() => HttpRequest.getString("./static/data/vocApp.json").then(setDb);

  setDb(String value) {
    assert(value != "");
    oriDb =   (JSON.decode(value) as List<Map<String,dynamic>>).where((e) => e["downloaded"]!="-").toList() ;
    assert(oriDb.length!=0);
    print(oriDb.length);
    shadowRoot.querySelector(".render").click();
  }

  controlPics() {
    print("${curVisibles[0].picMap['foreignWord']}==${curVisibles[1].picMap['foreignWord']}");
    if (curVisibles[0].picMap['foreignWord'] == curVisibles[1].picMap['foreignWord']) {
      curVisibles.map((PicItem e) {e.gotRight=true;}).toList();
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

  renderGrid(Event k) {
    var ksSubset = oriDb
        ..shuffle();
    var flatRows = ksSubset.take(8).map((e) => [e, true]).toList();
    flatRows.addAll(flatRows.map((e) => [e[0], false]).toList());
    flatRows.shuffle();
    rows=[];
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

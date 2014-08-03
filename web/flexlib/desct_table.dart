import 'package:polymer/polymer.dart';
import 'package:bootjack/bootjack.dart';
import 'dart:html';

@CustomTag('desct-table')
class DescTable extends PolymerElement {
  @published List<List<dynamic>> curParadigm;
  @published List<String> firstTdOrder;
  @published Map<String,dynamic> wordData;

  DescTable.created() : super.created() {
  }
  domReady(){
    shadowRoot.querySelectorAll(".transl").forEach((Element e){
      Popover.wire(e,()=>new Popover(e,trigger: "hover focus",title:(el)=>"Translation (Google)", content: (el){
        String l=e.dataset['lang'].substring(0,2);
        return wordData['meaning'+l];
      }
      ));
    });
  }
  void checkall() {
    List<dynamic> btns = shadowRoot.querySelectorAll("flex-inp");
    btns.map((e) => e.control()).toList();
  }
}

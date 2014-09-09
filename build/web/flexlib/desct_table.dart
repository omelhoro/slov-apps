import 'package:polymer/polymer.dart';
import 'package:bootjack/bootjack.dart';
import 'dart:html';

@CustomTag('desct-table')
class DescTable extends PolymerElement with ChangeNotifier  {
  @reflectable @published List<List<dynamic>> get curParadigm => __$curParadigm; List<List<dynamic>> __$curParadigm; @reflectable set curParadigm(List<List<dynamic>> value) { __$curParadigm = notifyPropertyChange(#curParadigm, __$curParadigm, value); }
  @reflectable @published List<String> get firstTdOrder => __$firstTdOrder; List<String> __$firstTdOrder; @reflectable set firstTdOrder(List<String> value) { __$firstTdOrder = notifyPropertyChange(#firstTdOrder, __$firstTdOrder, value); }
  @reflectable @published Map<String,dynamic> get wordData => __$wordData; Map<String,dynamic> __$wordData; @reflectable set wordData(Map<String,dynamic> value) { __$wordData = notifyPropertyChange(#wordData, __$wordData, value); }

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

library inpool_label;
import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag("inpool-label")
class InpoolLabel extends PolymerElement with ChangeNotifier  {
  @reflectable @published int get nipIntern => __$nipIntern; int __$nipIntern; @reflectable set nipIntern(int value) { __$nipIntern = notifyPropertyChange(#nipIntern, __$nipIntern, value); }
  @reflectable @published int get nip => __$nip; int __$nip; @reflectable set nip(int value) { __$nip = notifyPropertyChange(#nip, __$nip, value); }
  
  void nipChanged(oldValue) {
    (shadowRoot.querySelector("button") as ButtonElement).disabled =nip==0;
  }
  InpoolLabel .created(): super.created(){
    
  }
   }
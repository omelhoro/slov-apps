library inpool_label;
import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag("inpool-label")
class InpoolLabel extends PolymerElement {
  @published int nipIntern;
  @published int nip;
  
  void nipChanged(oldValue) {
    (shadowRoot.querySelector("button") as ButtonElement).disabled =nip==0;
  }
  InpoolLabel .created(): super.created(){
    
  }
   }
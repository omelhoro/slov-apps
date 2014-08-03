import 'package:polymer/polymer.dart';
import 'dart:html';
@CustomTag("apps-panel")
class AppsPanel extends PolymerElement {
  @observable String curApp;
  Map<String, String> apps = {
    "desc-app": "Descension",
    "voc-app": "Vocabulary",
    "excs-app": "Exercises",
    "wordf-app": "Texts (Show)",
    "marknoun-app": "Texts (Mark)",
    "memo-app": "Memory"
  };
  AppsPanel.created() : super.created();

  renderApp(Event e) {
    assert(e.currentTarget is LIElement);
    LIElement appItm =e.currentTarget;
    curApp=appItm.dataset["apptagname"];
    shadowRoot.querySelector("#appfield").children = [new Element.tag(curApp)];
  }
}

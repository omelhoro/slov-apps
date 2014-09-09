import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag("task-excs")
class TaskExcs extends PolymerElement with ChangeNotifier  {
  List<ButtonElement> checkButts;
  @reflectable @published Map<String, dynamic> get taskMap => __$taskMap; Map<String, dynamic> __$taskMap; @reflectable set taskMap(Map<String, dynamic> value) { __$taskMap = notifyPropertyChange(#taskMap, __$taskMap, value); }

  HtmlElement taskBody, taskExpl;
  final NodeValidatorBuilder parser = new NodeValidatorBuilder.common()..allowElement('input',
      attributes: ['data-sol']);

  TaskExcs.created() : super.created();

  insertTask(val) {
    var el = new Element.html("<div>" + taskMap['task'] + "</div>", validator: parser);
    checkButts = el.querySelectorAll(".corrector")..onClick.listen(check);
    assert(checkButts.length > 0);
    var expl = new Element.html("<div>" + taskMap['expl'] + "</div>", validator: parser);
    shadowRoot.querySelector("#task").children = [el];
    shadowRoot.querySelector("#expl").children = [expl];
  }
  check(Event e) {
    assert(e.currentTarget is ButtonElement);
    ButtonElement bt = e.currentTarget;
    SpanElement btp = bt.parent;
    List<InputElement> inputs = btp.querySelectorAll("input");
    for (var inp in inputs) inp.className = inp.dataset["sol"].trim() == inp.value ? "right" :
        "false";
  }
  checkall() {
    checkButts.map((e) => e.click()).toList();
  }

}

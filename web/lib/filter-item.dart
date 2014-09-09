library filter_item;
import 'package:polymer/polymer.dart';
//import 'dart:html';

@CustomTag("filter-item")
class FilterItem extends PolymerElement {
  @published Map<String, dynamic> filtermap;//={"a":{"b":"c"},"d":{"e":"h"}};
  Set<String> _activeCats, _activeValues;
  set activeCats(Set v) => _activeCats = v;
  Set<String> get activeCats {
    var  checked=shadowRoot.querySelectorAll(".filter-inp:checked");
    print(_activeCats);
    if (_activeCats == null)
      _activeCats = filtermap["cats"].keys.toSet();
      else
        _activeCats =shadowRoot.querySelectorAll(".filter-inp:checked").map((e) => e.value).toSet();
    //print("Return ${_activeCats.toString()} as ${shadowRoot.querySelectorAll(".filter-inp:checked")}  from ${filtermap.toString()}");
      return _activeCats;
  }
  set activeValues(Set v) => _activeValues = v;
  Set<String> get activeValues {
    if (_activeValues == null) _activeValues = filtermap["cats"].values.toSet();
    return _activeValues;
  }
  toggleHide(var evt) {
    shadowRoot.querySelector(".filter-list").classes.toggle("hide");
  }
  bool isSubset = true;
  set cat(var val) {
    activeCats = shadowRoot.querySelectorAll(".filter-inp:checked").map((e) => e.value).toSet();
    activeValues = activeCats.map((e) => filtermap["cats"][e]).toSet();
    isSubset = !activeCats.contains(val);
  }

  FilterItem.created() : super.created() {
  }
}

library filter_item;
import 'package:polymer/polymer.dart';

@CustomTag("filter-item")
class FilterItem extends PolymerElement {
  @published Map<String,dynamic>filtermap;//={"a":{"b":"c"},"d":{"e":"h"}};
  @published String title,lang; 
  @published bool ischeckbtn;
  Set<String> _activeCats,_activeValues;
  set activeCats(Set v)=>_activeCats=v;
  Set<String> get activeCats {
      if (_activeCats == null) _activeCats=filtermap.keys.toSet();
      return _activeCats;
  }
  set activeValues(Set v)=>_activeValues=v;
  Set<String> get activeValues {
      if (_activeValues == null) _activeValues=filtermap.values.toSet();
      return _activeValues;
  }
  toggleHide(var evt){
    shadowRoot.querySelector(".filter-list").classes.toggle("hide");
  }
  bool isSubset=true;
  set cat(val){
    print(val);
    int lenCats=activeCats.length;
    activeCats=shadowRoot.querySelectorAll(".filter-inp:checked").map((e)=> e.value).toSet();
    activeValues=activeCats.map((e)=> lang==null ? filtermap[e]:filtermap[e][lang]).toSet();
    isSubset=lenCats >activeCats.length ? true: false;
    print(activeCats);
  }
  
  FilterItem.created(): super.created(){
  }
   }
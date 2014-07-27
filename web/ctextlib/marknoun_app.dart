import 'package:polymer/polymer.dart';
import './wordf_app.dart';
import 'dart:html';
import './word_form.dart';
import '../globals.dart' show CASUS;
import 'dart:math' show min,max;


@CustomTag("marknoun-app")
class NounMarker extends WordfApp{
  List<WordForm> allNouns;
  List<LIElement> allCases;
  List<String> casus=CASUS.values.toList();
  int curIx,curCaseIx=0;
  List<String> poss=[];
  @observable Map<String,List<dynamic>> stats=toObservable( {
    "Unmarked":["label-default", 0],
    "Correct":["label-success",0],
    "False":["label-danger",0]
  });
  var keyListener;
  NounMarker.created(): super.created(){
  }
  setSelection(bool isSet,bool isNoun){
    if (isNoun)
    isSet ?  allNouns[curIx].classes.add("selectedcase") : allNouns[curIx].classes.remove("selectedcase");
    else
      isSet ?  allCases[curCaseIx].classes.add("selectedcase") : allCases[curCaseIx].classes.remove("selectedcase");
  }
  domReady(){
    super.domReady();
     keyListener= window.onKeyUp.listen(moveSelection);
 }
  setTextField()=> textField=shadowRoots['wordf-app'].querySelector("#text");

  detached(){
    super.detached();
    keyListener.cancel();
  }

  markCase(){
    WordForm curTask= allNouns[curIx];
    String caseClass=casus[curCaseIx].substring(0,3).toLowerCase();
    String userTagged=curTask.dataset.putIfAbsent("usercase", ()=>"");
    if (caseClass!=userTagged){
    curTask.classes
    ..remove(userTagged)
    ..addAll(["noun",caseClass]);
    curTask.dataset["usercase"]=caseClass;
    curTask.dataset["sol"]= curTask.grammarAtrs["Case"].substring(0,3).toLowerCase();
    }
  }

  checkall(){
    List<WordForm> marked=WordForm.allForms.where((e)=> e.dataset.containsKey("usercase")).toList();
    marked.forEach((e){
      e.dataset["usercase"]==e.dataset["sol"] ? e.classes.add("rightmarked") : e.classes.add("falsemarked");
    });
    stats["Unmarked"][1]=allNouns.length-marked.length;
    int correctTags=marked.where((WordForm e)=> e.classes.contains("rightmarked")).length;
    stats["Correct"][1]=correctTags;
    stats["False"][1]=marked.length- correctTags;
  }

  setText(String k){
    super.setText(k);
    curIx=curCaseIx=0;
    allNouns= WordForm.allForms.where((WordForm e)=> e.grammarAtrs["Pos"]=="Noun").toList();
    allCases=shadowRoots["marknoun-app"].querySelectorAll(".noun");
    assert(allNouns.length!=0);
    assert(allCases.length!=0);
    setSelection(true,true);
    setSelection(true,false);
  }

  void moveSelection(KeyboardEvent event) {
    int char=event.keyCode;
    bool isNoun=[65,68].contains(char);
    bool isCase=[83,87].contains(char);
    if (isNoun || isCase){
      int curPoolLength= isNoun ? allNouns.length :casus.length;
      List<int> keyPool= isNoun ? [65,68]:[83,87];
      Function f= isNoun ? min:max;
      var localIx=isNoun ? curIx : curCaseIx;
      setSelection(false,isNoun);
      print(localIx);
      localIx+= char==f(keyPool[0],keyPool[1]) ? -1 : 1 ;
      localIx= localIx >= curPoolLength ? 0 : localIx;
      localIx= localIx < 0 ? curPoolLength-1 : localIx;
      print(localIx);
      isNoun ? curIx=localIx : curCaseIx=localIx;
      setSelection(true,isNoun);
    } else if (char==32) markCase();
  }
}
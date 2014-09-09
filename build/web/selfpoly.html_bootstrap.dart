library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'lib/filter.dart' as i0;
import 'memolib/pic_item.dart' as i1;
import 'memolib/memo_app.dart' as i2;
import 'flexlib/flex_inp.dart' as i3;
import 'flexlib/desct_table.dart' as i4;
import 'lib/filter-item.dart' as i5;
import 'lib/filter-panel.dart' as i6;
import 'lib/inpool_label.dart' as i7;
import 'flexlib/desc_app.dart' as i8;
import 'excslib/excs_task.dart' as i9;
import 'excslib/excs_app.dart' as i10;
import 'voclib/voc_task.dart' as i11;
import 'voclib/voc_app.dart' as i12;
import 'ctextlib/word_form.dart' as i13;
import 'ctextlib/wordf_app.dart' as i14;
import 'ctextlib/marknoun_app.dart' as i15;
import 'appslib/apps_panel.dart' as i16;
import 'selfpoly.html.0.dart' as i17;
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'lib/filter.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:observe/src/metadata.dart' as smoke_2;
import 'memolib/pic_item.dart' as smoke_3;
import 'memolib/memo_app.dart' as smoke_4;
import 'flexlib/flex_inp.dart' as smoke_5;
import 'flexlib/desct_table.dart' as smoke_6;
import 'lib/filter-item.dart' as smoke_7;
import 'lib/filter-panel.dart' as smoke_8;
import 'lib/inpool_label.dart' as smoke_9;
import 'flexlib/desc_app.dart' as smoke_10;
import 'excslib/excs_task.dart' as smoke_11;
import 'excslib/excs_app.dart' as smoke_12;
import 'voclib/voc_task.dart' as smoke_13;
import 'voclib/voc_app.dart' as smoke_14;
import 'ctextlib/word_form.dart' as smoke_15;
import 'ctextlib/wordf_app.dart' as smoke_16;
import 'ctextlib/marknoun_app.dart' as smoke_17;
import 'appslib/apps_panel.dart' as smoke_18;
abstract class _M0 {} // PolymerElement & ChangeNotifier
abstract class _M1 {} // Filter & ChangeNotifier
abstract class _M2 {} // WordfApp & ChangeNotifier

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #alt: (o) => o.alt,
        #alternatives: (o) => o.alternatives,
        #app: (o) => o.app,
        #apps: (o) => o.apps,
        #c: (o) => o.c,
        #caseMap: (o) => o.caseMap,
        #cat: (o) => o.cat,
        #changeMod: (o) => o.changeMod,
        #checkMulti: (o) => o.checkMulti,
        #checkSingle: (o) => o.checkSingle,
        #checkall: (o) => o.checkall,
        #colWidth: (o) => o.colWidth,
        #control: (o) => o.control,
        #curApp: (o) => o.curApp,
        #curCaseClass: (o) => o.curCaseClass,
        #curParadigm: (o) => o.curParadigm,
        #curTask: (o) => o.curTask,
        #enumerate: (o) => o.enumerate,
        #filter: (o) => o.filter,
        #filtermap: (o) => o.filtermap,
        #filtermapList: (o) => o.filtermapList,
        #filtermapListChanged: (o) => o.filtermapListChanged,
        #filters: (o) => o.filters,
        #firstTdOrder: (o) => o.firstTdOrder,
        #fltr: (o) => o.fltr,
        #flx: (o) => o.flx,
        #genMap: (o) => o.genMap,
        #gramTagEn: (o) => o.gramTagEn,
        #gramTagSl: (o) => o.gramTagSl,
        #grammarAtrs: (o) => o.grammarAtrs,
        #hid: (o) => o.hid,
        #index: (o) => o.index,
        #insertTask: (o) => o.insertTask,
        #isPic: (o) => o.isPic,
        #isSelected: (o) => o.isSelected,
        #isSelected0: (o) => o.isSelected0,
        #isSingleView: (o) => o.isSingleView,
        #isVisible: (o) => o.isVisible,
        #keys: (o) => o.keys,
        #lemma: (o) => o.lemma,
        #lesCats: (o) => o.lesCats,
        #levelMap: (o) => o.levelMap,
        #nInPool: (o) => o.nInPool,
        #next: (o) => o.next,
        #nip: (o) => o.nip,
        #nipChanged: (o) => o.nipChanged,
        #nipIntern: (o) => o.nipIntern,
        #pic: (o) => o.pic,
        #picClass: (o) => o.picClass,
        #picMap: (o) => o.picMap,
        #picMapChanged: (o) => o.picMapChanged,
        #picPath: (o) => o.picPath,
        #pickPic: (o) => o.pickPic,
        #posMap: (o) => o.posMap,
        #r: (o) => o.r,
        #renderApp: (o) => o.renderApp,
        #renderGrid: (o) => o.renderGrid,
        #row: (o) => o.row,
        #rows: (o) => o.rows,
        #setLevel: (o) => o.setLevel,
        #stat: (o) => o.stat,
        #stats: (o) => o.stats,
        #stem: (o) => o.stem,
        #switchView: (o) => o.switchView,
        #taskMap: (o) => o.taskMap,
        #td: (o) => o.td,
        #textMap: (o) => o.textMap,
        #toggleHide: (o) => o.toggleHide,
        #tonal: (o) => o.tonal,
        #updateCase: (o) => o.updateCase,
        #value: (o) => o.value,
        #wordData: (o) => o.wordData,
        #wordMap: (o) => o.wordMap,
      },
      setters: {
        #alternatives: (o, v) { o.alternatives = v; },
        #cat: (o, v) { o.cat = v; },
        #colWidth: (o, v) { o.colWidth = v; },
        #curApp: (o, v) { o.curApp = v; },
        #curCaseClass: (o, v) { o.curCaseClass = v; },
        #curParadigm: (o, v) { o.curParadigm = v; },
        #curTask: (o, v) { o.curTask = v; },
        #filtermap: (o, v) { o.filtermap = v; },
        #filtermapList: (o, v) { o.filtermapList = v; },
        #filters: (o, v) { o.filters = v; },
        #firstTdOrder: (o, v) { o.firstTdOrder = v; },
        #flx: (o, v) { o.flx = v; },
        #gramTagEn: (o, v) { o.gramTagEn = v; },
        #gramTagSl: (o, v) { o.gramTagSl = v; },
        #grammarAtrs: (o, v) { o.grammarAtrs = v; },
        #hid: (o, v) { o.hid = v; },
        #isPic: (o, v) { o.isPic = v; },
        #isSelected: (o, v) { o.isSelected = v; },
        #isSelected0: (o, v) { o.isSelected0 = v; },
        #isSingleView: (o, v) { o.isSingleView = v; },
        #isVisible: (o, v) { o.isVisible = v; },
        #lemma: (o, v) { o.lemma = v; },
        #nInPool: (o, v) { o.nInPool = v; },
        #nip: (o, v) { o.nip = v; },
        #nipIntern: (o, v) { o.nipIntern = v; },
        #picClass: (o, v) { o.picClass = v; },
        #picMap: (o, v) { o.picMap = v; },
        #picPath: (o, v) { o.picPath = v; },
        #rows: (o, v) { o.rows = v; },
        #stats: (o, v) { o.stats = v; },
        #stem: (o, v) { o.stem = v; },
        #taskMap: (o, v) { o.taskMap = v; },
        #tonal: (o, v) { o.tonal = v; },
        #wordData: (o, v) { o.wordData = v; },
        #wordMap: (o, v) { o.wordMap = v; },
      },
      parents: {
        smoke_18.AppsPanel: _M0,
        smoke_17.NounMarker: _M2,
        smoke_15.WordForm: _M0,
        smoke_16.WordfApp: smoke_0.Filter,
        smoke_12.ExcsApp: _M1,
        smoke_11.TaskExcs: _M0,
        smoke_10.DescApp: _M1,
        smoke_6.DescTable: _M0,
        smoke_5.ParItem: _M0,
        smoke_7.FilterItem: _M0,
        smoke_8.FilterPanel: _M0,
        smoke_0.Filter: _M0,
        smoke_9.InpoolLabel: _M0,
        smoke_4.MemoApp: _M1,
        smoke_3.PicItem: _M0,
        smoke_14.VocApp: _M1,
        smoke_13.Task: _M0,
        _M0: smoke_1.PolymerElement,
        _M1: smoke_0.Filter,
        _M2: smoke_16.WordfApp,
      },
      declarations: {
        smoke_18.AppsPanel: {
          #curApp: const Declaration(#curApp, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_17.NounMarker: {
          #curCaseClass: const Declaration(#curCaseClass, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #stats: const Declaration(#stats, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_15.WordForm: {
          #gramTagEn: const Declaration(#gramTagEn, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #gramTagSl: const Declaration(#gramTagSl, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #grammarAtrs: const Declaration(#grammarAtrs, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #isSelected: const Declaration(#isSelected, dynamic, kind: PROPERTY, annotations: const [smoke_1.published]),
          #isSelected0: const Declaration(#isSelected0, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #lemma: const Declaration(#lemma, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #tonal: const Declaration(#tonal, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_16.WordfApp: const {},
        smoke_12.ExcsApp: {
          #curTask: const Declaration(#curTask, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #nInPool: const Declaration(#nInPool, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_11.TaskExcs: {
          #taskMap: const Declaration(#taskMap, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_10.DescApp: {
          #curParadigm: const Declaration(#curParadigm, List, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #curTask: const Declaration(#curTask, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #firstTdOrder: const Declaration(#firstTdOrder, List, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #nInPool: const Declaration(#nInPool, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_6.DescTable: {
          #curParadigm: const Declaration(#curParadigm, List, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #firstTdOrder: const Declaration(#firstTdOrder, List, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #wordData: const Declaration(#wordData, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_5.ParItem: {
          #flx: const Declaration(#flx, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #hid: const Declaration(#hid, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #stem: const Declaration(#stem, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_7.FilterItem: {
          #filtermap: const Declaration(#filtermap, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_8.FilterPanel: {
          #colWidth: const Declaration(#colWidth, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #filtermapList: const Declaration(#filtermapList, List, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #filtermapListChanged: const Declaration(#filtermapListChanged, Function, kind: METHOD),
        },
        smoke_0.Filter: {
          #filters: const Declaration(#filters, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_9.InpoolLabel: {
          #nip: const Declaration(#nip, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #nipChanged: const Declaration(#nipChanged, Function, kind: METHOD),
          #nipIntern: const Declaration(#nipIntern, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_4.MemoApp: {
          #rows: const Declaration(#rows, List, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
        smoke_3.PicItem: {
          #isPic: const Declaration(#isPic, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #isVisible: const Declaration(#isVisible, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
          #picClass: const Declaration(#picClass, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #picMap: const Declaration(#picMap, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #picMapChanged: const Declaration(#picMapChanged, Function, kind: METHOD),
          #picPath: const Declaration(#picPath, String, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_14.VocApp: {
          #nInPool: const Declaration(#nInPool, int, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_2.observable]),
        },
        smoke_13.Task: {
          #alternatives: const Declaration(#alternatives, List, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #isSingleView: const Declaration(#isSingleView, bool, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
          #wordMap: const Declaration(#wordMap, Map, kind: PROPERTY, annotations: const [smoke_2.reflectable, smoke_1.published]),
        },
      },
      names: {
        #alt: r'alt',
        #alternatives: r'alternatives',
        #app: r'app',
        #apps: r'apps',
        #c: r'c',
        #caseMap: r'caseMap',
        #cat: r'cat',
        #changeMod: r'changeMod',
        #checkMulti: r'checkMulti',
        #checkSingle: r'checkSingle',
        #checkall: r'checkall',
        #colWidth: r'colWidth',
        #control: r'control',
        #curApp: r'curApp',
        #curCaseClass: r'curCaseClass',
        #curParadigm: r'curParadigm',
        #curTask: r'curTask',
        #enumerate: r'enumerate',
        #filter: r'filter',
        #filtermap: r'filtermap',
        #filtermapList: r'filtermapList',
        #filtermapListChanged: r'filtermapListChanged',
        #filters: r'filters',
        #firstTdOrder: r'firstTdOrder',
        #fltr: r'fltr',
        #flx: r'flx',
        #genMap: r'genMap',
        #gramTagEn: r'gramTagEn',
        #gramTagSl: r'gramTagSl',
        #grammarAtrs: r'grammarAtrs',
        #hid: r'hid',
        #index: r'index',
        #insertTask: r'insertTask',
        #isPic: r'isPic',
        #isSelected: r'isSelected',
        #isSelected0: r'isSelected0',
        #isSingleView: r'isSingleView',
        #isVisible: r'isVisible',
        #keys: r'keys',
        #lemma: r'lemma',
        #lesCats: r'lesCats',
        #levelMap: r'levelMap',
        #nInPool: r'nInPool',
        #next: r'next',
        #nip: r'nip',
        #nipChanged: r'nipChanged',
        #nipIntern: r'nipIntern',
        #pic: r'pic',
        #picClass: r'picClass',
        #picMap: r'picMap',
        #picMapChanged: r'picMapChanged',
        #picPath: r'picPath',
        #pickPic: r'pickPic',
        #posMap: r'posMap',
        #r: r'r',
        #renderApp: r'renderApp',
        #renderGrid: r'renderGrid',
        #row: r'row',
        #rows: r'rows',
        #setLevel: r'setLevel',
        #stat: r'stat',
        #stats: r'stats',
        #stem: r'stem',
        #switchView: r'switchView',
        #taskMap: r'taskMap',
        #td: r'td',
        #textMap: r'textMap',
        #toggleHide: r'toggleHide',
        #tonal: r'tonal',
        #updateCase: r'updateCase',
        #value: r'value',
        #wordData: r'wordData',
        #wordMap: r'wordMap',
      }));
  configureForDeployment([
      () => Polymer.register('filter-tmp', i0.Filter),
      () => Polymer.register('pic-item', i1.PicItem),
      () => Polymer.register('memo-app', i2.MemoApp),
      () => Polymer.register('flex-inp', i3.ParItem),
      () => Polymer.register('desct-table', i4.DescTable),
      () => Polymer.register('filter-item', i5.FilterItem),
      () => Polymer.register('filter-panel', i6.FilterPanel),
      () => Polymer.register('inpool-label', i7.InpoolLabel),
      () => Polymer.register('desc-app', i8.DescApp),
      () => Polymer.register('task-excs', i9.TaskExcs),
      () => Polymer.register('excs-app', i10.ExcsApp),
      () => Polymer.register('word-voc', i11.Task),
      () => Polymer.register('voc-app', i12.VocApp),
      () => Polymer.register('word-form', i13.WordForm),
      () => Polymer.register('wordf-app', i14.WordfApp),
      () => Polymer.register('marknoun-app', i15.NounMarker),
      () => Polymer.register('apps-panel', i16.AppsPanel),
    ]);
  i17.main();
}

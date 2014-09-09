library globals;
final Map<int, String> CASUS = {
  "meta": {
    "type": "checkbox",
    "title": "Cases",
    "id": "case-filter"
  },
  "cats": {
    "nom": {
      "en": "Nominative",
      "de": "Nominativ",
      "sl": "Imenovalnik"
    },
    "acc": {
      "en": "Accusative",
      "de": "Akksuativ",
      "sl": "Tožilnik"
    },
    "gen": {
      "en": "Genitive",
      "de": "Genitiv",
      "sl": "Rodilnik"
    },
    "dat": {
      "en": "Dative",
      "de": "Dativ",
      "sl": "Dajalnik"
    },
    "loc": {
      "en": "Locative",
      "de": "Lokativ",
      "sl": "Mestnik"
    },
    "ins": {
      "en": "Instrumental",
      "de": "Instrumental",
      "sl": "Orodnik"
    }
  }
};

List<List<dynamic>> transpose(List<List<dynamic>> l) {
  int lLength = l[0].length;
  var newl = new List<List>();
  for (var i = 0; i < lLength; i++) {
    var newRow = new List();
    for (var j = 0; j < l.length; j++) newRow.add(l[j][i]);
    newl.add(newRow);
  }
  return newl;
}


List<int> range(int st, int en) {
  List<int> l = [];
  for (var i = st; i < en; i++) l.add(i);
  return l;
}

final Map<String, List<int>> LESSECMAP = {
  "beg": range(1, 8),
  "abeg": range(8, 12),
  "adv": range(12, 18),
};

final Map<String, Map> HARDNESS = {
                                   "meta": {
                                     "type": "checkbox",
                                     "title": "Cases",
                                     "id": "case-filter"
                                   },
                                   "cats":{
  "0.25": {
    "de": "Anfänger",
    "en": "Beginner"
  },
  "0.50": {
    "de": "Mittlere Kenntnisse",
    "en": "Intermediate"
  },
  "0.75": {
    "de": "Fortgeschritten",
    "en": "Advanced"
  },
  "1": {
    "de": "Experte",
    "en": "Expert"
  }
}
};

final Map<String, String> LESLABELS = {
  "meta": {
    "type": "checkbox",
    "title": "Lessons",
    "id": "les-filter"
  },
  "cats": {
    "beg": "Beginner (Lessons ${LESSECMAP["beg"].first}-${LESSECMAP["beg"].last})",
    "abeg": "Advanced beginner (Lessons ${LESSECMAP["abeg"].first}-${LESSECMAP["abeg"].last})",
    "adv": "Advanced (Lessons ${LESSECMAP["adv"].first}-${LESSECMAP["adv"].last})"
  }
};

Map<String, Map<String, String>> getLang(String lang, Map oriMap) {
  Map<String,Map<String, String>> tempMap = {"cats":{}};
  tempMap["meta"] = oriMap["meta"];
  oriMap["cats"].forEach((k, v) {
    var l;
    if (v is Map) {
      try {
        l = v[lang];
      } catch (e) {
        print("No such language! Fall back on value");
        l = v;
      }
    } else {
      print("No internationalization!");
      l = v;
    }
    tempMap["cats"][k] = l;
  });
  return tempMap;
}
final Map<String, Map<String, String>> POSLABELS = {
  "meta": {
    "type": "checkbox",
    "title": "Part of Speech",
    "id": "pos-filter"
  },
  "cats": {
    "noun": {
      "de": "Nomen",
      "en": "Noun"
    },
    "verb": {
      "de": "Verb",
      "en": "Verb"
    },
    "adj": {
      "de": "Adjektiv/Adverb",
      "en": "Adjective"
    },
    "prep": {
      "de": "Präpositionen",
      "en": "Preposition"
    },
    "pron": {
      "de": "Pronomen",
      "en": "Pronoun"
    },
    "mix": {
      "de": "Gemischt",
      "en": "Misc"
    },
  }
};
Map<String, String> GENMAP = {
  "meta": {
    "type": "checkbox",
    "title": "Genus",
    "id": "gen-filter"
  },
  "cats": {
    "masculine": {
      "de": "Maskulin",
      "en": "Masculine"
    },
    "feminine": {
      "de": "Feminin",
      "en": "Feminine"
    },
    "neuter": {
      "de": "Neutrum",
      "en": "Neuter"
    }
  }
};

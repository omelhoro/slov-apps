library globals;
final Map<int, String> CASUS = {
  0: "Nominative",
  1: "Accusative",
  2: "Genitive",
  3: "Dative",
  4: "Locative",
  5: "Instrumental"
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

final Map<String, String> LESLABELS = {
  "beg": "Beginner (Lessons ${LESSECMAP["beg"].first}-${LESSECMAP["beg"].last})",
  "abeg": "Advanced beginner (Lessons ${LESSECMAP["abeg"].first}-${LESSECMAP["abeg"].last})",
  "adv": "Advanced (Lessons ${LESSECMAP["adv"].first}-${LESSECMAP["adv"].last})"
};

final Map<String, String> POSLABELS ={
  "noun": "Nomen",
  "verb": "Verb",
  "adj": "Adjektiv/Adverb",
  "prep": "Präpositionen",
  "pron": "Pronomen",
  "mix": "Gemischt",
};
Map<String, bool> GENMAP = {
  "masculine": "Maskulin",
  "feminine": "Feminin",
  "neuter": "Neutrum"
};
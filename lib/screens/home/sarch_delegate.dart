import 'package:flutter/material.dart';

class MainSearchDelegate extends SearchDelegate<String> {
  final testData = [
    "Berlin",
    "Hamburg",
    "München",
    "Köln",
    "Frankfurt am Main",
    "Stuttgart",
    "Düsseldorf",
    "Leipzig",
    "Dortmund",
    "Essen",
    "Bremen",
    "Dresden",
    "Hannover",
    "Nürnberg",
    "Duisburg",
    "Bochum",
    "Wuppertal",
    "Bielefeld",
    "Bonn",
    "Münster",
    "Mannheim",
    "Karlsruhe",
    "Augsburg",
    "Wiesbaden",
    "Mönchengladbach",
    "Gelsenkirchen",
    "Aachen",
    "Braunschweig",
    "Kiel",
    "Chemniz",
    "Halle (Saale)",
    "Magdeburg",
    "Freiburg",
    "Krefeld",
    "Mainz",
    "Lübeck",
    "Erfurt",
    "Oberhausen",
    "Rostock",
    "Saarbrücken",
    "Hamm",
    "Ludwigshafen am Rhein",
    "Mühlheim an der Ruhr",
    "Ulm"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty)
            close(context, query);
          else
            query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, query);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? ["Berlin", "Hamburg", "Test"]
        : testData.where((e) => e.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestionList[index]),
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
      ),
      itemCount: suggestionList.length,
    );
  }
}

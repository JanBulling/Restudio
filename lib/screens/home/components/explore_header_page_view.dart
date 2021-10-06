import 'package:flutter/material.dart';

class ExploreHeaderPageView extends StatefulWidget {
  @override
  _ExploreHeaderPageViewState createState() => _ExploreHeaderPageViewState();
}

class _ExploreHeaderPageViewState extends State<ExploreHeaderPageView> {
  int _currentIndex = 0;

  List<Map<String, dynamic>> data = [
    {
      "title": "Italienisch",
      "text": "Pizza, Pasta und co.",
      "color": Colors.green[600],
    },
    {
      "title": "Asiatisch?",
      "text": "Gebratene Nudeln, Reis, und mehr",
      "color": Colors.yellow[700],
    },
    {
      "title": "Griechisch",
      "text": "Typisch zur Olympia",
      "color": Colors.blue[300],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          child: PageView.builder(
            itemBuilder: (context, index) => ExploreHeaderItem(
              title: data[index]["title"],
              text: data[index]["text"],
              color: data[index]["color"],
            ),
          ),
        ),
      ],
    );
  }
}

class ExploreHeaderItem extends StatelessWidget {
  final String title;
  final String text;
  final Color color;

  const ExploreHeaderItem({
    Key? key,
    required this.text,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

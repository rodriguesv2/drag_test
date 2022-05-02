import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Teste Drag"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final list = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent imperdiet venenatis magna, et fringilla ante.",
    "Etiam ut felis in metus placerat dapibus. Vestibulum fringilla iaculis dui, eu iaculis nulla blandit vel.",
    "Aenean eget tellus vitae sem euismod feugiat. Phasellus lobortis eleifend urna, quis consequat augue semper a. Etiam condimentum cursus venenatis. Mauris id suscipit enim. Phasellus pellentesque luctus condimentum.",
    "Nullam ut lacus tortor. Cras non erat purus. In felis justo, tristique at accumsan nec, lobortis non odio.",
    "Donec fringilla ante mi, a faucibus eros hendrerit non. Aenean elementum enim sed nibh aliquet venenatis. In egestas dignissim nisi lobortis viverra. Cras et quam nunc.",
    "Quisque varius, orci ac blandit commodo, metus dui congue lacus, quis rhoncus quam sapien eu augue. In eu ex et nisl pellentesque congue a eget nisl.",
    "Vestibulum convallis erat ac nunc aliquet, in mattis dolor aliquet. Donec id suscipit nunc, eget gravida nunc. ",
    "Integer ultrices quam mi, ut feugiat felis mattis id. Donec ornare vehicula efficitur. Sed lectus erat, laoreet quis leo vel, volutpat tempor ante.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: 400,
        child: ListView(
          children: [
            ...list.asMap().entries.map((entry) {
              final cardContentIndexed = entry;

              return Draggable<MapEntry<int, String>>(
                data: cardContentIndexed,
                child: _cardDragTarget(cardContentIndexed),
                feedback: _textCard(
                  cardContentIndexed.value,
                  backgroundColor: const Color(0xAAFF6E40),
                ),
                childWhenDragging: _textCard(
                  cardContentIndexed.value,
                  shouldHide: true,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  DragTarget<MapEntry<int, String>> _cardDragTarget(
    MapEntry<int, String> cardContentIndexed,
  ) {
    return DragTarget<MapEntry<int, String>>(
      onAccept: (cardDragged) {
        setState(() {
          final newPost = cardContentIndexed.value + "\n\n" + cardDragged.value;
          list[cardContentIndexed.key] = newPost;
          list.removeAt(cardDragged.key);
        });
      },
      builder: (_, __, ___) {
        return _textCard(cardContentIndexed.value);
      },
    );
  }

  Widget _textCard(
    String text, {
    Color backgroundColor = const Color(0xFFFF6E40),
    bool shouldHide = false,
  }) {
    return SizedBox(
      width: 400,
      child: Card(
        color: shouldHide ? Colors.transparent : backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
                color: shouldHide ? Colors.transparent : Colors.black),
          ),
        ),
      ),
    );
  }
}

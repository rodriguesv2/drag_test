import 'package:flutter/material.dart';

class DragDropMergePage extends StatefulWidget {
  const DragDropMergePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<DragDropMergePage> createState() => _DragDropMergePageState();
}

class _DragDropMergePageState extends State<DragDropMergePage> {
  final list = [
    "#1 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent imperdiet venenatis magna, et fringilla ante.",
    "#2 Etiam ut felis in metus placerat dapibus. Vestibulum fringilla iaculis dui, eu iaculis nulla blandit vel.",
    "#3 Aenean eget tellus vitae sem euismod feugiat. Phasellus lobortis eleifend urna, quis consequat augue semper a. Etiam condimentum cursus venenatis. Mauris id suscipit enim. Phasellus pellentesque luctus condimentum.",
    "#4 Nullam ut lacus tortor. Cras non erat purus. In felis justo, tristique at accumsan nec, lobortis non odio.",
    "#5 Donec fringilla ante mi, a faucibus eros hendrerit non. Aenean elementum enim sed nibh aliquet venenatis. In egestas dignissim nisi lobortis viverra. Cras et quam nunc.",
    "#6 Quisque varius, orci ac blandit commodo, metus dui congue lacus, quis rhoncus quam sapien eu augue. In eu ex et nisl pellentesque congue a eget nisl.",
    "#7 Vestibulum convallis erat ac nunc aliquet, in mattis dolor aliquet. Donec id suscipit nunc, eget gravida nunc. ",
    "#8 Integer ultrices quam mi, ut feugiat felis mattis id. Donec ornare vehicula efficitur. Sed lectus erat, laoreet quis leo vel, volutpat tempor ante.",
    "#9 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent imperdiet venenatis magna, et fringilla ante.",
    "#10 Etiam ut felis in metus placerat dapibus. Vestibulum fringilla iaculis dui, eu iaculis nulla blandit vel.",
    "#11 Aenean eget tellus vitae sem euismod feugiat. Phasellus lobortis eleifend urna, quis consequat augue semper a. Etiam condimentum cursus venenatis. Mauris id suscipit enim. Phasellus pellentesque luctus condimentum.",
    "#12 Nullam ut lacus tortor. Cras non erat purus. In felis justo, tristique at accumsan nec, lobortis non odio.",
    "#13 Donec fringilla ante mi, a faucibus eros hendrerit non. Aenean elementum enim sed nibh aliquet venenatis. In egestas dignissim nisi lobortis viverra. Cras et quam nunc.",
    "#14 Quisque varius, orci ac blandit commodo, metus dui congue lacus, quis rhoncus quam sapien eu augue. In eu ex et nisl pellentesque congue a eget nisl.",
    "#15 Vestibulum convallis erat ac nunc aliquet, in mattis dolor aliquet. Donec id suscipit nunc, eget gravida nunc. ",
    "#16 Integer ultrices quam mi, ut feugiat felis mattis id. Donec ornare vehicula efficitur. Sed lectus erat, laoreet quis leo vel, volutpat tempor ante.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            SizedBox(
              width: 400,
              child: Column(
                children: [
                  ...list.asMap().entries.map((cardContentIndexed) {
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
            const Spacer(),
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

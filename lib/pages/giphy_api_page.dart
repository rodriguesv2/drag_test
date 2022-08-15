import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';

import '../no_versioned_constants.dart';

class GiphyApiPage extends StatefulWidget {
  const GiphyApiPage({Key? key}) : super(key: key);

  @override
  State<GiphyApiPage> createState() => _GiphyApiPageState();
}

class _GiphyApiPageState extends State<GiphyApiPage> {
  final List<String?> _listUrl = [null, null, null, null];

  Future<GiphyGif?> _searchGif() async {
    return await GiphyPicker.pickGif(
      context: context,
      apiKey: GIPHY_API_KEY,
      fullScreenDialog: false,
      decorator: const GiphyDecorator(
        showAppBar: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste Giphy"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 600,
          child: Column(children: [
            ..._listUrl.asMap().entries.map((entry) {
              return _card(
                entry.value,
                entry.key,
              );
            }).toList(),
          ]),
        ),
      ),
    );
  }

  Widget _card(
    String? imageUrl,
    int index,
  ) {
    return Card(
      color: Colors.green,
      child: Column(
        children: [
          SizedBox(
            width: 500,
            child: imageUrl == null
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Sem imagem carregada",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Image.network(imageUrl),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(12),
            child: FloatingActionButton(
              onPressed: () {
                _searchGif().then((gif) {
                  setState(() {
                    _listUrl[index] = gif?.images.original?.url;
                  });
                });
              },
              child: const Icon(Icons.gif),
            ),
          ),
        ],
      ),
    );
  }
}

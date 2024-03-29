import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';

import '../no_versioned_constants.dart';

class GiphyPage extends StatefulWidget {
  const GiphyPage({Key? key}) : super(key: key);

  @override
  State<GiphyPage> createState() => _GiphyPageState();
}

class _GiphyPageState extends State<GiphyPage> {
  final List<String?> _listUrl = [null, null, null, null];

  Future<GiphyGif?> _searchGif() async {
    return await GiphyPicker.pickGif(
      context: context,
      apiKey: GIPHY_API_KEY,
      fullScreenDialog: false,
      decorator: GiphyDecorator(
        showAppBar: false,
        giphyTheme: Theme.of(context).copyWith(
          scaffoldBackgroundColor: Colors.white30,
          appBarTheme: const AppBarTheme(
            toolbarHeight: 80,
            iconTheme: IconThemeData(
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    print("LOG::: iniciando tela :::");
  }

  @override
  void didUpdateWidget(covariant GiphyPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("LOG::: parent atualizado :::");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste Giphy"),
        backgroundColor: Colors.black38,
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

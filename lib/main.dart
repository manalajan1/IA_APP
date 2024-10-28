import 'package:example/sections/stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:developer';
import 'dart:io'; // Import pour File si nécessaire

void main() {
  // Initialize Gemini SDK with API key
  Gemini.init(apiKey: 'AIzaSyCi0wXYjM6IdAW1vcXvWLVIimcJMaLVCXg');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manal IA',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        cardTheme: CardTheme(color: Colors.blue.shade900),
      ),
      home: const MyHomePage(),
    );
  }
}

class SectionItem {
  final int index;
  final String title;
  final Widget widget;

  SectionItem(this.index, this.title, this.widget);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;
  final gemini = Gemini.instance;

  final _sections = <SectionItem>[
    SectionItem(0, 'Stream text', const SectionTextStreamInput()),
    // SectionItem(1, 'textAndImage', const SectionTextAndImageInput()),
    // SectionItem(2, 'chat', const SectionChat()),
    // SectionItem(3, 'Stream chat', const SectionStreamChat()),
    // SectionItem(4, 'text', const SectionTextInput()),
    // SectionItem(5, 'embedContent', const SectionEmbedContent()),
    // SectionItem(6, 'batchEmbedContents', const SectionBatchEmbedContents()),
    // SectionItem(7, 'response without setState()', const ResponseWidgetSection()),
  ];

  @override
  void initState() {
    super.initState();
    _startGeminiContentStream();
    _useTextAndImage();
    _startChat();
    _countTokens(); // Méthode pour compter les jetons
    _getModelInfo(); // Méthode pour obtenir les informations du modèle
    _listModels(); // Méthode pour lister les modèles
    _embedContent(); // Méthode pour l'intégration de contenu
    _batchEmbedContents(); // Méthode pour l'intégration par lot
    _streamGenerateContentWithSafetySettings(); // Méthode pour les paramètres de sécurité
    _streamGenerateContentWithConfig(); // Méthode pour la configuration de génération
  }

  void _startGeminiContentStream() {
    gemini.streamGenerateContent('Utilizing Google Ads in Flutter').listen((value) {
      print(value.output);  // Handle the streamed content here
    }).onError((e) {
      log('streamGenerateContent exception', error: e);
    });
  }

  void _useTextAndImage() async {
    final file = File('assets/images/test.jpg'); // Chemin de l'image
    if (await file.exists()) {
      try {
        final result = await gemini.textAndImage(
          text: "What is this picture?", // Texte à associer à l'image
          images: [await file.readAsBytes()] // Liste d'images
        );
        log(result?.content?.parts?.last.text ?? '');
      } catch (e) {
        log('textAndImageInput', error: e);
      }
    } else {
      log('File not found: ${file.path}');
    }
  }

  void _startChat() {
    gemini.chat([
      Content(parts: [Parts(text: 'Write the first line of a story about a magic backpack.')], role: 'user'),
      Content(parts: [Parts(text: 'In the bustling city of Meadowbrook, lived a young girl named Sophie. She was a bright and curious soul with an imaginative mind.')], role: 'model'),
      Content(parts: [Parts(text: 'Can you set it in a quiet village in 1600s France?')], role: 'user'),
    ]).then((value) => log(value?.output ?? 'without output'))
      .catchError((e) => log('chat', error: e));
  }

  void _countTokens() {
    gemini.countTokens("Write a story about a magic backpack.")
        .then((value) => print(value ?? 'null')) // Afficher le nombre de jetons
        .catchError((e) => log('countTokens', error: e));
  }

  void _getModelInfo() {
    gemini.info(model: 'gemini-pro')
        .then((info) => print(info)) // Afficher les informations du modèle
        .catchError((e) => log('info', error: e));
  }

  void _listModels() {
    gemini.listModels()
        .then((models) => print(models)) // Afficher la liste des modèles
        .catchError((e) => log('listModels', error: e));
  }

  void _embedContent() {
    gemini.embedContent('text').then((value) {
      print(value); // Afficher les intégrations
    }).catchError((e) => log('embedContent', error: e));
  }

  void _batchEmbedContents() {
    gemini.batchEmbedContents(['text 1', 'text 2']).then((value) {
      print(value); // Afficher les intégrations par lot
    }).catchError((e) => log('batchEmbedContents', error: e));
  }

  void _streamGenerateContentWithSafetySettings() {
    gemini.streamGenerateContent('Utilizing Google Ads in Flutter',
      safetySettings: [
        SafetySetting(
          category: SafetyCategory.harassment,
          threshold: SafetyThreshold.blockLowAndAbove,
        ),
        SafetySetting(
          category: SafetyCategory.hateSpeech,
          threshold: SafetyThreshold.blockOnlyHigh,
        )
      ]).listen((value) {
        // Gérer le contenu généré ici
      }).onError((e) {
        log('streamGenerateContentWithSafetySettings exception', error: e);
      });
  }

  void _streamGenerateContentWithConfig() {
    gemini.streamGenerateContent('Utilizing Google Ads in Flutter',
      generationConfig: GenerationConfig(
        temperature: 0.75,
        maxOutputTokens: 512,
      )).listen((value) {
        // Gérer le contenu généré ici
      }).onError((e) {
        log('streamGenerateContentWithConfig exception', error: e);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 176, 179, 110),
        title: Text(_selectedItem == 0
            ? 'Manal IA, atl-mobile'
            : _sections[_selectedItem].title),
        /*actions: [
          PopupMenuButton<int>(
            initialValue: _selectedItem,
            onSelected: (value) => setState(() => _selectedItem = value),
            itemBuilder: (context) => _sections.map((e) {
              return PopupMenuItem<int>(value: e.index, child: Text(e.title));
            }).toList(),
            child: const Icon(Icons.more_vert_rounded),
          )
        ],*/
      ),
      body:Container()
      /* IndexedStack(
        index: _selectedItem,
        children: _sections.map((e) => e.widget).toList(),
      ),*/
    );
  }
}
// /*  */
import 'package:codium_chat_formatter/chat_processor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController inputTextController = TextEditingController();
  TextEditingController outputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Преобразование текста',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Выравнивание чата Codeium'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              buildConvertButton(),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: buildInputTextField()),
                    const SizedBox(width: 16),
                    Expanded(child: buildOutputTextField()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputTextField() {
    return TextField(
      controller: inputTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Исходный текст',
      ),
      maxLines: null,
    );
  }

  Widget buildOutputTextField() {
    return TextField(
      controller: outputTextController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Преобразованный текст',
      ),
      maxLines: null,
    );
  }

  Widget buildConvertButton() {
    return ElevatedButton(
      onPressed: handleConvertButtonPress,
      child: const Text('Преобразовать'),
    );
  }

  void handleConvertButtonPress() {
    final chatText = inputTextController.text;
    final processed = ChatProcessor().processChat(chatText);
    outputTextController.text = processed;
  }
}

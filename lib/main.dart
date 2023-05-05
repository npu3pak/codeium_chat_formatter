import 'package:flutter/material.dart';
import 'package:codeium_chat_formatter/chat_processor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController outputTextController = TextEditingController();
  final TextEditingController userController =
      TextEditingController(text: 'ES');
  final TextEditingController botController =
      TextEditingController(text: 'avatar');

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
              Row(
                children: [
                  Expanded(child: buildUserTextField()),
                  const SizedBox(width: 16),
                  Expanded(child: buildBotTextField()),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildInputTextField(),
                    const SizedBox(width: 16),
                    buildOutputTextField(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              buildConvertButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserTextField() {
    return TextField(
      controller: userController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Имя пользователя',
      ),
    );
  }

  Widget buildBotTextField() {
    return TextField(
      controller: botController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Имя бота',
      ),
    );
  }

  Widget buildInputTextField() {
    return Expanded(
      child: TextField(
        controller: inputTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Исходный текст',
        ),
        maxLines: null,
      ),
    );
  }

  Widget buildOutputTextField() {
    return Expanded(
      child: TextField(
        controller: outputTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Преобразованный текст',
        ),
        maxLines: null,
      ),
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
    final user = userController.text;
    final bot = botController.text;
    final processed =
        ChatProcessor(userName: user, botName: bot).processChat(chatText);
    outputTextController.text = processed;
  }
}

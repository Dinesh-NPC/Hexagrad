import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final Gemini _gemini = Gemini.instance;
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isLoading = false;
  bool isListening = false;

  String selectedLanguage = 'English';
  final List<String> languages = [
    'English', 'Hindi', 'Tamil', 'Telugu', 'Bengali',
    'Kannada', 'Malayalam', 'Marathi', 'Gujarati', 'Punjabi'
  ];

  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    Gemini.init(apiKey: 'AIzaSyA5KVxZ0w7kCpjanGJKriDS7h0HUl1xbIY'); // Replace with your actual key
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });
        },
        localeId: _getLocaleId(selectedLanguage),
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => isListening = false);
  }

  String _getLocaleId(String lang) {
    switch (lang) {
      case 'Hindi': return 'hi-IN';
      case 'Tamil': return 'ta-IN';
      case 'Telugu': return 'te-IN';
      case 'Bengali': return 'bn-IN';
      case 'Kannada': return 'kn-IN';
      case 'Malayalam': return 'ml-IN';
      case 'Marathi': return 'mr-IN';
      case 'Gujarati': return 'gu-IN';
      case 'Punjabi': return 'pa-IN';
      default: return 'en-IN';
    }
  }

  void _sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    setState(() {
      messages.add({'role': 'user', 'text': userMessage});
      _controller.clear();
      _isLoading = true;
    });

    try {
      final prompt = '''
You are a helpful college guidance assistant. Respond only to questions related to colleges, admissions, exams, career paths, and education. Reply in the same language as the question. Language: $selectedLanguage

User: $userMessage
''';

      final result = await _gemini.text(prompt);

      setState(() {
        messages.add({
          'role': 'bot',
          'text': result?.output ?? 'I apologize, but I could not generate a response.'
        });
      });
    } catch (e) {
      setState(() {
        messages.add({
          'role': 'bot',
          'text': 'Sorry, an error occurred. Please try again later.'
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildMessageBubble(Map<String, String> msg) {
    final isUser = msg['role'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Text(
          msg['text'] ?? '',
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'College Chatbot',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          DropdownButton<String>(
            value: selectedLanguage,
            icon: const Icon(Icons.language, color: Colors.white),
            dropdownColor: Colors.indigo,
            underline: const SizedBox(),
            onChanged: (value) {
              if (value != null) {
                setState(() => selectedLanguage = value);
              }
            },
            items: languages.map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(
                  lang,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(messages[index]);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    isListening ? Icons.mic_off : Icons.mic,
                    color: isListening ? Colors.red : Colors.indigo,
                  ),
                  onPressed: isListening ? _stopListening : _startListening,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: _sendMessage,
                    decoration: InputDecoration(
                      hintText: 'Ask about colleges in $selectedLanguage...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.indigo),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
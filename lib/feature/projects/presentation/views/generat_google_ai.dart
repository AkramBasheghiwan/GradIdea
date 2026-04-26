import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApp extends StatelessWidget {
  const GeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  bool _isLoading = false;

  final String _apiKey = 'AIzaSyAmqZtjZHYAV4Z3HNVwHn60yVNFbkiPBgk';
  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    // تهيئة النموذج عند تشغيل التطبيق
    _model = GenerativeModel(
      model: 'gemini-2.5-flash', // ✅ هذا النموذج مدعوم ومستقر جداً
      apiKey: _apiKey,
    );
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add("أنت: $text");
      _controller.clear();
      _isLoading = true;
    });

    try {
      final content = [Content.text(text)];
      final response = await _model.generateContent(content);

      setState(() {
        _messages.add(
          "جيميناي: ${response.text ?? 'لم يصل رد من الذكاء الاصطناعي'}",
        );
      });
    } catch (e) {
      setState(() {
        _messages.add(
          "خطأ: تعذر الاتصال بـ Gemini. تأكد من المفتاح والإنترنت.",
        );
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تجربة Gemini الذكي ✨')),
      body: Column(
        children: [
          // عرض الرسائل
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index].startsWith("أنت:");
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_messages[index]),
                  ),
                );
              },
            ),
          ),

          if (_isLoading) const LinearProgressIndicator(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'اسأل جيميناي أي شيء...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:graduation_management_idea_system/feature/projects/data/data_source/supabase_upload_project_remote_data_sourcr.dart';

// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class EmbeddingTestApp extends StatelessWidget {
//   const EmbeddingTestApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
//       home: const EmbeddingTestScreen(),
//     );
//   }
// }

// class EmbeddingTestScreen extends StatefulWidget {
//   const EmbeddingTestScreen({super.key});

//   @override
//   State<EmbeddingTestScreen> createState() => _EmbeddingTestScreenState();
// }

// class _EmbeddingTestScreenState extends State<EmbeddingTestScreen> {
//   final TextEditingController _textController = TextEditingController(
//     text: "نظام ذكي لإداه مطعم ",
//   );
//   final SupabaseClient supabase = Supabase.instance.client;

//   // مفتاح الـ API الخاص بك
//   final String _apiKey = 'AIzaSyAmqZtjZHYAV4Z3HNVwHn60yVNFbkiPBgk';

//   bool _isLoading = false;
//   String _resultText = "اضغط على الزر لتحويل النص إلى متجه (Vector)";
//   int _vectorSize = 0; // لعرض عدد الأرقام في المصفوفة

//   Future<void> _generateEmbedding() async {
//     UploadProjectRemoteDataSource remoteDataSource =
//         UploadProjectRemoteDataSourceImpl(supabase: supabase);

//     await remoteDataSource.findSimilarProjects();
//     if (_textController.text.isEmpty) return;

//     setState(() {
//       _isLoading = true;
//       _resultText = "جاري الاتصال بـ Gemini...";
//       _vectorSize = 0;
//     });

//     try {
//       // 1. تهيئة نموذج الـ Embedding (يمكنك هنا تجربة الأسماء)
//       // الأسماء المحتملة: 'gemini-embedding-001' أو 'text-embedding-004'
//       final embeddingModel = GenerativeModel(
//         model:
//             'gemini-embedding-001', // 👈 جرب هذا أولاً، إذا لم يعمل جرب 'gemini-embedding-001'
//         apiKey: _apiKey,
//       );

//       // 2. تجهيز المحتوى
//       final content = Content.text(_textController.text);

//       // 3. استدعاء دالة التحويل (embedContent وليس generateContent)
//       final embeddingResult = await embeddingModel.embedContent(content);

//       // 4. استخراج المصفوفة
//       final vectorArray = embeddingResult.embedding.values;

//       setState(() {
//         _isLoading = false;
//         _vectorSize = vectorArray.length; // عادة يكون 768 رقماً

//         // عرض أول 5 أرقام فقط من المصفوفة كعينة لتجنب تعليق الشاشة
//         final sampleNumbers = vectorArray
//             .take(5)
//             .map((e) => e.toStringAsFixed(4))
//             .join(', ');

//         _resultText =
//             "✅ تم التحويل بنجاح!\n\n"
//             "حجم المصفوفة: $_vectorSize بُعد (Dimension)\n"
//             "عينة من الأرقام:\n[ $sampleNumbers, ... ]";

//         log(
//           "✅ تم التحويل بنجاح!\n\n"
//                   "حجم المصفوفة: $_vectorSize بُعد (Dimension)\n"
//                   "عينة من الأرقام:\n[ $sampleNumbers, ... ]"
//               .toString(),
//         );
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _resultText = "❌ حدث خطأ:\n$e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('اختبار تحويل المتجهات')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _textController,
//               decoration: const InputDecoration(
//                 labelText: 'أدخل نص المشروع',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 2,
//             ),
//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: _isLoading ? null : _generateEmbedding,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.all(16),
//               ),
//               child: _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text(
//                       'تحويل النص إلى أرقام (Embed)',
//                       style: TextStyle(fontSize: 18),
//                     ),
//             ),

//             const SizedBox(height: 30),

//             // صندوق عرض النتيجة
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey[400]!),
//                 ),
//                 child: SingleChildScrollView(
//                   child: SelectableText(
//                     _resultText,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: _resultText.startsWith('❌')
//                           ? Colors.red
//                           : Colors.green[800],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

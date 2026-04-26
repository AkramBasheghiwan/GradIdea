// import 'dart:io';
// import 'package:graduation_management_idea_system/core/error/core/error/exceptions.dart';
// import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// abstract class UploadProjectRemoteDataSource {
//   Future<void> uploadProject(ProjectModel project);
// }

// class UploadProjectRemoteDataSourceImpl
//     implements UploadProjectRemoteDataSource {
//   final FirebaseFirestore firestore;

//   const UploadProjectRemoteDataSourceImpl({required this.firestore});
//   //final FirebaseStorage storage = FirebaseStorage.instance;

//   // final String _apiKey = 'AIzaSyCa_u4WOezdPeCbyTuUd9d8rBjJJTIJcI8';
//   // late final GenerativeModel _embeddingModel;

//   // UploadProjectRemoteDataSourceImpl() {
//   //   _embeddingModel = GenerativeModel(
//   //     model: 'text-embedding-004',
//   //     apiKey: _apiKey,
//   //   );
//   // }

//   @override
//   Future<void> uploadProject(ProjectModel project) async {
//     try {
//       String? fileUrl;

//       // 1. رفع الملف إلى Storage (إذا وجد)
//       if (project.projectFile != null) {
//         final fileName =
//             '\${DateTime.now().millisecondsSinceEpoch}_\${project.projectFile!.path.split(' /
//             ').last}';
//         final ref = storage.ref().child('archive_files/\$fileName');
//         final uploadTask = await ref.putFile(project.projectFile!);
//         fileUrl = await uploadTask.ref.getDownloadURL();
//       }

//       // // 2. توليد الذكاء الاصطناعي (Vector) للاسم والوصف *فقط*!
//       // final textForEmbedding =
//       //     "العنوان: \${project.name}\nالوصف: \${project.description}";
//       // final content = Content.text(textForEmbedding);
//       // final embeddingResult = await _embeddingModel.embedContent(content);
//       // final vectorArray = embeddingResult.embedding.values; // قائمة الـ 768 رقم

//       // // 3. دمج كل شيء في بيانات المستند (Map)
//       final projectData = project.toMap();
//       if (fileUrl != null) {
//         projectData['fileUrl'] = fileUrl; // رابط الملف
//       }

//       // الدالة السحرية: تحويل المصفوفة إلى نوع بيانات (متجه) يفهمه فايرستور
//       projectData['embedding_vector'] = FieldValue.vector(vectorArray);
//       projectData['created_at'] = FieldValue.serverTimestamp();

//       // 4. الحفظ النهائي في الأرشيف ('projects')
//       await firestore.collection('projects').add(projectData);
//     } on FirebaseException catch (e) {
//       if (e.code == 'permission-denied') {
//         throw ServerException(
//           'عذراً، ليس لديك صلاحية (Rules) لرفع هذا المشروع أو الملف كبير جداً.',
//         );
//       } else if (e.code == 'unavailable') {
//         throw ServerException('الخدمة غير متوفرة حالياً، حاول لاحقاً.');
//       } else {
//         throw ServerException(
//           'حدث خطأ غير متوقع في قاعدة البيانات: \${e.message}',
//         );
//       }
//     }
//     // } on GenerativeAIException catch (e) {
//     //   throw GeminiException(
//     //     'فشل الذكاء الاصطناعي في تحليل فكرتك: \${e.message}',
//     //   );
//     // } catch (e) {
//     //   throw NetworkException('تأكد من اتصالك بالإنترنت وحاول مجدداً.');
//     // }
//   }
// }

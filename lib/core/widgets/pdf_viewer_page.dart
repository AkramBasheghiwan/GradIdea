import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_style.dart';

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage({super.key, required this.pdfUrl});

  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        title: Text(
          'عرض الملف',
          style: AppTextStyle.bold(18, color: Colors.white),
        ),
      ),

      body: SfPdfViewer.network(pdfUrl),
    );
  }
}

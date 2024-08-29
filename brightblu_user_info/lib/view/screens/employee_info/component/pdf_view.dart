import 'dart:io';

import 'package:brightblu_user_info/constant/app_string.dart';
import 'package:brightblu_user_info/view/widgets/common_app_bar.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfViewer extends StatefulWidget {
  final String filePath;
  final String? headerTitle;

  const PdfViewer(
      {super.key, required this.filePath, this.headerTitle = "View PDF"});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PDFDocument? document;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      File file = File(widget.filePath);
      PDFDocument doc = await PDFDocument.fromFile(file);

      setState(() {
        document = doc;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: widget.headerTitle.toString(),
          isFromPdfView: widget.headerTitle == "View PDF" ? true : false),
      body: Center(
        child: _isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Loading PDF, please wait..."),
                ],
              )
            : document != null
                ? PDFViewer(document: document!)
                : const Center(
                    child: Text(AppString.noPdfAvailable),
                  ),
      ),
    );
  }
}

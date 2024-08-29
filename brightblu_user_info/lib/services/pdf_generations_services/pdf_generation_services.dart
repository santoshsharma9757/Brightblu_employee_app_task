import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerationService {
  final pw.TextStyle headerStyle = pw.TextStyle(
    fontSize: 24,
    fontWeight: pw.FontWeight.bold,
  );

  final pw.TextStyle sectionStyle = const pw.TextStyle(
    fontSize: 18,
  );

  final pw.TextStyle titleStyle = pw.TextStyle(
    fontSize: 17,
    fontWeight: pw.FontWeight.bold,
  );

  Future<File> generatePersonalInfoPdf({
    required String name,
    required int age,
    required String email,
    required String dob,
    required String gender,
    required String employmentStatus,
    required String address,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Personal Information', style: headerStyle),
            pw.SizedBox(height: 20),
            _buildRow('Name:', name),
            pw.SizedBox(height: 10),
            _buildRow('Age:', '$age'),
            pw.SizedBox(height: 10),
            _buildRow('Email:', email),
            pw.SizedBox(height: 10),
            _buildRow('Date of Birth:', dob),
            pw.SizedBox(height: 10),
            _buildRow('Gender:', gender),
            pw.SizedBox(height: 10),
            _buildRow('Employment Status:', employmentStatus),
            pw.SizedBox(height: 10),
            _buildRow('Address:', address),
          ],
        ),
      ),
    );

    final outputDir = await getTemporaryDirectory();
    final file = File('${outputDir.path}/employee_info.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  pw.Widget _buildRow(String label, String value) {
    return pw.Row(
      crossAxisAlignment:
          pw.CrossAxisAlignment.start, // Align content within row
      children: [
        pw.Text(label, style: titleStyle),
        pw.SizedBox(width: 10),
        pw.Text(value, style: sectionStyle),
      ],
    );
  }
}

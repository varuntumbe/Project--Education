//function is defined which extracts text from pdf
import 'package:pdf_text/pdf_text.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:read_pdf_text/read_pdf_text.dart';

String getTextFromPdf(List<String> pdfFilePaths) {
  String resultString = '';
  for (String pdfFilePath in pdfFilePaths) {
    final PdfDocument document =
        PdfDocument(inputBytes: File(pdfFilePath).readAsBytesSync());

//Extract the text from all the pages. (there is a provision to extract perticular pages ) -> future scope
    String textsExtracted = PdfTextExtractor(document)
        .extractText(startPageIndex: 0, endPageIndex: 500);
    document.dispose();
    resultString += textsExtracted;
    print(resultString);
  }
  return resultString;
}

Future<String> getTextFromPdfv3(String pdfFilePath) async {
  String resultString = '';

  PDFDoc pdfDoc = await PDFDoc.fromPath(pdfFilePath);

//Extract the text from all the pages. (there is a provision to extract perticular pages ) -> future scope
  String textsExtracted = await pdfDoc.text;

  resultString += textsExtracted;

  return resultString;
}

Future<String> getTextFromPdfV2(String pdfFilePath) async {
  String resultString = '';

  try {
    final PdfDocument document =
        PdfDocument(inputBytes: File(pdfFilePath).readAsBytesSync());

//Extract the text from all the pages. (there is a provision to extract perticular pages ) -> future scope
    String textsExtracted = PdfTextExtractor(document).extractText();
    document.dispose();
    resultString += textsExtracted;
  } catch (e) {
    print(e);
  }
  return resultString;
}

//test case function which can be used to test the parallelism of of running the below function.
Future<String> getTextFromPdfV4(String path) async {
  if (path.endsWith('JavaNotesForProfessionals.pdf')) {
    await Future.delayed(Duration(seconds: 2));
    print('came here');
    return 'pdf text extraction complete';
  } else {
    await Future.delayed(Duration(seconds: 10));
    print('another came here');
    return 'image extraction is complete';
  }
}

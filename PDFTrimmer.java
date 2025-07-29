package in.sp.dbcon;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.apache.pdfbox.pdmodel.PDDocument;

public class PDFTrimmer {
	public static byte[] trimPdfToPages(byte[] originalPdf, double percentage) throws IOException {
        try (PDDocument fullDoc = PDDocument.load(originalPdf);
             PDDocument trimmedDoc = new PDDocument();
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {

            int totalPages = fullDoc.getNumberOfPages();
            int pagesToKeep = Math.max(1, (int) Math.ceil(totalPages * percentage));

            for (int i = 0; i < pagesToKeep; i++) {
                trimmedDoc.addPage(fullDoc.getPage(i));
            }

            trimmedDoc.save(out);
            return out.toByteArray();
        }
    }
}

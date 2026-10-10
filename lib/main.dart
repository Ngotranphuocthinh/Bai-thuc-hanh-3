import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradeScreen(),
    );
  }
}

// Bước 2: hàm nhận điểm, trả về xếp loại bằng if / else
String classify(double score) {
  if (score < 0 || score > 10) {
    return 'Không hợp lệ';
  } else if (score >= 8.0) {
    return 'Giỏi';
  } else if (score >= 6.5) {
    return 'Khá';
  } else if (score >= 5.0) {
    return 'Trung bình';
  } else {
    return 'Yếu';
  }
}

// Bước 3: màu chữ chọn bằng if
Color textColorOf(String grade) {
  if (grade == 'Giỏi') {
    return const Color(0xFF2E7D32);
  } else if (grade == 'Khá') {
    return const Color(0xFF1565C0);
  } else if (grade == 'Trung bình') {
    return const Color(0xFFE08A00);
  } else if (grade == 'Yếu') {
    return const Color(0xFFD32F2F);
  } else {
    return const Color(0xFF6B7280);
  }
}

// Màu nền nhạt tương ứng
Color bgColorOf(String grade) {
  if (grade == 'Giỏi') {
    return const Color(0xFFDDF3DF);
  } else if (grade == 'Khá') {
    return const Color(0xFFDDEAFB);
  } else if (grade == 'Trung bình') {
    return const Color(0xFFFFF0D6);
  } else if (grade == 'Yếu') {
    return const Color(0xFFFBE0E0);
  } else {
    return const Color(0xFFEDEFF3);
  }
}

// 9.0 -> "9", 5.5 -> "5.5"
String formatScore(double s) {
  if (s == s.truncateToDouble()) {
    return s.toInt().toString();
  }
  return s.toString();
}

class GradeScreen extends StatelessWidget {
  const GradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Bước 1: biến điểm = 8.5
    const double diem = 8.5;
    final String xepLoai = classify(diem);

    // Bước 4: các điểm kiểm tra thêm
    const List<double> diemKiemTra = [9, 7, 5.5, 3, 11];

    final List<Widget> rows = [];
    for (int i = 0; i < diemKiemTra.length; i++) {
      final double d = diemKiemTra[i];
      final String g = classify(d);

      rows.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: i == diemKiemTra.length - 1
                ? null
                : const Border(
                    bottom: BorderSide(color: Color(0xFFE5E7EB)),
                  ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Điểm ${formatScore(d)}',
                  style: const TextStyle(
                      fontSize: 14, color: Color(0xFF1F2937))),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: bgColorOf(g),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(g,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColorOf(g))),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C4A7C),
        foregroundColor: Colors.white,
        title: const Text('Xếp loại học lực'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thẻ điểm chính
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  const Text('Điểm trung bình',
                      style:
                          TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                  const SizedBox(height: 8),
                  Text(formatScore(diem),
                      style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937))),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: bgColorOf(xepLoai),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      xepLoai,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColorOf(xepLoai)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('KIỂM TRA THÊM',
                style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280))),
            const SizedBox(height: 8),
            // Danh sách kiểm tra thêm
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(children: rows),
            ),
          ],
        ),
      ),
    );
  }
}
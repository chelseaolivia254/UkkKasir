import 'package:flutter/material.dart';

 void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Kasir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Letakkan logo di folder assets dan tambahkan di pubspec.yaml
              height: 30,
            ),
            SizedBox(width: 10),
            Text('Qasir'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Masuk', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Aplikasi Kasir Lengkap dan Terjangkau',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Semudah itu mengelola apa pun jenis usahanya. Karena Qasir bisa melakukan apa saja yang dibutuhkan usahamu.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text('Coba Sekarang'),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text('Jadwalkan Demo'),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/app_preview.png', // Tambahkan gambar aplikasi di folder assets
                  height: 300,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                margin: EdgeInsets.all(0),
                child: ListTile(
                  leading: Icon(Icons.cookie, color: Colors.orange),
                  title: Text(
                    'Kami Menggunakan Cookies',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Website ini menggunakan Cookies untuk meningkatkan pengalaman menjelajah kamu.'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Terima',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

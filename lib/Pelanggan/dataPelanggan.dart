import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_kasir/Pelanggan/dataPelanggan.dart';
import 'package:ukk_kasir/Pelanggan/insert_Pelanggan.dart';

class PelangganBookListPage extends StatefulWidget {
  const PelangganBookListPage({super.key});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<PelangganBookListPage> {
  // Buat variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> pelanggan = [];

  @override
  void initState() {
    super.initState();
    fetchBook();
  }

  Future<void> fetchBook() async {
    final response = await Supabase.instance.client.from('pelanggan').select();

    setState(() {
      pelanggan = List<Map<String, dynamic>>.from(response);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: pelanggan.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pelanggan.length,
              itemBuilder: (context, index) {
                final book = pelanggan[index];
                return Card(
                  color: Colors.blue[50],
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(book['namaPelanggan'] ?? 'namaPelanggan tidak tersedia'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book['alamat'] ?? 'alamat Tidak Tersedia',
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        Text(
                          book['nomorTelepon'] ?? 'nomorTelepon Tidak Tersedia',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async{
                            
                        // Tambahkan logika navigasi ke halaman edit
                          },
                        ),
                        
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async{
                            var hapus =await Supabase.instance.client.from('pelanggan').delete().eq('pelangganid', book['pelangganid']);
                            if (hapus== null) {fetchBook();
                              
                            }
                            // Tambahkan logika hapus buku
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookPage()),
          );
          if (result == true) {
            fetchBook(); // Refresh data jika buku berhasil ditambahkan
          }
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
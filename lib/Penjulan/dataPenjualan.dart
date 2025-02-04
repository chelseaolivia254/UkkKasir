import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_kasir/Penjulan/insert_Penjualan.dart';


class PenjualanBookListPage extends StatefulWidget {
  final int? penjualanid;

   PenjualanBookListPage({super.key, this.penjualanid});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<PenjualanBookListPage> {
  final nmplg = TextEditingController();
  final almt = TextEditingController();
  final nmtlp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // Buat variabel untuk menyimpan daftar buku
  List<Map<String, dynamic>> penjualan = [];

  @override
  void initState() {
    super.initState();
    fetchpenjualan();
  }

  Future<void> fetchpenjualan() async {
    try {
      final response = await Supabase.instance.client.from('penjualan').select();
      setState(() {
        penjualan= response;
        // nmplg.text = response['tanggalPenjualan'] ?? '';
        // almt.text = response['totalHarga'] ?? '';
        // nmtlp.text = response['pelangganid']?.toString() ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error : $e')));
    }
  }

  // Future<void> updatepenjualan() async {
  //   await Supabase.instance.client.from('penjualan').update(
  //     {
  //       'tanggalPenjualan': nmplg.text,
  //       'totalHarga': almt.text,
  //       'pelangganid': nmtlp.text
  //     }
  //   ).eq('pelangganid', widget.penjualanid);

  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  // }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: penjualan.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: penjualan.length,
              itemBuilder: (context, index) {
                final book = penjualan[index];
                return Card(
                  color: Colors.blue[50],
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(book['tanggalPenjualan'] ?? 'tanggalPenjualan tidak tersedia'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                       '${book['totalHarga']}'  ?? 'totalHarga Tidak Tersedia',
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        Text(
                          '${book['pelangganid']}' ?? 'pelanggan Tidak Tersedia',
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
                            if (hapus== null) {fetchpenjualan();
                              
                            }
                            // Tambahkan logika hapus buku
                          },
                        )
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
            MaterialPageRoute(builder: (context) => const AddPenjualanPage()),
          );
          if (result == true) {
            fetchpenjualan(); // Refresh data jika pelanggan berhasil ditambahkan
          }
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
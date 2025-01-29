import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_kasir/main.dart';


class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});
  @override
  _AddBookPageState createState() => _AddBookPageState();
}
class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tanggalPenjualanController = TextEditingController();
  final TextEditingController _totalHargaController = TextEditingController();
  final TextEditingController _pelangganidController = TextEditingController();
  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      // Ambil nilai dari controller
      final tanggalPenjualan = _tanggalPenjualanController.text;
      final totalHarga = _totalHargaController.text;
      final pelangganid = _pelangganidController.text;
      try {
        // Kirim data ke Supabase
        final response = await Supabase.instance.client.from('penjualan').insert({
          'tanggalPenjualan': tanggalPenjualan,
          'totalHarga': totalHarga,
          'pelangganid': pelangganid,
        });
        // Tampilkan pesan berhasil jika response tidak error
        if (response == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Penjualan berhasil ditambahkan!')),
          );
          _tanggalPenjualanController.clear();
          _totalHargaController.clear();
          _pelangganidController.clear();
          Navigator.pop(context, true); // Kembali ke halaman utama
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        }
      } catch (e) {
        // Tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e}')));
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
      }
    }
  }
  @override
  void dispose() {
    _tanggalPenjualanController.dispose();
    _totalHargaController.dispose();
    _pelangganidController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Penjualan Baru'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tanggalPenjualanController,
                decoration: const InputDecoration(
                  labelText: 'tanggalPenjualan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal Penjualan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _totalHargaController,
                decoration: const InputDecoration(
                  labelText: 'totalHarga',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Total Harga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pelangganidController,
                decoration: const InputDecoration(
                  labelText: 'pelanggan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pelanggan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[200],
                ),
                child: const Text('Simpan', style: TextStyle(color: Colors.white)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
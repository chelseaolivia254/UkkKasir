import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_kasir/main.dart';


class AddPelangganPage extends StatefulWidget {
  const AddPelangganPage({super.key});
  @override
  _AddBookPageState createState() => _AddBookPageState();
}
class _AddBookPageState extends State<AddPelangganPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPelangganController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  Future<void> _addBook() async {
    if (_formKey.currentState!.validate()) {
      // Ambil nilai dari controller
      final namaPelanggan = _namaPelangganController.text;
      final alamat = _alamatController.text;
      final nomorTelepon = _nomorTeleponController.text;
      try {
        // Kirim data ke Supabase
        final response = await Supabase.instance.client.from('pelanggan').insert({
          'namaPelanggan': namaPelanggan,
          'alamat': alamat,
          'nomorTelepon': nomorTelepon,
        });
        // Tampilkan pesan berhasil jika response tidak error
        if (response == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pelanggan berhasil ditambahkan!')),
          );
          _namaPelangganController.clear();
          _alamatController.clear();
          _nomorTeleponController.clear();
          Navigator.pop(context, true); // Kembali ke halaman utama
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
        }
      } catch (e) {
        // Tampilkan pesan error
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage()));
      }
    }
  }
  @override
  void dispose() {
    _namaPelangganController.dispose();
    _alamatController.dispose();
    _nomorTeleponController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pelanggan Baru'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaPelangganController,
                decoration: const InputDecoration(
                  labelText: 'namaPelanggan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Pelanggan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'alamat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nomorTeleponController,
                decoration: const InputDecoration(
                  labelText: 'nomorTelepon',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
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
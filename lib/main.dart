import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halaman Kasir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  void _login() {
    setState(() {
      _emailError =
          emailController.text.isEmpty ? 'Email tidak boleh kosong' : null;
      _passwordError = passwordController.text.isEmpty
          ? 'Password tidak boleh kosong'
          : null;
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.brown[100], // Latar belakang coklat muda
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Center(
                child: Image.asset(
                  'assets/images/Kopi.png',
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                errorText: _emailError,
                prefixIcon: Icon(Icons.person), // Ikon orang
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                errorText: _passwordError,
                prefixIcon: Icon(Icons.lock), // Ikon kunci
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final List<Map<String, dynamic>> menu = [
    {'name': 'Dimsum Mentai', 'price': 15000, 'image': 'assets/images/Dimsum Mentai.jpg'},
    {'name': 'Mie Ayam', 'price': 12000, 'image': 'assets/images/Mie Ayam.jpg'},
    {'name': 'Ayam Geprek', 'price': 17000, 'image': 'assets/images/Ayam Geprek.jpg'},
    {'name': 'Cromboloni', 'price': 15000, 'image': 'assets/images/Cromboloni.jpg'},
    {'name': 'Burger', 'price': 17000, 'image': 'assets/images/Burger.jpg'},
    {'name': 'Pizza', 'price': 25000, 'image': 'assets/images/Pizza.jpg'},
    {'name': 'Moci', 'price': 12000, 'image': 'assets/images/Moci.jpg'},
    {'name': 'Americano', 'price': 18000, 'image': 'assets/images/americano.png'},
    {'name': 'Lemon Tea', 'price': 12000, 'image': 'assets/images/lemon_tea.png'},
    {'name': 'Latte', 'price': 20000, 'image': 'assets/images/latte.png'},
    {'name': 'Cappuccino', 'price': 20000, 'image': 'assets/images/cappuccino.png'},
    {'name': 'Macchiato', 'price': 22000, 'image': 'assets/images/macchiato.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Makanan dan Minuman'),
        backgroundColor: Colors.brown[600],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    menu[index]['image'],
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    menu[index]['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Harga: Rp ${menu[index]['price']}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPage(menu[index]),
                        ),
                      );
                    },
                    child: Text('Pesan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[300], // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  final Map<String, dynamic> item;

  OrderPage(this.item);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan ${widget.item['name']}'),
        backgroundColor: Colors.brown[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.item['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Image.asset(
              widget.item['image'],
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Harga: Rp ${widget.item['price']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(
                  '$_quantity',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Konfirmasi Pesanan'),
                    content: Text(
                        'Pesanan: ${widget.item['name']}\nJumlah: $_quantity\nTotal Harga: Rp ${widget.item['price'] * _quantity}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Konfirmasi Pesanan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400], // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

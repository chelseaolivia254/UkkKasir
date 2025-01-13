import 'package:flutter/material.dart';

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
          color: Colors.brown[100],
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
                prefixIcon: Icon(Icons.person),
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
                prefixIcon: Icon(Icons.lock),
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
  final List<Map<String, dynamic>> foodMenu = [
    {'name': 'Dimsum Mentai', 'price': 15000, 'image': 'assets/images/Dimsum Mentai.jpg'},
    {'name': 'Mie Ayam', 'price': 12000, 'image': 'assets/images/Mie Ayam.jpg'},
    {'name': 'Ayam Geprek', 'price': 17000, 'image': 'assets/images/Ayam Geprek.jpg'},
  ];

  final List<Map<String, dynamic>> drinkMenu = [
    {'name': 'Americano', 'price': 18000, 'image': 'assets/images/americano.png'},
    {'name': 'Lemon Tea', 'price': 12000, 'image': 'assets/images/lemon_tea.png'},
    {'name': 'Latte', 'price': 20000, 'image': 'assets/images/latte.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu Makanan dan Minuman'),
          backgroundColor: Colors.brown[600],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fastfood), text: 'Makanan'),
              Tab(icon: Icon(Icons.local_drink), text: 'Minuman'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MenuGrid(menu: foodMenu),
            MenuGrid(menu: drinkMenu),
          ],
        ),
      ),
    );
  }
}

class MenuGrid extends StatelessWidget {
  final List<Map<String, dynamic>> menu;

  MenuGrid({required this.menu});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
            ],
          ),
        );
      },
    );
  }
}

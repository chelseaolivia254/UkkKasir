import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ukk_kasir/Pelanggan/dataPelanggan.dart';
import 'package:ukk_kasir/Penjulan/dataPenjualan.dart';
import 'package:ukk_kasir/tambahproduk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fsibnukgosdpzwielizi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzaWJudWtnb3NkcHp3aWVsaXppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5ODk5MDQsImV4cCI6MjA1MjU2NTkwNH0.rWyjiz7_uVvnrsdUfTG1FSyHqed08Gly8guZEgxn_w4',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halaman Kasir',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
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
      String emailPattern =
          r"^[a-zA-Z0-9]+([._%+-]*[a-zA-Z0-9])*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$";
      RegExp regex = RegExp(emailPattern);

      _emailError =
          emailController.text.isEmpty ? 'Email tidak boleh kosong' : null;

      if (_emailError == null && !regex.hasMatch(emailController.text)) {
        _emailError = 'Format email tidak valid';
      }

      _passwordError = passwordController.text.isEmpty
          ? 'Password tidak boleh kosong'
          : null;
    });

    if (_emailError == null && _passwordError == null) {
      // Simulasi login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[100],
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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('Belum punya akun? Registrasi'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  void _register() {
    setState(() {
      String emailPattern =
          r"^[a-zA-Z0-9]+([._%+-]*[a-zA-Z0-9])*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$";
      RegExp regex = RegExp(emailPattern);

      _emailError =
          emailController.text.isEmpty ? 'Email tidak boleh kosong' : null;

      if (_emailError == null && !regex.hasMatch(emailController.text)) {
        _emailError = 'Format email tidak valid';
      }

      _passwordError = passwordController.text.isEmpty
          ? 'Password tidak boleh kosong'
          : null;

      _confirmPasswordError = confirmPasswordController.text.isEmpty
          ? 'Konfirmasi password tidak boleh kosong'
          : null;

      if (_passwordError == null && _confirmPasswordError == null) {
        if (passwordController.text != confirmPasswordController.text) {
          _confirmPasswordError = 'Password tidak cocok';
        }
      }
    });

    if (_emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Registrasi berhasil!')), // Simpan data jika diperlukan.
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
        backgroundColor: Colors.brown[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                errorText: _emailError,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                errorText: _passwordError,
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Konfirmasi Password',
                border: OutlineInputBorder(),
                errorText: _confirmPasswordError,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // final List<Map<String, dynamic>> foodMenu = [
  //   {
  //     'name': 'Dimsum Mentai',
  //     'price': 20000,
  //     'image': 'assets/images/Dimsum Mentai.jpg'
  //   },
  //   {'name': 'Salmon', 'price': 50000, 'image': 'assets/images/salmon.jpg'},
  //   {
  //     'name': 'Ayam Geprek',
  //     'price': 17000,
  //     'image': 'assets/images/Ayam Geprek.jpg'
  //   },
  //   {'name': 'Burger', 'price': 27000, 'image': 'assets/images/Burger.jpg'},
  //   {'name': 'Moci', 'price': 20000, 'image': 'assets/images/Moci.jpg'},
  //   {'name': 'Pizza', 'price': 40000, 'image': 'assets/images/Pizza.jpg'},
  //   {'name': 'Ramen', 'price': 30000, 'image': 'assets/images/ramen.jpg'},
  //   {
  //     'name': 'Spaghetti',
  //     'price': 30000,
  //     'image': 'assets/images/Spaghetti.jpg'
  //   },
  //   {'name': 'Americano', 'price': 18000, 'icon': Icons.coffee},
  //   {'name': 'Lemon Tea', 'price': 12000, 'icon': Icons.local_cafe},
  //   {'name': 'Latte', 'price': 20000, 'icon': Icons.emoji_food_beverage},
  //   {'name': 'Caramel Coffe', 'price': 20000, 'icon': Icons.coffee},
  // ];
  List<Map<String, dynamic>>? foodMenu;
  final List<Map<String, dynamic>> cart = [];

  fetchProduct() async {
    var response = await Supabase.instance.client.from('produk').select();
    if (response.isNotEmpty) {
      setState(() {
        foodMenu = response;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProduct();
  }

  void _addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add(item);
    });
  }

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(cart[index]['namaproduk']),
              subtitle: Text('Harga: Rp ${cart[index]['harga']}'),
            );
          },
        );
      },
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Menu Makanan dan Minuman'),
            backgroundColor: Colors.brown[600],
            bottom: TabBar(
              tabs: [
                Tab(
                    icon: Icon(
                      Icons.people,
                      color: Colors.white,
                    ),
                    text: 'Pelanggan'),
                Tab(
                  icon: Icon(
                    Icons.inventory,
                    color: Colors.white,
                  ),
                  text: 'Produk',
                ),
                Tab(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    text: 'Penjualan'),
                Tab(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                  text: 'Detail Penjualan',
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: _showCart,
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.brown[600],
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profil'),
                  onTap: () {
                    // Navigate to profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: _logout,
                ),
              ],
            ),
          ),
          body: foodMenu == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Selamat datang di menu KopiShop kami!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          PelangganBookListPage(), // Aliased class from Pelanggan
                          MenuGrid(
                              menu: foodMenu!,
                              useIcon: false,
                              addToCart: _addToCart),
                          PenjualanBookListPage(),
                          Center() // Aliased class from Penjualan
                        ],
                      ),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProductPage()));
              if (result == true) {
                fetchProduct();
              }
            },
            child: Icon(Icons.add),
          )),
    );
  }
}

class MenuGrid extends StatelessWidget {
  final List<Map<String, dynamic>> menu;
  final bool useIcon;
  final Function(Map<String, dynamic>) addToCart;

  MenuGrid(
      {required this.menu, required this.useIcon, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.5,
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
                if (useIcon)
                  Expanded(
                    child: Icon(
                      menu[index]['icon'],
                      size: 80,
                      color: Colors.brown,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      menu[index]['namaproduk'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Harga: Rp ${menu[index]['harga']}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.brown,
                        iconSize: 24.0,
                        onPressed: () => addToCart(menu[index]),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        iconSize: 24.0,
                        onPressed: () {
                          // Logika untuk mengedit produk
                          // editProduct(menu[index]);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Text('Halaman Profil'),
      ),
    );
  }
}

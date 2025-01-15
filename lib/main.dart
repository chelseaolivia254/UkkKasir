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
    // Email validation using regular expression
    String emailPattern =
        r"^[a-zA-Z0-9]+([._%+-]*[a-zA-Z0-9])*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$";
    RegExp regex = RegExp(emailPattern);

    _emailError =
        emailController.text.isEmpty ? 'Email tidak boleh kosong' : null;

    // Check if email format is correct
    if (_emailError == null && !regex.hasMatch(emailController.text)) {
      _emailError = 'Format email tidak valid';
    }

    _passwordError = passwordController.text.isEmpty
        ? 'Password tidak boleh kosong'
        : null;
  });

  // Proceed if there are no errors
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
  final List<Map<String, dynamic>> foodMenu = [
    {'name': 'Dimsum Mentai','price': 15000,'image': 'assets/images/Dimsum Mentai.jpg'},
    {'name': 'Mie Ayam', 'price': 12000, 'image': 'assets/images/Mie Ayam.jpg'},
    {'name': 'Ayam Geprek','price': 17000,'image': 'assets/images/Ayam Geprek.jpg'},
    {'name': 'Burger', 'price': 17000, 'image': 'assets/images/Burger.jpg'},
    {'name': 'Moci', 'price': 17000, 'image': 'assets/images/Moci.jpg'},
    {'name': 'Pizza', 'price': 17000, 'image': 'assets/images/Pizza.jpg'},
  ];

  final List<Map<String, dynamic>> drinkMenu = [
    {'name': 'Americano', 'price': 18000, 'icon': Icons.coffee},
    {'name': 'Lemon Tea', 'price': 12000, 'icon': Icons.local_cafe},
    {'name': 'Latte', 'price': 20000, 'icon': Icons.emoji_food_beverage},
    {'name': 'Caramel Coffe', 'price': 20000, 'icon': Icons.coffee},
  ];

  final List<Map<String, dynamic>> cart = [];

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
              title: Text(cart[index]['name']),
              subtitle: Text('Harga: Rp ${cart[index]['price']}'),
            );
          },
        );
      },
    );
  }

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
              Tab(icon: Icon(Icons.fastfood, color: Colors.white,), text: 'Makanan',),
              Tab(icon: Icon(Icons.local_drink, color: Colors.white,), text: 'Minuman'),
              
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: _showCart,
            ),
          ],
        ),
        body: Column(
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
                  MenuGrid(
                      menu: foodMenu, useIcon: false, addToCart: _addToCart),
                  MenuGrid(
                      menu: drinkMenu, useIcon: true, addToCart: _addToCart),
                ],
              ),
            ),
          ],
        ),
      ),
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
              if (useIcon)
                Expanded(
                  child: Icon(
                    menu[index]['icon'],
                    size: 80,
                    color: Colors.brown,
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    menu[index]['image'],
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  menu[index]['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Harga: Rp ${menu[index]['price']}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.brown,
                  iconSize: 24.0, // Adjust the size to your preference
                  onPressed: () => addToCart(menu[index]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

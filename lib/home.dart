import 'package:flutter/material.dart';

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
              Tab(icon: Icon(Icons.fastfood, color: Colors.white), text: 'Makanan'),
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

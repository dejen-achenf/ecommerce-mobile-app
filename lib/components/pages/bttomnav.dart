import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce2/components/pages/order.dart';
import 'package:ecommerce2/components/pages/menu.dart';
import 'package:ecommerce2/components/pages/profile.dart';

class Buttomnav extends StatefulWidget {
  const Buttomnav({super.key});

  @override
  State<Buttomnav> createState() => _ButtomnavState();
}

class _ButtomnavState extends State<Buttomnav> {
  late List<Widget> pages;
  late Menu menu;
  late Order order;
  late Profile profile;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    menu = Menu();
    order = Order();
    profile = Profile();
    pages = [menu, order, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          animationDuration: Duration(microseconds: 50),
          backgroundColor: const Color.fromARGB(211, 230, 224, 224),
          color: Colors.black,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outlined,
              color: Colors.white,
            )
          ]),
      body: pages[currentIndex],
    );
  }
}

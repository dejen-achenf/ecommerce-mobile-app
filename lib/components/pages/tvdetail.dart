import 'package:ecommerce2/components/login.dart';
import 'package:flutter/material.dart';

class Tvdetail extends StatelessWidget {
  const Tvdetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all()),
                      child: Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 136, 135, 130)),
                child: Image.asset(
                  'images/tv.jpg',
                  height: 380,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  color: const Color.fromARGB(255, 204, 200, 200)
                      .withOpacity(0.2), // Add color overlay
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Television',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$900 ',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    'Detail',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Television, or TV, is a system for sending moving pictures and sound from one place to another. It is one of the most important and popular forms of communication. TV programs provide news, information, and entertainment to people all over the world',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                  padding: EdgeInsets.all(3),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 91, 7),
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(left: 15),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

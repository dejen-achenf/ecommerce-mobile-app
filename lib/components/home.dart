import 'package:ecommerce2/components/pages/headphonedetail.dart';
import 'package:ecommerce2/components/pages/laptopdetail.dart';
import 'package:ecommerce2/components/pages/tvdetail.dart';
import 'package:ecommerce2/components/pages/watchdetail.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    'images/headphone1.jpg',
    'images/laptop.jpg',
    'images/tv.jpg',
    'images/watch.jpg'
  ];
  String? username = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double w = screenSize.width;
    final double h = screenSize.height;
    final double scale = (w / 375).clamp(0.8, 1.4);
    final double horizontalGutter = (w * 0.04).clamp(10, 20);
    final double verticalGutter = (h * 0.02).clamp(10, 30);
    final double avatarSize = (w * 0.14).clamp(40, 64);
    final double categoryBoxHeight = (h * 0.14).clamp(80, 140);
    final double categoryBoxWidth = (w * 0.22).clamp(70, 120);
    final double categoryTileWidth = (w * 0.28).clamp(90, 160);
    final double productCardWidth = (w * 0.52).clamp(180, 260);
    final double productCardHeight = (h * 0.45).clamp(260, 360);
    final bool isWide = w >= 900;
    final double maxContentWidth = 1200;

    return Scaffold(
      backgroundColor: Color.fromARGB(211, 230, 224, 224),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(211, 230, 224, 224)),
              child: Column(
                children: [
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: verticalGutter,
                        left: horizontalGutter,
                        right: horizontalGutter * 0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hey, $username',
                          style: TextStyle(
                              fontSize: 30 * scale,
                              fontWeight: FontWeight.bold),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(avatarSize),
                          child: Image.asset(
                            'images/boy.jpg',
                            width: avatarSize,
                            height: avatarSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '   Good Morning',
                        style: TextStyle(
                            fontSize: 19 * scale,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: verticalGutter,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: horizontalGutter, right: horizontalGutter),
                    padding: EdgeInsets.all(8 * scale),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search_outlined),
                          hintText: ' search products',
                          hintStyle: TextStyle(fontSize: 20 * scale)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: horizontalGutter * 0.7,
                        right: horizontalGutter * 0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Catagories',
                          style: TextStyle(
                              fontSize: 22 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 19 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: verticalGutter * 0.7,
                  ),
                  if (!isWide)
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: horizontalGutter * 0.7),
                          height: categoryBoxHeight,
                          width: categoryBoxWidth,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              'All',
                              style: TextStyle(
                                  fontSize: 30 * scale, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                  right: horizontalGutter,
                                  left: horizontalGutter * 0.7),
                              height: categoryBoxHeight + 10,
                              decoration: BoxDecoration(),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: categoryTileWidth,
                                    child: CatagoryTile(
                                      image: categories[index],
                                      tileWidth: categoryTileWidth,
                                      scale: scale,
                                    ),
                                  );
                                },
                              )),
                        ),
                      ],
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(
                          left: horizontalGutter * 0.7,
                          right: horizontalGutter * 0.7),
                      child: Wrap(
                        spacing: horizontalGutter,
                        runSpacing: verticalGutter * 0.6,
                        children: [
                          Container(
                            height: categoryBoxHeight,
                            width: (w * 0.1).clamp(90, 140),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'All',
                                style: TextStyle(
                                    fontSize: 26 * scale, color: Colors.white),
                              ),
                            ),
                          ),
                          ...categories.map((img) => SizedBox(
                                width: (w * 0.14).clamp(120, 180),
                                child: CatagoryTile(
                                  image: img,
                                  tileWidth: (w * 0.14).clamp(120, 180),
                                  scale: scale,
                                ),
                              ))
                        ],
                      ),
                    ),
                  SizedBox(
                    height: verticalGutter,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: horizontalGutter * 0.7,
                        right: horizontalGutter * 0.7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Products',
                          style: TextStyle(
                              fontSize: 22 * scale,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 19 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: verticalGutter * 0.8,
                  ),
                  if (!isWide)
                    Container(
                      margin: EdgeInsets.only(left: horizontalGutter),
                      height: productCardHeight * 0.97,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Headphonedetail()),
                                  );
                                },
                                child: Container(
                                  height: productCardHeight,
                                  width: productCardWidth,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'images/headphone1.jpg',
                                        height: productCardHeight * 0.68,
                                        width: productCardWidth * 0.7,
                                      ),
                                      SizedBox(
                                        height: verticalGutter * 0.5,
                                      ),
                                      Text(
                                        'Headphone',
                                        style: TextStyle(
                                            fontSize: 22 * scale,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: verticalGutter * 0.6,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '     \$100',
                                            style: TextStyle(
                                                fontSize: 22 * scale,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                          SizedBox(
                                            width: productCardWidth * 0.4,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 30 * scale,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: horizontalGutter,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Watchdetail()),
                              );
                            },
                            child: Container(
                              height: productCardHeight * 0.9,
                              width: productCardWidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/watch.jpg',
                                    height: productCardHeight * 0.62,
                                    width: productCardWidth * 0.7,
                                  ),
                                  SizedBox(
                                    height: verticalGutter * 0.5,
                                  ),
                                  Text(
                                    'Apple watch',
                                    style: TextStyle(
                                        fontSize: 22 * scale,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: verticalGutter * 0.6,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '     \$300',
                                        style: TextStyle(
                                            fontSize: 22 * scale,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                        width: productCardWidth * 0.4,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30 * scale,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tvdetail()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: horizontalGutter,
                                  right: horizontalGutter * 0.7),
                              height: productCardHeight * 0.9,
                              width: productCardWidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/tv.jpg',
                                    height: productCardHeight * 0.62,
                                    width: productCardWidth * 0.7,
                                  ),
                                  SizedBox(
                                    height: verticalGutter * 0.5,
                                  ),
                                  Text(
                                    'Sun set tv',
                                    style: TextStyle(
                                        fontSize: 22 * scale,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: verticalGutter * 0.6,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '     \$300',
                                        style: TextStyle(
                                            fontSize: 22 * scale,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                        width: productCardWidth * 0.4,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30 * scale,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Laptopdetail()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: horizontalGutter,
                                  right: horizontalGutter * 0.7),
                              height: productCardHeight * 0.9,
                              width: productCardWidth,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/laptop.jpg',
                                    height: productCardHeight * 0.62,
                                    width: productCardWidth * 0.7,
                                  ),
                                  SizedBox(
                                    height: verticalGutter * 0.5,
                                  ),
                                  Text(
                                    'Hp laptop',
                                    style: TextStyle(
                                        fontSize: 22 * scale,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: verticalGutter * 0.6,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '     \$3000',
                                        style: TextStyle(
                                            fontSize: 22 * scale,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      SizedBox(
                                        width: productCardWidth * 0.4,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalGutter),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: horizontalGutter,
                        mainAxisSpacing: verticalGutter * 0.8,
                        crossAxisCount:
                            (w / (productCardWidth + horizontalGutter))
                                .floor()
                                .clamp(2, 4),
                        childAspectRatio:
                            (productCardWidth / productCardHeight),
                        children: [
                          _ProductCard(
                            imagePath: 'images/headphone1.jpg',
                            title: 'Headphone',
                            priceText: '\$100',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Headphonedetail()));
                            },
                            width: productCardWidth,
                            height: productCardHeight,
                            scale: scale,
                            trailingAdd: true,
                          ),
                          _ProductCard(
                            imagePath: 'images/watch.jpg',
                            title: 'Apple watch',
                            priceText: '\$300',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Watchdetail()));
                            },
                            width: productCardWidth,
                            height: productCardHeight,
                            scale: scale,
                            trailingAdd: true,
                          ),
                          _ProductCard(
                            imagePath: 'images/tv.jpg',
                            title: 'Sun set tv',
                            priceText: '\$300',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Tvdetail()));
                            },
                            width: productCardWidth,
                            height: productCardHeight,
                            scale: scale,
                            trailingAdd: true,
                          ),
                          _ProductCard(
                            imagePath: 'images/laptop.jpg',
                            title: 'Hp laptop',
                            priceText: '\$3000',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Laptopdetail()));
                            },
                            width: productCardWidth,
                            height: productCardHeight,
                            scale: scale,
                            trailingAdd: false,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.imagePath,
    required this.title,
    required this.priceText,
    required this.onTap,
    required this.width,
    required this.height,
    required this.scale,
    this.trailingAdd = true,
  });

  final String imagePath;
  final String title;
  final String priceText;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double scale;
  final bool trailingAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: height * 0.62,
              width: width * 0.7,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10 * scale),
            Text(
              title,
              style: TextStyle(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 12 * scale),
            Row(
              children: [
                Text(
                  '     $priceText',
                  style: TextStyle(
                      fontSize: 22 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Spacer(),
                if (trailingAdd)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child:
                        Icon(Icons.add, color: Colors.white, size: 30 * scale),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CatagoryTile extends StatelessWidget {
  CatagoryTile(
      {required this.image, required this.tileWidth, required this.scale});
  final String image;
  final double tileWidth;
  final double scale;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double h = screenSize.height;
    final double tileImageHeight = (h * 0.11).clamp(70, 110);
    final double tileImageWidth = tileWidth * 0.65;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8 * scale),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              height: tileImageHeight,
              width: tileImageWidth,
              fit: BoxFit.cover,
            ),
          ),
          Icon(Icons.arrow_forward, size: 24 * scale, color: Colors.black)
        ],
      ),
    );
  }
}

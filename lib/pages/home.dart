import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 40),
        child: Column(
          children: [
            // Top Row with Logo and Profile Image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/kupatext.png",
                      height: 50,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "order your favourite food!",
                      style: Fonthelper.mediumTextstyle(font: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/images/boy.png",
                      height: 70,
                      width: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            // Search Bar
            Fonthelper.SearchBar(),
            SizedBox(height: 15),
            // Horizontal Category List
            Container(
              height: 40,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Foodtile")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: const Color.fromARGB(255, 241, 1, 1),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No data found"));
                  }

                  // ListView.builder for categories
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final title = doc["title"] ?? "No Title";
                      return CategoryTile(name: title);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateless CategoryTile
class CategoryTile extends StatelessWidget {
  final String name;

  const CategoryTile({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 241, 1, 1),
      ),
      child: Center(
        child: Text(
          name,
          style: Fonthelper.mediumTextstyle(color: Colors.white),
        ),
      ),
    );
  }
}

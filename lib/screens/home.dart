import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_signup/widgets/custom_scaffold.dart';
import 'package:login_signup/pages/fastfood.dart';
import 'package:login_signup/pages/tiffins.dart';
import 'package:login_signup/pages/jucies.dart';
import 'package:login_signup/pages/panipuri.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> loadItems() async {
      String dataString = await DefaultAssetBundle.of(context)
          .loadString('assets/data.json');
      List<dynamic> jsonList = jsonDecode(dataString);
      return List<Map<String, dynamic>>.from(jsonList);
    }

    Widget buildItem(Map<String, dynamic> item, BuildContext context) {
      Widget navigateToPage(String page) {
        switch (page) {
          case 'FastFoodPage':
            return FastFoodPage();
          case 'TiffinsPage':
            return const TiffinsPage();
          case 'JuicePage':
            return const JuicesPage();
          case 'PaniPuriPage':
            return const PaniPuriPage();
          default:
            return const Center(child: Text("Page not found"));
        }
      }

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateToPage(item['placePage'])),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
                child: Image.asset(
                  item['placeImage'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                item['placeName'],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    return CustomScaffold(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items available'));
          }

          List<Map<String, dynamic>> items = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "CampusBite",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return buildItem(items[index], context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
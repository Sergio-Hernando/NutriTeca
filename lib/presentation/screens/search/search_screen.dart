import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/presentation/screens/search/widgets/product_card.dart';
import 'package:food_macros/presentation/screens/search/widgets/search_bar.dart';
import 'package:food_macros/presentation/widgets/app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void initState() {
    super.initState();
    _foundUsers = _allUsers;
  }

  void _updateResults(List<Map<String, dynamic>> results) {
    setState(() {
      _foundUsers = results;
    });
  }

  void _onPressed(int id) {
    // Define your action when the icon is pressed
    print('Icon pressed for user ID: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: AppColors.foreground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomSearchBar(
                    allItems: _allUsers,
                    onResults: _updateResults,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune),
                  iconSize: AppTheme.titleFontSize,
                ),
              ],
            ),
          ),
          Expanded(
            child: _foundUsers.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _onPressed(_foundUsers[index]['id']),
                        child: CustomCard(
                          imagePath:
                              'assets/images/E202.png', // Replace with actual image paths
                          text: _foundUsers[index]['name'],
                          icon: Icons.chevron_right,
                        ),
                      ),
                    ),
                  )
                : Text(
                    'No results found',
                    style: AppTheme.bodyTextStyle
                        .copyWith(color: AppColors.secondary),
                  ),
          ),
        ],
      ),
    );
  }
}

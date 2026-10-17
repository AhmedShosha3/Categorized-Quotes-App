import 'package:final_project/data/categories.dart';
import 'package:final_project/pages/category_page.dart';
import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Quotes App',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: const [ThemeToggleButton()],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                for (var i = 0; i < categories.length; i++)
                  _CategoryTile(index: i),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final category = categories[index];
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => CategoryPage(index: index)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 40, color: scheme.onPrimary),
            const SizedBox(height: 8),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: scheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

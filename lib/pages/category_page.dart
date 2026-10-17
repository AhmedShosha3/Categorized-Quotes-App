import 'package:final_project/data/categories.dart';
import 'package:final_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// One page for every category; light/dark is handled by the theme.
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final category = categories[index];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final image = isDark ? category.darkImage : category.lightImage;
    final hasNext = index < categories.length - 1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home_sharp, size: 30),
          tooltip: 'Home',
          // Go back to the first route instead of stacking a new home page.
          onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
        ),
        title: Text(
          '${category.title} Page',
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        actions: const [ThemeToggleButton()],
      ),
      floatingActionButton: hasNext
          ? FloatingActionButton(
              tooltip: 'Next Page',
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => CategoryPage(index: index + 1),
                ),
              ),
              child: const Icon(Icons.arrow_forward),
            )
          : null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (image != null)
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => const SizedBox.shrink(),
            ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 90),
                itemCount: category.quotes.length,
                itemBuilder: (context, i) => _QuoteCard(
                  text: category.quotes[i],
                  fontSize: category.fontSize,
                  useCustomFont: category.useCustomFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({
    required this.text,
    required this.fontSize,
    required this.useCustomFont,
  });

  final String text;
  final double fontSize;
  final bool useCustomFont;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Quote copied'),
          duration: Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: scheme.surface.withOpacity(0.92),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
        child: Column(
          children: [
            // Arabic content: lay out right-to-left so punctuation lands correctly.
            Directionality(
              textDirection: TextDirection.rtl,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: useCustomFont ? 'myfont' : null,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                tooltip: 'Copy',
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.copy, size: 18),
                onPressed: () => _copy(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

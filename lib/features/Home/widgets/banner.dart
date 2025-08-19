import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        // Responsive font scaling but with limits
        double scale(double base, {double min = 12, double max = 22}) {
          return (base * maxWidth / 400).clamp(min, max);
        }

        return Container(
          padding: EdgeInsets.all(maxWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text content
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shop with us!",
                      style: TextStyle(
                        fontSize: scale(14), // auto scales
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Get 40% Off for all items",
                      style: TextStyle(
                        fontSize: scale(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Shop Now →",
                      style: TextStyle(
                        fontSize: scale(14),
                        fontWeight: FontWeight.w600,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Image area (auto resizes)
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1, // keeps square ratio
                  child: Image.network(
                    "",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

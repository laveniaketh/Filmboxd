import 'package:flutter/material.dart';

class MovieActionsBottomSheet extends StatelessWidget {
  final Function(int)? onRatingSelected;

  const MovieActionsBottomSheet({super.key, this.onRatingSelected});

  static void show(BuildContext context, {Function(int)? onRatingSelected}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return MovieActionsBottomSheet(onRatingSelected: onRatingSelected);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionItem(
                context,
                icon: 'images/moviepage/watch.png',
                label: 'Watch',
              ),
              _buildActionItem(
                context,
                icon: 'images/moviepage/like.png',
                label: 'Like',
              ),
              _buildActionItem(
                context,
                icon: 'images/moviepage/watchlist.png',
                label: 'Watchlist',
              ),
            ],
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(height: 8),
          const Text(
            'Rate',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     5,
          //     (index) => GestureDetector(
          //       onTap: () {
          //         if (onRatingSelected != null) {
          //           onRatingSelected!(index + 1);
          //         }
          //       },
          //       child: ImageIcon(
          //         AssetImage('images/homepage/star.png'),
          //         size: 30,
          //         color: index < 5 ? Colors.yellow : Colors.grey, // Example rating logic
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            title: Center(
              child: Text(
                'Add Review',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            title: Center(
              child: Text(
                'Add to Lists',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F1516), // Black
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Done',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, {required String icon, required String label}) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          ImageIcon(
            AssetImage(icon),
            size: 30,
            color: const Color(0xFFD9D9D9),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF1F1516),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

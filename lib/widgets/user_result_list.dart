import 'package:flutter/material.dart';
import 'user_result_item_widget.dart';

class UserResultList extends StatefulWidget {
  static final GlobalKey<_UserResultListState> _key =
      GlobalKey<_UserResultListState>();

  static void updateResults(List<Map<String, String>> results) {
    _key.currentState?.updateResults(results);
  }

  const UserResultList({super.key});

  @override
  _UserResultListState createState() => _UserResultListState();
}

class _UserResultListState extends State<UserResultList> {
  List<Map<String, String>> _results = [];

  void updateResults(List<Map<String, String>> results) {
    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final user = _results[index];
        return UserResultItemWidget(
          username: user['username'] ?? '',
          name: user['name'] ?? '',
          profileImage: user['profileImage'],
        );
      },
    );
  }
}

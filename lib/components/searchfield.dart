import 'package:filmboxd/widgets/movie_result_list.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Future<List<Map<String, String>>> Function(String) onSearch;

  const SearchField({super.key, required this.onSearch});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch() async {
    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      final results = await widget.onSearch(query);
      MovieResultList.updateResults(results);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onSubmitted: (_) => _handleSearch(),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0XFFD9D9D9),
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search',
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.grey[400],
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset('images/searchpage/search-dark.png',
                width: 32, height: 32),
          ),
          suffixIcon: _isFocused
              ? GestureDetector(
                  onTap: () {
                    _controller.clear();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('images/searchpage/clear.png',
                        width: 32, height: 32),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF1F1516),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

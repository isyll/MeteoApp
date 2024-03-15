import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meteo_app/config/app_colors.dart';
import 'package:meteo_app/config/theme_config.dart';
import 'package:meteo_app/screens/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meteo_app/services/api_service.dart';

void main() {
  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  bool _isSearchOpened = false;
  bool _notFound = false;

  final TextEditingController _controller = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Application Météo',
        theme: ThemeConfig.appTheme,
        home: Scaffold(
          appBar: _isSearchOpened
              ? _buildSearchAppBar()
              : AppBar(
                  backgroundColor: AppColors.primary,
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _isSearchOpened = !_isSearchOpened;
                          });
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 50,
                        ))
                  ],
                ),
          body: Stack(
            children: [
              HomeScreen(city: _searchText),
              if (_isSearchOpened)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearchOpened = false;
                    });
                  },
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              if (_isSearchOpened)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    minLines: 1,
                    maxLines: 1,
                    controller: _controller,
                    onSubmitted: (value) {
                      _handleSubmit(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Rechercher...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              if (_notFound)
                Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 14, right: 14),
                    child: Center(child: _notFoundResponse()))
            ],
          ),
        ));
  }

  Widget _notFoundResponse() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _notFound = false;
        });
      }
    });

    return Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: _notFound,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.64),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Text('Ville non trouvé',
                style: TextStyle(fontSize: 46, color: Colors.white)),
          ),
        ));
  }

  void _handleSubmit(String value) async {
    _controller.clear();
    setState(() {
      _searchText = '';
      _notFound = false;
      _isSearchOpened = false;
    });

    try {
      var response = await ApiService.searchCity(value);
      if (response.statusCode == 200) {
        setState(() {
          _searchText = value;
        });
      } else {
        setState(() {
          _notFound = true;
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error $error');
      }
    }
  }

  PreferredSizeWidget _buildSearchAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(0.0),
      child: Stack(
        children: [
          Container(
            height: 56.0,
            color: AppColors.primary,
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}

/*class _SearchBar extends StatelessWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
        color: AppColors.primary,
        width: width,
        child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 54,
              ),
            )));
  }
}*/

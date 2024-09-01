import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wetter_app/src/features/weather/application/get_highlighted_textspans.dart';
import 'package:wetter_app/src/features/weather/application/search_for_places.dart';
import 'package:wetter_app/src/features/weather/data/places.dart';
import 'package:wetter_app/src/features/weather/presentation/weather_screen.dart';

// ABSTAND OBENNNNN
// KLAVYE ACILMIYOR

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Map<String, List<String>> _suggestions = {};
  bool _isSearching = false;

  late AnimationController _animationController;
  late Animation<Offset> _buttonAnimation;

  static const platform = MethodChannel('com.example.speech');

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _buttonAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _searchFocusNode.addListener(() {
      setState(() {
        if (_isSearching) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    });
  }

  void _onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions.clear();
      });
      return;
    }

    try {
      final suggestions = await searchForPlaces(query);
      setState(() {
        _suggestions = suggestions;
      });
    } catch (e) {
      setState(() {
        _suggestions.clear();
      });
    }
  }

  Future<void> _startSpeechRecognition() async {
    try {
      final String result =
          await platform.invokeMethod('startSpeechRecognition');
      _searchController.text = result;
    } on PlatformException catch (e) {
      print("Failed to start speech recognition: '${e.message}'.");
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 55,
            left: 13,
            right: 13,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: _isSearching ? -50 : 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _isSearching ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: SFIcon(
                        SFIcons.sf_ellipsis_circle,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: _isSearching ? -30 : 40,
                left: 0,
                child: AnimatedOpacity(
                  opacity: _isSearching ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 28,
                      child: Text(
                        "Wetter",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            height: 0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: _isSearching ? 0 : 85,
                left: 0,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _isSearching
                          ? MediaQuery.of(context).size.width * 0.7
                          : MediaQuery.of(context).size.width - 26,
                      height: 30,
                      child: TextField(
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        focusNode: _searchFocusNode,
                        onSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        cursorColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                        onChanged: _onSearchChanged,
                        keyboardType: TextInputType.text,
                        onTap: () {
                          _isSearching = true;
                        },
                        keyboardAppearance: Brightness.dark,
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(top: 6.0, left: 6),
                            child: SFIcon(
                              SFIcons.sf_magnifyingglass,
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                          prefixIconConstraints:
                              const BoxConstraints(minHeight: 30, minWidth: 30),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                          hintText: "Stadt oder Flughafen suchen",
                          hintStyle: const TextStyle(
                              color: Colors.white54, fontSize: 13),
                          suffixIconConstraints:
                              const BoxConstraints(minHeight: 30, minWidth: 30),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _searchController.clear();
                                      _onSearchChanged('');
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 6.0, left: 6),
                                    child: SFIcon(
                                      SFIcons.sf_xmark_circle_fill,
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: _startSpeechRecognition,
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 6.0, left: 6),
                                    child: SFIcon(
                                      SFIcons.sf_mic_fill,
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                          filled: true,
                          fillColor: Colors.white10,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    if (_isSearching)
                      SlideTransition(
                        position: _buttonAnimation,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _isSearching = false;
                              _searchController.clear();
                              _suggestions.clear();
                            });
                          },
                          child: const SizedBox(
                            width: 90,
                            child: Text(
                              "Abbrechen",
                              textAlign: TextAlign.end,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: _isSearching ? 40 : 130,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 185,
                  width: MediaQuery.of(context).size.width - 16,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 100,
                              child: Slidable(
                                closeOnScroll: true,
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                  extentRatio: 0.19,
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {
                                    setState(() {});
                                  }),
                                  children: [
                                    CustomSlidableAction(
                                      onPressed: (_) {
                                        setState(() {});
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.only(
                                          left: 25, right: double.infinity),
                                      borderRadius: BorderRadius.circular(15),
                                      child: const SFIcon(
                                        SFIcons.sf_trash_fill,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return const WeatherScreen();
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/wolken_card.jpeg"),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "Mein Standort",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (_isSearching)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: _isSearching ? 1.0 : 0,
                            child: Container(
                              height: 1000,
                              width: 600,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                      if (_suggestions.isNotEmpty)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            color: Colors.black,
                            height: _searchFocusNode.hasFocus ? 421 : 770,
                            width: MediaQuery.of(context).size.width - 26,
                            child: ListView.builder(
                              itemCount: _suggestions.length,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                final placeName =
                                    _suggestions.keys.elementAt(index);
                                final placeDetails = _suggestions[placeName]!;
                                final admin1 = placeDetails[0];
                                final country = placeDetails[1];

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: ListTile(
                                    minTileHeight: 37,
                                    dense: true,
                                    title: RichText(
                                      text: TextSpan(
                                        children: getHighlightedTextSpans(
                                            "$placeName, $admin1, $country",
                                            _searchController.text),
                                      ),
                                    ),
                                    onTap: () {
                                      // final latitude =
                                      //     double.tryParse(placeDetails[2]);
                                      // final longitude =
                                      //     double.tryParse(placeDetails[3]);

                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        _suggestions.clear();
                                        _isSearching = false;
                                        _searchController.clear();
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:after_layout/after_layout.dart';
import 'package:despicable_me/models/character.dart';
import 'package:despicable_me/styleguide.dart';
import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;
  final double _expandedBottomSheet = 0;
  final double _collapsedBottomSheet = -250;
  final double _completelycollBottomSheet = -330;

  const CharacterDetailScreen({Key key, this.character}) : super(key: key);
  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen>
    with AfterLayoutMixin<CharacterDetailScreen> {
  double _bottomSheetPosititon = -330;
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "backgorund-${widget.character.name}",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.character.colors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.8, left: 16.0),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.close,
                    ),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      setState(() {
                        _bottomSheetPosititon =
                            widget._completelycollBottomSheet;
                      });

                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                    tag: "image-${widget.character.name}",
                    child: Image.asset(
                      widget.character.imagePath,
                      height: screenHeight * 0.45,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 8.0),
                  child: Hero(
                    tag: "name-${widget.character.name}",
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        child: Text(
                          widget.character.name,
                          style: AppTheme.heading,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child: Text(
                    widget.character.description,
                    style: AppTheme.subHeading,
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: InkWell(
                onTap: _onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      height: 80.0,
                      child: Text(
                        "clips",
                        style:
                            AppTheme.subHeading.copyWith(color: Colors.black),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _clipsWidget(),
                    ),
                  ],
                ),
              ),
            ),
            bottom: _bottomSheetPosititon,
            left: 0,
            right: 0,
          )
        ],
      ),
    );
  }

  _onTap() {
    setState(() {
      _bottomSheetPosititon = isCollapsed
          ? widget._expandedBottomSheet
          : widget._collapsedBottomSheet;
          isCollapsed = !isCollapsed;
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
      () {
        setState(
          () {
            isCollapsed = true;
            _bottomSheetPosititon = widget._collapsedBottomSheet;
          },
        );
      },
    );
  }

  Widget _clipsWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              roundedContainer(Colors.redAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.greenAccent),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.orangeAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.purple),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.grey),
              SizedBox(height: 20),
              roundedContainer(Colors.blueGrey),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.lightGreenAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.pinkAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

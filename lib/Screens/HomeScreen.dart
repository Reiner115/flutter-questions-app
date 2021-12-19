import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questions_app/Screens/QuestionsScreen.dart';
import 'package:questions_app/util/Consts.dart';
import 'package:questions_app/widgets/DoneButton.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              choiceScreen1(),
            ],
          )
        ],
      ),
    );
  }

  Widget background() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Consts.HOME_SCREEN_BG_IMAGE),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class choiceScreen1 extends StatefulWidget {
  choiceScreen1();

  @override
  State<StatefulWidget> createState() => choiceScreen1State();
}

class choiceScreen1State extends State {
  choiceScreen1State();

  static final List<String> categoryItems = [
    "Any Category",
    "General Knowledge",
    "Books",
    "Film",
    "Music",
    "Musical And Theaters",
    "Video Games",
    "Board Games",
    "Science : Nature",
    "Science : Computer",
    "Science : Mathmatics",
    "Methodology",
    "sports",
    "Geography",
    "History",
    "Politics",
    "Art",
    "Celebrities",
    "Animals",
    "Vehicles",
    "Comics",
    "Gadgets",
    "Anime & Manga",
    "Cartoon & Animation",
  ];
  static final List<int> categoryValues = [
    -1, // any
    9, // General Knowledge
    10, // Books
    11, // Film
    12, // Music
    13, // Musical And Theaters
    15, // Video Games
    16, // Board Games
    17, // Science : Nature
    18, // Science : Computer
    19, // Science : Mathematics
    20, // Methodology
    21, // sports
    22, // Geography
    23, // History
    24, // Politics
    25, // Art
    26, // Celebrities
    27, // Animals
    28, // Vehicles
    29, // Comics
    30, // Gadgets
    31, // Anime & Manga
    32, // Cartoon & Animation
  ];
  String categoryChoosedItem = categoryItems[0];
  int categoryChoosedValue = categoryValues[0];

  static final List<String> numberOfQuestionsItems = ["10", "20", "50"];
  static final List<int> numberOfQuestionsValues = [10, 20, 50];
  String numberOfQuestionsChoosedItem = numberOfQuestionsItems[0];
  int numberOfQuestionsChoosedValue = numberOfQuestionsValues[0];

  static final List<String> difficultyItems = ["any", "Easy", "Medium", "Hard"];
  String difficultyChoosedValue = difficultyItems[0];

  static final List<String> typeItems = [
    "Any",
    "Multiple choice",
    "True/False"
  ];
  static final List<String> typeValues = ["Any", "multiple", "boolean"];
  String typeChoosedItem = typeItems[0];
  String typeChoosedValue = typeValues[0];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(180, 8, 54, 118),
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                SizedBox(height: 20),
                headLine("Category of Questions"),
                dropDownMenu(
                  items: categoryItems,
                  currentValue: categoryChoosedItem,
                  onChange: (newValue) {
                    setState(() {
                      categoryChoosedValue = categoryValues[
                      categoryItems.indexOf(newValue! as String)];
                      categoryChoosedItem = newValue! as String;
                    });
                  },
                ),
                SizedBox(height: 20),
                headLine("Number of Questions"),
                dropDownMenu(
                  items: numberOfQuestionsItems,
                  currentValue: numberOfQuestionsChoosedItem,
                  onChange: (newValue) {
                    setState(() {
                      numberOfQuestionsChoosedValue = numberOfQuestionsValues[
                      numberOfQuestionsItems.indexOf(newValue! as String)];
                      numberOfQuestionsChoosedItem = newValue! as String;
                    });
                  },
                ),
                SizedBox(height: 20),
                headLine("Questions difficulty"),
                dropDownMenu(
                  items: difficultyItems,
                  currentValue: difficultyChoosedValue,
                  onChange: (newValue) {
                    setState(() {
                      difficultyChoosedValue = newValue! as String;
                    });
                  },
                ),
                SizedBox(height: 20),
                headLine("Type of Questions"),
                dropDownMenu(
                  items: typeItems,
                  currentValue: typeChoosedItem,
                  onChange: (newValue) {
                    setState(() {
                      typeChoosedValue =
                      typeValues[typeItems.indexOf(newValue! as String)];
                      typeChoosedItem = newValue! as String;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                DoneButton(
                  text: "Start Game",
                  onpressed: onStartGameButtonPressed,
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget headLine(String title) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(),
        ],
      ),
    );
  }

  dropDownMenu(
      {required List<String> items,
      required String currentValue,
      dynamic onChange}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButton(
          underline: SizedBox(),
          items: items
              .map<DropdownMenuItem<String>>((e) => dropDownMenuItemChild(e))
              .toList(),
          value: currentValue,
          onChanged: onChange),
    );
  }

  DropdownMenuItem<String> dropDownMenuItemChild(String value) {
    return DropdownMenuItem<String>(
      child: Container(
        width: 200,
        child: Text(
          value,
        ),
      ),
      value: value,
    );
  }

  void onStartGameButtonPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return QuestionsScreen(
              this.numberOfQuestionsChoosedValue,
              this.categoryChoosedValue,
              this.difficultyChoosedValue.toLowerCase(),
              this.typeChoosedValue.toLowerCase());
        },
      ),
    );
  }
}

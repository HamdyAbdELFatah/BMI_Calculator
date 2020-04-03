import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/reusable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ResultPage.dart';
import 'constants.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum Gender { male, female }

class _MyAppState extends State<MyApp> {
  Gender gender;
  int onValueChange = 185;
  int onWeightChange = 100;
  int onAgeChange = 21;
  @override
  Widget build(BuildContext context) {
    Color colorWidget = kActiveCardColour;
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        gender = Gender.male;
                      });
                    },
                    color: gender == Gender.male
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    widget: IconContent(FontAwesomeIcons.mars, 'MALE'),
                  ),
                ),
                Expanded(
                    child: ReusableCard(
                  onPress: () {
                    setState(() {
                      gender = Gender.female;
                    });
                  },
                  color: gender == Gender.female
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  widget: IconContent(FontAwesomeIcons.venus, 'FEMALE'),
                )),
              ]),
            ),
            Expanded(
                child: ReusableCard(
              color: colorWidget,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "HEIGHT",
                    style: textStyleWidget,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        onValueChange.toString(),
                        style: numberStyleWidget,
                      ),
                      Text('cm'),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbColor: kBottomContainerColour,
                        activeTrackColor: Colors.white,
                        inactiveTickMarkColor: Color(0xFF8D8E98),
                        overlayColor: Color(0x23EB1555),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 20),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10)),
                    child: Slider(
                      value: onValueChange.toDouble(),
                      min: 120,
                      max: 220,
                      onChanged: (double value) {
                        setState(() {
                          onValueChange = value.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
              child: Row(children: <Widget>[
                Expanded(
                    child: ReusableCard(
                  color: colorWidget,
                  widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "WEIGHT",
                          style: textStyleWidget,
                        ),
                        Text(
                          onWeightChange.toString(),
                          style: numberStyleWidget,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatCircleButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  onWeightChange--;
                                });
                              },
                            ),
                            FloatCircleButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  onWeightChange++;
                                });
                              },
                            ),

                          ],
                        )
                      ]),
                )),
                Expanded(
                    child: ReusableCard(
                  color: colorWidget,
                  widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "AGE",
                          style: textStyleWidget,
                        ),
                        Text(
                          onAgeChange.toString(),
                          style: numberStyleWidget,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatCircleButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  onAgeChange--;
                                });
                              },
                            ),
                            FloatCircleButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  onAgeChange++;
                                });
                              },
                            ),

                          ],
                        )
                      ]),
                )),
              ]),
            ),
            GestureDetector(
              onTap: (){
                CalculatorBrain brain=CalculatorBrain( height:onValueChange ,weight: onWeightChange);
                Navigator.push(context,MaterialPageRoute(builder: (context)=> ResultPage(
                  bmiResult: brain.calculateBMI(),
                  resultText: brain.getResult(),
                  interpretation:brain.getInterpretation() ,
                )));
              },
              child: Container(
                child: Center(child: Text('Calculate',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
                color: kBottomContainerColour,
                height: kBottomContainerHeight,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatCircleButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  FloatCircleButton({@required this.icon, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6,
      fillColor: Color(0xFF4C4F5E),
      shape: CircleBorder(),
      child: Icon(icon),
      constraints: BoxConstraints.tightFor(
        height: 40.0,
        width: 40.0,
      ),
      onPressed: onPressed,
    );
  }
}

class IconContent extends StatelessWidget {
  final IconData icon;
  final String text;
  IconContent(this.icon, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 60,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Color(0xFF8D8E98)),
        )
      ],
    );
  }
}


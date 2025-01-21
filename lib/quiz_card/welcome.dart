import 'package:flutter/material.dart';
import 'package:quiz_card_project/quiz_card/screen/quiz_sets/quiz_sets.dart';
import 'package:quiz_card_project/quiz_card/widget/custom_button.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                   
                  ),
            
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.6,
                  decoration: const BoxDecoration(
                     gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.purple],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                  child: Center(
                    child: Image.asset("asset/images/online-learning.png", scale: 0.8, width: 350, height: 350,),
                  ),
            
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.6,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.indigo, Colors.purple],
                    ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.6,
                padding: EdgeInsets.only(top: 40, bottom: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                  ),
                  
                ),
                child: Column(
                    children: [
                      Text('Welcome',style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,letterSpacing: 1,wordSpacing: 2),),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text('lorum ipsum dolor sit amet, consectetur adipiscing elit. Nulla',style: TextStyle(fontSize: 17,color: Colors.black,),
                        textAlign: TextAlign.center,),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: ReuseButton(
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> QuizSets()
                            ));//use MaterialPageRoute to navigate to the QuizSets screen
                          },
                          icon: Icons.play_arrow,
                          label: 'Start',
                        ),
                      )
                    ],
                  )
              ),
            )
          ],
        ),
       
      ),
    );
  }
}
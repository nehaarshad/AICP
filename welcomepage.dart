
import 'package:flutter/material.dart';
import 'package:to_do_list_application/homepage.dart';


class welcomepage extends StatelessWidget {
  const welcomepage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold (
          backgroundColor: Colors.white,
          body:  Center(

            child: Padding(

              padding:const EdgeInsets.all(0.0),

              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                            child:  Image.asset( 'assets/images/welcomepage.png',)
                        ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(35, 35,25, 5),
                          child: Text("Welcome to our intuitive to-do list app! ",style: TextStyle(
                              color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 35.0),
                          child: Text("Stay organized, boost productivity, and manage your tasks effortlessly. ",style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor:Colors.blueAccent, elevation: 15),

                            onPressed: (){
                                 Navigator.push(context,  MaterialPageRoute(builder: (context) => homepage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Let's Go ",style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                                ),
                                Icon(Icons.arrow_forward,color: Colors.white,)
                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}

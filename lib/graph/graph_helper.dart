import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/Provider/getData.dart';
import 'designhelper.dart';

class gh {
  static bool c = true;
  static var aa = '0AM',
      bb = '2AM',
      cc = '4AM',
      dd = '6AM',
      ee = '8AM',
      ff = '10AM',
      gg = '12PM',
      hh = '2PM',
      ii = '4PM',
      jj = '6PM',
      kk = '8PM',
      ll = '10PM';
}

class GraphHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          FadeInUp(
            duration: Duration(milliseconds: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DesignHelper(
                  onPressed: () {
                    gh.aa = '0AM';
                    gh.bb = '2AM';
                    gh.cc = '4AM';
                    gh.dd = '6AM';
                    gh.ee = '8AM';
                    gh.ff = '10AM';
                    gh.gg = '12PM';
                    gh.hh = '2PM';
                    gh.ii = '4PM';
                    gh.jj = '6PM';
                    gh.kk = '8PM';
                    gh.ll = '10PM';
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        "1 H",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),

                //FOR 7 DAYS
                DesignHelper(
                  onPressed: () {
                    // Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 6),
                      Text(
                        "24 H",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                DesignHelper(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        "7 D",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),

                SizedBox(
                  width: 5,
                ),
                //FOR 30 DAYS
                DesignHelper(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SizedBox(width: 6),
                      Text(
                        "30 D",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),

          FadeInUp(
            duration: Duration(milliseconds: 1000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //FOR 60 DAYS
                DesignHelper(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SizedBox(width: 6),
                      Text(
                        "60 D",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                ),

                SizedBox(
                  width: 5,
                ),

                //FOR 1 YEAR
                DesignHelper(
                  onPressed: () {
                    gh.aa = 'JAN';
                    gh.bb = 'FEB';
                    gh.cc = 'MAR';
                    gh.dd = 'APR';
                    gh.ee = 'MAY';
                    gh.ff = 'JUN';
                    gh.gg = 'JUL';
                    gh.hh = 'AUG';
                    gh.ii = 'SEP';
                    gh.jj = 'OCT';
                    gh.kk = 'NOV';
                    gh.ll = 'DEC';
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        "1 Y",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),

                SizedBox(
                  width: 5,
                ),

                //FOR 60 DAYS
                DesignHelper(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        "All",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          // recent transactions
          FadeInUp(
            duration: Duration(milliseconds: 1000),
            child: Text(
              data.singleCollectibleModel != null
                  ? data.singleCollectibleModel!.details!.name.toString() +
                      "'s Details"
                  : "",
              style: TextStyle(
                  color: gh.c ? Colors.blueGrey.shade300 : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: Icon(Icons.list),
                          trailing: Text(
                            "GFG",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text("List item $index"));
                    }),
              ),
            ]),
            /* divider(),
                    CustomTextField(
                      data: Icons.person,
                      controller: nameController,
                      hintText: "Name",
                      isObsecre: false,
                    ),
                    divider(),
                    CustomTextField(
                      data: Icons.email,
                      controller: emailController,
                      hintText: "Enter Your Email",
                      isObsecre: false,
                    ),
                    divider(),
                    CustomTextField(
                      data: Icons.lock,
                      controller: passwordController,
                      hintText: "Password",
                      isObsecre: true,
                    ),
                    divider(),
                    CustomTextField(
                      data: Icons.lock,
                      controller: confirmPassController,
                      hintText: "Confirm Password",
                      isObsecre: true,
                    ),
                    divider(),
                    CustomTextField(
                      data: Icons.phone,
                      controller: phoneController,
                      hintText: "Enter Your Phone number",
                      isObsecre: false,
                    ),
                    divider(),
                    CustomTextField(
                      data: Icons.my_location,
                      controller: locationController,
                      hintText: "Address",
                      isObsecre: false,

                    ),
                     //current location buton
                  ],*/
          ),
        ]),
      );
    });
  }
}

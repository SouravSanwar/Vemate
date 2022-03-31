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
      ll = '10PM',
      mm = '2AM',
      nn = '4AM',
      oo = '6AM',
      pp = '8AM',
      qq = '10AM',
      rr = '12PM',
      ss = '2PM',
      tt = '4PM',
      uu = '6PM',
      vv = '8PM',
      ww = '10PM';
}

class GraphHelper extends StatefulWidget {
  final int? id;

  const GraphHelper({Key? key, this.id}) : super(key: key);

  @override
  State<GraphHelper> createState() => _GraphHelperState();
}

class _GraphHelperState extends State<GraphHelper> {
  GetData? getData;

  @override
  void initState() {
    super.initState();

    getData = Provider.of<GetData>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetData>(builder: (context, data, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    gh.mm = '2AM';
                    gh.nn = '4AM';
                    gh.oo = '6AM';
                    gh.pp = '8AM';
                    gh.qq = '10AM';
                    gh.rr = '12PM';
                    gh.ss = '2PM';
                    gh.tt = '4PM';
                    gh.uu = '6PM';
                    gh.vv = '8PM';
                    gh.ww = '10PM';
                  },
                  child: const Text(
                    "24H",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(
                  width: 5,
                ),
                DesignHelper(
                  onPressed: () {
                    getData!.getSingleProduct(widget.id, graphType: 1);
                  },
                  child: const Text(
                    "7D",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(
                  width: 5,
                ),
                //FOR 30 DAYS
                DesignHelper(
                  onPressed: () {},
                  child: const Text(
                    "30D",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
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
                  child: const Text(
                    "1Y",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),


          const SizedBox(
            height: 40,
          ),
          // recent transactions
          FadeInUp(
            duration: Duration(milliseconds: 1000),
            child: Text(
              data.singleProductModel != null
                  ? data.singleProductModel!.name.toString() + "'s Details"
                  : "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: gh.c ? Colors.blueGrey.shade300 : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5)),
              child: ItemDetails(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      );
    });
  }
}

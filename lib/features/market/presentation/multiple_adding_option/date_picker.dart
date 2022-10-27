import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:ketemaa/core/utilities/app_colors/dark_white_mode.dart';

class DateViewer extends StatefulWidget {
  const DateViewer({Key? key}) : super(key: key);

  @override
  State<DateViewer> createState() => _DateViewerState();
}

class _DateViewerState extends State<DateViewer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () async {
              var datePicked = await DatePicker.showSimpleDatePicker(
                context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2015),
                lastDate: DateTime.now(),
                dateFormat: "dd-MM-yyyy",
                locale: DateTimePickerLocale.en_us,
                looping: true,
                backgroundColor: Color(0xff02072D),
                textColor: AppColors.white.withOpacity(.7),
              );

              final snackBar =
              SnackBar(content: Text("Date Picked $datePicked"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),

        ],
      ),
    );
  }
}

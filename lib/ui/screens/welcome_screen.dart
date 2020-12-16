import 'package:flutter/material.dart';
import 'package:papua_tourism/res/images.dart';
import 'package:papua_tourism/res/size_config.dart';
import 'package:papua_tourism/res/strings.dart';
import 'package:papua_tourism/res/styling.dart';
import 'package:papua_tourism/ui/screens/home_page.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          right: false,
          left: false,
          top: false,
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.center,
                    child: _welcomeContentWidget(context),
                  )),
              _buttonWidget(context)
            ],
          )),
    );
  }

  Widget _welcomeContentWidget(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 1),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Text(
                      Strings.welcomeScreenTitle,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Image.asset(
                  Images.homeImage,
                  fit: BoxFit.fill,
                ),
              )),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    Strings.welcomeScreenSubTitle,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonWidget(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          constraints: BoxConstraints(
              minHeight: 6.5 * SizeConfig.heightMultiplier,
              maxHeight: 7.9 * SizeConfig.heightMultiplier),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4 * SizeConfig.heightMultiplier),
            ),
            color: AppTheme.topBarBackgroundColor,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.chevron_left,
                  size: 6 * SizeConfig.imageSizeMultiplier,
                ),
              ),
              Text(
                Strings.getStartedButton,
                style: Theme.of(context).textTheme.headline6,
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.chevron_right,
                  size: 6 * SizeConfig.imageSizeMultiplier,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanetCard {
  String? cardTitle;
  String? cardImage;
  double? topMargin;
  double? leftMargin;

  PlanetCard(String title, String imagePath, double marginTop,double marginLeft) {
    cardTitle = title;
    cardImage = imagePath;
    topMargin = marginTop;
    leftMargin=marginLeft;
  }
}

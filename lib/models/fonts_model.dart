class FontModel {
  String fontId = "";
  String image = "";
  String name = "";
  String fontName = "";
  int fontSize = 0;
  String primaryColour = "";
  String secondaryColour = "";
  String outlineColour = "";
  String backColour = "";
  int bold = 0;
  int italic = 0;
  int underline = 0;
  int strikeOut = 0;
  double scaleX = 100.0;
  double scaleY = 100.0;
  double spacing = 0.0;
  double angle = 0.0;
  int borderStyle = 1;
  double outline = 1.0;
  double shadow = 0.0;
  int alignment = 5;
  int marginL = 10;
  int marginR = 10;
  int marginV = 10;
  int encoding = 1;
  String? fontFile;

  FontModel.empty();

  FontModel({
    required this.image,
    required this.name,
    required this.fontName,
    required this.fontSize,
    required this.primaryColour,
    required this.secondaryColour,
    required this.outlineColour,
    required this.backColour,
    this.bold = 0,
    this.italic = 0,
    this.underline = 0,
    this.strikeOut = 0,
    this.scaleX = 100.0,
    this.scaleY = 100.0,
    this.spacing = 0.0,
    this.angle = 0.0,
    this.borderStyle = 1,
    this.outline = 1.0,
    this.shadow = 0.0,
    this.alignment = 5,
    this.marginL = 10,
    this.marginR = 10,
    this.marginV = 10,
    this.encoding = 1,
    this.fontFile,
  });

  FontModel copyWith({
    String? fontId,
    String? image,
    String? name,
    String? fontName,
    int? fontSize,
    String? primaryColour,
    String? secondaryColour,
    String? outlineColour,
    String? backColour,
    int? bold,
    int? italic,
    int? underline,
    int? strikeOut,
    double? scaleX,
    double? scaleY,
    double? spacing,
    double? angle,
    int? borderStyle,
    double? outline,
    double? shadow,
    int? alignment,
    int? marginL,
    int? marginR,
    int? marginV,
    int? encoding,
    String? fontFile,
  }) {
    return FontModel(
      image: image ?? this.image,
      name: name ?? this.name,
      fontName: fontName ?? this.fontName,
      fontSize: fontSize ?? this.fontSize,
      primaryColour: primaryColour ?? this.primaryColour,
      secondaryColour: secondaryColour ?? this.secondaryColour,
      outlineColour: outlineColour ?? this.outlineColour,
      backColour: backColour ?? this.backColour,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      underline: underline ?? this.underline,
      strikeOut: strikeOut ?? this.strikeOut,
      scaleX: scaleX ?? this.scaleX,
      scaleY: scaleY ?? this.scaleY,
      spacing: spacing ?? this.spacing,
      angle: angle ?? this.angle,
      borderStyle: borderStyle ?? this.borderStyle,
      outline: outline ?? this.outline,
      shadow: shadow ?? this.shadow,
      alignment: alignment ?? this.alignment,
      marginL: marginL ?? this.marginL,
      marginR: marginR ?? this.marginR,
      marginV: marginV ?? this.marginV,
      encoding: encoding ?? this.encoding,
      fontFile: fontFile ?? this.fontFile,
    )..fontId = fontId ?? this.fontId;
  }

  FontModel.fromJson(Map<String, dynamic> json) {
    fontId = json["_id"] ?? json["id"] ?? fontId;
    image = json["image"] ?? image;
    name = json["name"] ?? name;
    fontName = json["fontName"] ?? fontName;
    fontSize = json["fontSize"] ?? fontSize;
    primaryColour = json["primaryColour"] ?? primaryColour;
    secondaryColour = json["secondaryColour"] ?? secondaryColour;
    outlineColour = json["outlineColour"] ?? outlineColour;
    backColour = json["backColour"] ?? backColour;
    bold = json["bold"] ?? bold;
    italic = json["italic"] ?? italic;
    underline = json["underline"] ?? underline;
    strikeOut = json["strikeOut"] ?? strikeOut;
    scaleX = (json["scaleX"] as dynamic)?.toDouble() ?? scaleX;
    scaleY = (json["scaleY"] as dynamic)?.toDouble() ?? scaleY;
    spacing = (json["spacing"] as dynamic)?.toDouble() ?? spacing;
    angle = (json["angle"] as dynamic)?.toDouble() ?? angle;
    borderStyle = json["borderStyle"] ?? borderStyle;
    outline = (json["outline"] as dynamic)?.toDouble() ?? outline;
    shadow = (json["shadow"] as dynamic)?.toDouble() ?? shadow;
    alignment = json["alignment"] ?? alignment;
    marginL = json["marginL"] ?? marginL;
    marginR = json["marginR"] ?? marginR;
    marginV = json["marginV"] ?? marginV;
    encoding = json["encoding"] ?? encoding;
    fontFile = json["fontFile"];
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": fontId,
      "image": image,
      "name": name,
      "fontName": fontName,
      "fontSize": fontSize,
      "primaryColour": primaryColour,
      "secondaryColour": secondaryColour,
      "outlineColour": outlineColour,
      "backColour": backColour,
      "bold": bold,
      "italic": italic,
      "underline": underline,
      "strikeOut": strikeOut,
      "scaleX": scaleX,
      "scaleY": scaleY,
      "spacing": spacing,
      "angle": angle,
      "borderStyle": borderStyle,
      "outline": outline,
      "shadow": shadow,
      "alignment": alignment,
      "marginL": marginL,
      "marginR": marginR,
      "marginV": marginV,
      "encoding": encoding,
      "fontFile": fontFile,
    };
  }

  @override
  String toString() {
    return 'FontModel{fontId: $fontId, image: $image, name: $name, fontName: $fontName, fontSize: $fontSize, primaryColour: $primaryColour, secondaryColour: $secondaryColour, outlineColour: $outlineColour, backColour: $backColour, bold: $bold, italic: $italic, underline: $underline, strikeOut: $strikeOut, scaleX: $scaleX, scaleY: $scaleY, spacing: $spacing, angle: $angle, borderStyle: $borderStyle, outline: $outline, shadow: $shadow, alignment: $alignment, marginL: $marginL, marginR: $marginR, marginV: $marginV, encoding: $encoding, fontFile: $fontFile}';
  }
}

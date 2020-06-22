import 'package:child_builder/child_builder.dart';
import 'package:flutter/material.dart';
import 'package:json_class/json_class.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'package:json_theme/json_theme.dart';

/// Builder that can build an [Material] widget.  See the [fromDynamic] for the
/// format.
class JsonMaterialBuilder extends JsonWidgetBuilder {
  JsonMaterialBuilder({
    this.borderOnForeground,
    this.borderRadius,
    this.clipBehavior,
    this.color,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.textStyle,
    this.materialType,
  });

  static const type = 'material';

  final bool borderOnForeground;
  final BorderRadius borderRadius;
  final Clip clipBehavior;
  final Color color;
  final double elevation;
  final Color shadowColor;
  final ShapeBorder shape;
  final TextStyle textStyle;
  final MaterialType materialType;

  /// Builds the builder from a Map-like dynamic structure.  This expects the
  /// JSON format to be of the following structure:
  ///
  /// ```json
  /// {
  ///   "borderOnForeground": <bool>,
  ///   "borderRadius": <BorderRadius>,
  ///   "clipBehavior": <Clip>,
  ///   "color": <Color>,
  ///   "elevation": <double>,
  ///   "materialType": <MaterialType>,
  ///   "shadowColor": <Color>,
  ///   "shape": <ShapeBorder>,
  ///   "textStyle": <TextStyle>
  /// }
  /// ```
  ///
  /// See also:
  ///  * [ThemeDecoder.decodeBorderRadius]
  ///  * [ThemeDecoder.decodeClip]
  ///  * [ThemeDecoder.decodeColor]
  ///  * [ThemeDecoder.decodeMaterialType]
  ///  * [ThemeDecoder.decodeShapeBorder]
  ///  * [ThemeDecoder.decodeTextStyle]
  static JsonMaterialBuilder fromDynamic(dynamic map) {
    JsonMaterialBuilder result;
    if (map != null) {
      result = JsonMaterialBuilder(
        borderOnForeground: map['borderOnForeground'] == null
            ? null
            : JsonClass.parseBool(
                map['borderOnForeground'],
              ),
        borderRadius: ThemeDecoder.decodeBorderRadius(map['borderRadius']),
        clipBehavior: ThemeDecoder.decodeClip(map['clipBehavior']),
        color: ThemeDecoder.decodeColor(map['color']),
        elevation: JsonClass.parseDouble(map['elevation']),
        materialType: ThemeDecoder.decodeMaterialType(map['type']),
        shadowColor: ThemeDecoder.decodeColor(map['color']),
        shape: ThemeDecoder.decodeShapeBorder(map['shape']),
        textStyle: ThemeDecoder.decodeTextStyle(map['textStyle']),
      );
    }

    return result;
  }

  @override
  Widget buildCustom({
    ChildWidgetBuilder childBuilder,
    BuildContext context,
    JsonWidgetData data,
    Key key,
  }) {
    assert(
      data.children?.length == 1,
      '[JsonMaterialBuilder] only supports exactly one child.',
    );

    return Material(
      borderOnForeground: borderOnForeground,
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      color: color,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      textStyle: textStyle,
      type: materialType,
      child: data.children[0].build(
        childBuilder: childBuilder,
        context: context,
      ),
    );
  }
}

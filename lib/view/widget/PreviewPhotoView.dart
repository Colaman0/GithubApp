import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github/util/util.dart';
import 'package:github/view/widget/PicturePreview.dart';

import 'BaseWidget.dart';

class PreviewPhotosView extends StatefulWidget {
  final List<String> pics;
  final String heroTag;

  const PreviewPhotosView({Key key, this.pics, this.heroTag}) : super(key: key);

  @override
  _PreviewPhotosViewState createState() =>
      _PreviewPhotosViewState(this.pics, this.heroTag);
}

class _PreviewPhotosViewState extends State<PreviewPhotosView> {
  final List<String> pics;
  final String heroTag;

  _PreviewPhotosViewState(this.pics, this.heroTag);

  @override
  Widget build(BuildContext context) {
    switch (pics.length) {
      case 1:
        var tag = "$heroTag-0";

        return Hero(
            tag: tag,
            child: LayoutBuilder(builder: (context, box) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(FadeRoute(
                    page: PicWidget(
                  tag: tag,
                  source: pics[0],
                ))),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: picStrToImage(pics[0]),
                ),
              );
            }));
        break;
      default:
        return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pics?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: 3, //横轴三个子widget
            ),
            itemBuilder: (context, itemIndex) {
              String tag = "$heroTag-$itemIndex";
              return Hero(
                tag: tag,
                child: Layout(
                        child: Container(
                  constraints: BoxConstraints.expand(),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.low,
                    imageUrl: pics[itemIndex],
                  ),
                ))
                    .size(width: BaseWidget.WRAP, height: BaseWidget.WRAP)
                    .backgroundColor(Colors.black)
                    .click(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => PicturePreview(
                          tag: heroTag, selectIndex: itemIndex, pics: pics)));
                }),
              );
            });
    }
  }

  CachedNetworkImage picStrToImage(String pic) => CachedNetworkImage(
        matchTextDirection: true,
        fit: BoxFit.fitWidth,
        filterQuality: FilterQuality.low,
        imageUrl: pic,
      );
}

class PicturePreview extends StatefulWidget {
  final List<String> pics;
  final Object tag;
  final selectIndex;

  const PicturePreview(
      {Key key,
      this.pics = const ["", "", "", "", "", "", ""],
      this.tag,
      this.selectIndex})
      : super(key: key);

  @override
  _PicturePreviewState createState() =>
      _PicturePreviewState(pics, tag, selectIndex);
}

class _PicturePreviewState extends State<PicturePreview> {
  final List<String> pics;
  final String tag;
  int selectIndex;
  PageController controller;

  _PicturePreviewState(this.pics, this.tag, this.selectIndex);

  @override
  Widget build(BuildContext context) {
    controller = new PageController(initialPage: selectIndex);
    return Hero(
      createRectTween: (Rect begin, Rect end) {
        return MaterialRectArcTween(begin: begin, end: end);
      },
      tag: "$tag-$selectIndex",
      child: Layout(
              child: PageView(
        controller: controller,
        onPageChanged: (index) {
          selectIndex = index;
        },
        children: picToPhotoView(),
      ))
          .backgroundColor(Colors.black)
          .size(width: BaseWidget.MATCH, height: BaseWidget.MATCH)
          .click(() {
        setState(() {
          Navigator.of(context).pop();
        });
      }),
    );
  }

  List<Widget> picToPhotoView() {
    List<Widget> photoViews = List();
    pics.forEach((pic) => photoViews.add(CachedNetworkImage(imageUrl: pic)));
    return photoViews;
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class PicWidget extends StatelessWidget {
  final String source;
  final String tag;

  const PicWidget({Key key, this.source, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
            child: Center(
      child: Hero(
        tag: tag,
        child: CachedNetworkImage(
          imageUrl: source,
        ),
      ),
    ))
        .size(width: BaseWidget.MATCH, height: BaseWidget.MATCH)
        .backgroundColor(Colors.black)
        .click(() {
      Navigator.of(context).pop();
    });
  }
}

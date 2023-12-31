import 'package:acadmiat/features/my_courses_feature/presentation/widgets/video_widget/amazon_video.dart';
import 'package:acadmiat/features/my_courses_feature/presentation/widgets/video_widget/vimeo_video.dart';
import 'package:flutter/material.dart';
import '../../../../../Locale/locale.dart';
import '../../../../../Theme/style.dart';
import 'package:flutter/foundation.dart';
import '../../../data/models/my_lecture_model.dart';

import 'add_bookmark_button.dart';
import 'book_marks_item_list.dart';

class BookMarksWidget extends StatefulWidget {
  BookMarksWidget({
    Key? key,
    required this.bookmarks,
    required this.videoId,
    required this.isVimeo,
    // required this.amazonVideoWidgetKey,
    // required this.vimeoVideoWidgetKey,
  }) : super(key: key);
  List<Bookmark> bookmarks;
  final bool isVimeo;
  final int videoId;



  @override
  State<BookMarksWidget> createState() => BookMarksWidgetState();
}

class BookMarksWidgetState extends State<BookMarksWidget> {

  void addBookmarks(Bookmark bookmark) {
    widget.bookmarks.add(bookmark);
    setState(() {});
  }
  void removeBookmarks(int id) {
    for (int i = 0; widget.bookmarks.length > i; i++) {
      print(i);
      if (id == widget.bookmarks[i].id) {
        print("Item deleted is $i");
        widget.bookmarks.removeAt(i);
      }
    }
    setState(() {});
  }
  void updateBookmarks(Bookmark bookmark) {
    for (int i = 0; widget.bookmarks.length > i; i++) {
      if (bookmark.id == widget.bookmarks[i].id) {
        widget.bookmarks[i].note = bookmark.note;
      }
    }
    setState(() {});
  }




  TextEditingController textController = TextEditingController();
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;

    if (widget.bookmarks.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الملاحظات على الفديو :",
                  style: blackBoldTextStyle(context: context, fontSize: 13),
                ),
                AddBookmarkButton(
                  isVimeo: widget.isVimeo,
                  allowSelectLecture: false,
                  videoId: widget.videoId,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.bookmarks.length,
                  itemBuilder: (context, index) {
                    return BookMarksItemList(
                      index: index,
                      atTime: widget.bookmarks[index].atTime,
                      // amazonVideoWidgetKey: widget.amazonVideoWidgetKey,
                      bookmarks: widget.bookmarks,
                      isVimeo: widget.isVimeo,
                      // vimeoVideoWidgetKey: widget.vimeoVideoWidgetKey,
                      videoId: widget.videoId,
                      theTextOfNote: widget.bookmarks[index].note,
                      bookmarkId: widget.bookmarks[index].id,
                    );
                  }),
            ),
          )
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "اضف ملاحظة على الفديو",
              style: blackBoldTextStyle(context: context, fontSize: 13),
            ),
            AddBookmarkButton(
              isVimeo: widget.isVimeo,
              allowSelectLecture: false,
              videoId: widget.videoId,
            ),
          ],
        ),
      );
    }
  }
}

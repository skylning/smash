/*
 * Copyright (c) 2019-2020. Antonello Andrea (www.hydrologis.com). All rights reserved.
 * Use of this source code is governed by a GPL3 license that can be
 * found in the LICENSE file.
 */

/*
 * Image table name.
 */
import 'dart:typed_data';

import 'package:dart_hydrologis_db/dart_hydrologis_db.dart';
import 'package:smashlibs/smashlibs.dart';

final String TABLE_IMAGES = "images";
/*
 * Image data table name.
 */
final String TABLE_IMAGE_DATA = "imagedata";
/*
 * id of the note, Generated by the db.
 */
final String IMAGES_COLUMN_ID = "_id";
/*
 * Longitude of the note in WGS84.
 */
final String IMAGES_COLUMN_LON = "lon";
/*
 * Latitude of the note in WGS84.
 */
final String IMAGES_COLUMN_LAT = "lat";
/*
 * Elevation of the note.
 */
final String IMAGES_COLUMN_ALTIM = "altim";
/*
 * Timestamp of the note.
 */
final String IMAGES_COLUMN_TS = "ts";
/*
 * The azimuth of the picture.
 */
final String IMAGES_COLUMN_AZIM = "azim";
/*
 * A name or text for the image.
 */
final String IMAGES_COLUMN_TEXT = "text";
/*
 * Is dirty field =0=false, 1=true)
 */
final String IMAGES_COLUMN_ISDIRTY = "isdirty";
/*
 * An optional note id, to which it is bound to.
 */
final String IMAGES_COLUMN_NOTE_ID = "note_id";
/*
 * The id of the connected image data.
 */
final String IMAGES_COLUMN_IMAGEDATA_ID = "imagedata_id";

/*
 * id of the note, Generated by the db.
 */
final String IMAGESDATA_COLUMN_ID = "_id";
/*
 * The image data.
 */
final String IMAGESDATA_COLUMN_IMAGE = "data";
/*
 * The image thumbnail data.
 */
final String IMAGESDATA_COLUMN_THUMBNAIL = "thumbnail";

class DbImage {
  int id;
  double lon;
  double lat;
  double altim;
  int timeStamp;
  double azim;
  String text;
  int isDirty = 1;
  int noteId;
  int imageDataId;

  Map<String, dynamic> toMap() {
    var map = {
      IMAGES_COLUMN_LAT: lat,
      IMAGES_COLUMN_LON: lon,
      IMAGES_COLUMN_TS: timeStamp,
      IMAGES_COLUMN_TEXT: text,
      IMAGES_COLUMN_ISDIRTY: isDirty,
    };
    if (id != null) {
      map[IMAGES_COLUMN_ID] = id;
    }
    if (noteId != null) {
      map[IMAGES_COLUMN_NOTE_ID] = noteId;
    }
    if (imageDataId != null) {
      map[IMAGES_COLUMN_IMAGEDATA_ID] = imageDataId;
    }
    if (azim != null) {
      map[IMAGES_COLUMN_ALTIM] = altim;
    }
    if (altim != null) {
      map[IMAGES_COLUMN_AZIM] = azim;
    }
    return map;
  }
}

class DbImageData {
  int id;
  Uint8List data;
  Uint8List thumb;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      IMAGESDATA_COLUMN_IMAGE: data,
      IMAGESDATA_COLUMN_THUMBNAIL: thumb,
    };
    if (id != null) {
      map[IMAGESDATA_COLUMN_ID] = id;
    }
    return map;
  }
}

class ImageQueryBuilder extends QueryObjectBuilder<DbImage> {
  @override
  DbImage fromMap(dynamic map) {
    DbImage image = DbImage()
      ..id = map[IMAGES_COLUMN_ID]
      ..lon = map[IMAGES_COLUMN_LON]
      ..lat = map[IMAGES_COLUMN_LAT]
      ..altim = map[IMAGES_COLUMN_ALTIM]
      ..timeStamp = map[IMAGES_COLUMN_TS]
      ..azim = map[IMAGES_COLUMN_AZIM]
      ..text = map[IMAGES_COLUMN_TEXT]
      ..isDirty = map[IMAGES_COLUMN_ISDIRTY]
      ..noteId = map[IMAGES_COLUMN_NOTE_ID]
      ..imageDataId = map[IMAGES_COLUMN_IMAGEDATA_ID];
    return image;
  }

  @override
  String insertSql() {
    return null;
  }

  @override
  String querySql() {
    return '''
      select $IMAGES_COLUMN_ID, $IMAGES_COLUMN_LON, $IMAGES_COLUMN_LAT, $IMAGES_COLUMN_ALTIM,
             $IMAGES_COLUMN_TS, $IMAGES_COLUMN_AZIM, $IMAGES_COLUMN_TEXT, $IMAGES_COLUMN_ISDIRTY,
             $IMAGES_COLUMN_NOTE_ID, $IMAGES_COLUMN_IMAGEDATA_ID
      from $TABLE_IMAGES
    ''';
  }

  @override
  Map<String, dynamic> toMap(DbImage item) {
    return null;
  }
}

class ImageDataQueryBuilder extends QueryObjectBuilder<DbImageData> {
  bool doData;
  bool doThumb;

  ImageDataQueryBuilder({this.doData: true, this.doThumb: true});

  @override
  DbImageData fromMap(dynamic map) {
    DbImageData imageData = DbImageData()..id = map[IMAGESDATA_COLUMN_ID];
    if (doData) imageData.data = map[IMAGESDATA_COLUMN_IMAGE];
    if (doThumb) imageData.thumb = map[IMAGESDATA_COLUMN_THUMBNAIL];
    return imageData;
  }

  @override
  String insertSql() {
    return null;
  }

  @override
  String querySql() {
    return '''
      select $IMAGESDATA_COLUMN_ID 
             ${doData ? ", $IMAGESDATA_COLUMN_IMAGE" : ""} 
             ${doThumb ? ", $IMAGESDATA_COLUMN_THUMBNAIL" : ""}
      from $TABLE_IMAGE_DATA
    ''';
  }

  @override
  Map<String, dynamic> toMap(DbImageData item) {
    return null;
  }
}

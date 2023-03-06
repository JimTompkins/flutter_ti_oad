
import 'package:flutter/foundation.dart';
import 'tIOADEoadDefinitions.dart';
import 'tIOADEoadHeader.dart';

class TIOADEoadImageReader {

  //final String TAG = TIOADEoadImageReader.getSimpleName();

  Uint8List rawImageData;
  TIOADEoadHeader imageHeader;
  List <TIOADEoadHeader.TIOADEoadSegmentInformation> imageSegments;

  TIOADEoadImageReader(Uri filename) {
    //imageSegments = Uint8List();
    TIOADToadLoadImageFromDevice(filename);
  }

  TIOADEoadImageReader(String filename) {
    //imageSegments = Uint8List();
    TIOADToadLoadImage(filename);
  }

  void TIOADToadLoadImage(String assetFilename) {
    AssetManager aMan = this.getAssets();

    try {
      InputStream inputStream = aMan.open(assetFilename);
      rawImageData = Uint8List[inputStream.available()];
      int len = inputStream.read(rawImageData);
      debugPrint("Read $len bytes from asset file");
      imageHeader = TIOADEoadHeader(rawImageData);
      imageHeader.validateImage();
    }
    catch () {
      debugPrint("Could not read input file");
    }
  }

  void TIOADToadLoadImageFromDevice(Uri filename) {
    try {
      InputStream inputStream = context.getContentResolver().openInputStream(filename);
      rawImageData = Uint8List[inputStream.available()];
      int len = inputStream.read(rawImageData);
      debugPrint("Read $len bytes from file");
      imageHeader = TIOADEoadHeader(rawImageData);
      imageHeader.validateImage();
    }
    catch (e) {
      debugPrint("Could not read input file");
    }
  }

  Uint8List getRawImageData() {
    return rawImageData;
  }

  Uint8List getHeaderForImageNotify() {
    Uint8List imageNotifyHeader = Uint8List(22);
    int position = 0;
    //0
    //System.arraycopy(source, at, dest, at, length)
    //System.arraycopy(imageHeader.TIOADEoadImageIdentificationValue,
    //  0,imageNotifyHeader,position,
    //  imageHeader.TIOADEoadImageIdentificationValue.length);
    //List.copyRange(dest, at, source, start?, end?)
    List.copyRange(imageNotifyHeader, 0,
      imageHeader.TIOADEoadImageIdentificationValue);
    position += imageHeader.TIOADEoadImageIdentificationValue.length as int;
    //7
    imageNotifyHeader[position++] = imageHeader.TIOADEoadBIMVersion;
    //8
    imageNotifyHeader[position++] = imageHeader.TIOADEoadImageHeaderVersion;
    //9
    //System.arraycopy(source, at, dest, at, length)
    //System.arraycopy(imageHeader.TIOADEoadImageInformation,
    //  0,imageNotifyHeader,position,
    //  imageHeader.TIOADEoadImageInformation.length);
    //List.copyRange(dest, at, source, start, end)
    List.copyRange(imageNotifyHeader, position,
      imageHeader.TIOADEoadImageIdentificationValue);
    position += imageHeader.TIOADEoadImageInformation.length as int;
    //13
    for (int ii = 0; ii < 4; ii++) {
      imageNotifyHeader[position++] = 
        TIOADEoadDefinitions.getByteFromUint32(imageHeader.TIOADEoadImageLength, ii);
    }
    //17
    //System.arraycopy(imageHeader.TIOADEoadImageSoftwareVersion,
    //  0,imageNotifyHeader,position,
    //  imageHeader.TIOADEoadImageSoftwareVersion.length);
    List.copyRange(imageNotifyHeader, position,
      imageHeader.TIOADEoadImageSoftwareVersion);
    // position += imageHeader.TIOADEoadImageSoftwareVersion.length;
    //21
    return imageNotifyHeader;
  }

}
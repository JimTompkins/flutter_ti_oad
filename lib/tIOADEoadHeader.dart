import 'package:flutter/foundation.dart';
import 'package:sprintf/sprintf.dart';

import 'tIOADEoadDefinitions.dart';

class TIOADEoadHeader {}

class TIOADEoadSegmentInformation extends TIOADEoadHeader {
  int TIOADSegmentType = 0;
  int TIOADWirelessTechnology = 0;
  int TIOADReserved = 0;
  int TIOADPayloadLength = 0;
  late Uint8List SegmentData;

  bool isContigous() {
    return false;
  }

  bool isBoundary() {
    return false;
  }

  void printSegmentInformation(TIOADEoadSegmentInformation segmentInformation) {
    debugPrint("Segment information :");
    debugPrint(((("Segment Type: " +
                    segmentInformation.TIOADSegmentType.toString()) +
                " (") +
            ((segmentInformation.TIOADSegmentType ==
                    TIOADEoadDefinitions.TI_OAD_EOAD_SEGMENT_TYPE_BOUNDARY_INFO)
                ? "Boundary Info"
                : ((segmentInformation.TIOADSegmentType ==
                        TIOADEoadDefinitions
                            .TI_OAD_EOAD_SEGMENT_TYPE_CONTIGUOUS_INFO)
                    ? "Contiguous Info"
                    : "Unknown Type"))) +
        ") ");
    debugPrint("Segment Wireless Standard: " +
        WirelessStdToString(segmentInformation.TIOADWirelessTechnology));
    if (segmentInformation.isBoundary()) {
      TIOADEoadBoundaryInformation boundaryInformation = segmentInformation;
      debugPrint("Stack Entry Address (32-bit): " +
          sprintf(
              "0x%08x", [boundaryInformation.TIOADBoundaryStackEntryAddress]));
      debugPrint("ICall Stack 0 Address (32-bit): " +
          sprintf(
              "0x%08x", [boundaryInformation.TIOADBoundaryIcallStack0Address]));
      debugPrint("RAM Start Address (32-bit): " +
          sprintf(
              "0x%08x", [boundaryInformation.TIOADBoundaryRamStartAddress]));
      debugPrint("RAM End Address (32-bit): " +
          sprintf("0x%08x", [boundaryInformation.TIOADBoundaryRamEndAddress]));
    } else {
      if (segmentInformation.isContigous()) {
        TIOADEoadContiguosImageInformation contiguosImageInformation =
            segmentInformation;
        debugPrint("Contiguous image information :");
        debugPrint("Stack Entry Address (32-bit): " +
            sprintf(
                "0x%8x", [contiguosImageInformation.TIOADStackEntryAddress]));
      }
    }
  }

  late Uint8List TIOADEoadImageIdentificationValue;
  int TIOADEoadImageCRC32 = 0;
  int TIOADEoadBIMVersion = 0;
  int TIOADEoadImageHeaderVersion = 0;
  int TIOADEoadImageWirelessTechnology = 0;
  late Uint8List TIOADEoadImageInformation;
  int TIOADEoadImageValidation = 0;
  int TIOADEoadImageLength = 0;
  int TIOADEoadProgramEntryAddress = 0;
  late Uint8List TIOADEoadImageSoftwareVersion;
  int TIOADEoadImageEndAddress = 0;
  int TIOADEoadImageHeaderLength = 0;
  int TIOADEoadReserved = 0;
  late List<TIOADEoadSegmentInformation> segments;
  late Uint8List rawData;

  TIOADEoadHeader(List<int> rawData) {
    rawData = rawData;
    TIOADEoadImageIdentificationValue = Uint8List(8);
    TIOADEoadImageInformation = Uint8List(4);
    TIOADEoadImageSoftwareVersion = Uint8List(4);
  }

  bool validateImage() {
    if (rawData == null) {
      return false;
    }
    int position = 0;
//    System.arraycopy(rawData, position, TIOADEoadImageIdentificationValue,
//        0, TIOADEoadImageIdentificationValue.length);
    List.copyRange(TIOADEoadImageIdentificationValue, 0, rawData, position,
        position + TIOADEoadImageIdentificationValue.lengthInBytes);
    position += 8;
    TIOADEoadImageCRC32 = TIOADEoadDefinitions.BUILD_UINT32(
        rawData[position + 3],
        rawData[position + 2],
        rawData[position + 1],
        rawData[position]);
    position += 4;
    TIOADEoadBIMVersion = rawData[position++];
    TIOADEoadImageHeaderVersion = rawData[position++];
    TIOADEoadImageWirelessTechnology = TIOADEoadDefinitions.BUILD_UINT16(
        rawData[position + 1], rawData[position]);
    position += 2;
//    System.arraycopy(rawData, position, this.TIOADEoadImageInformation, 0,
//        this.TIOADEoadImageInformation.length);
    List.copyRange(TIOADEoadImageInformation, 0, rawData, position,
        position + TIOADEoadImageInformation.lengthInBytes);
    position += 4;
    TIOADEoadImageValidation = TIOADEoadDefinitions.BUILD_UINT32(
        rawData[position + 3],
        rawData[position + 2],
        rawData[position + 1],
        rawData[position]);
    position += 4;
    TIOADEoadImageLength = TIOADEoadDefinitions.BUILD_UINT32(
        rawData[position + 3],
        rawData[position + 2],
        rawData[position + 1],
        rawData[position]);
    position += 4;
    TIOADEoadProgramEntryAddress = TIOADEoadDefinitions.BUILD_UINT32(
        rawData[position + 3],
        rawData[position + 2],
        rawData[position + 1],
        rawData[position]);
    position += 4;
//    System.arraycopy(rawData, position, this.TIOADEoadImageSoftwareVersion, 0,
//        this.TIOADEoadImageSoftwareVersion.length);
    List.copyRange(TIOADEoadImageSoftwareVersion, 0, rawData, position,
        position + TIOADEoadImageSoftwareVersion.lengthInBytes);
    position += 4;
    TIOADEoadImageEndAddress = TIOADEoadDefinitions.BUILD_UINT32(
        rawData[position + 3],
        rawData[position + 2],
        rawData[position + 1],
        rawData[position]);
    position += 4;
    TIOADEoadImageHeaderLength = TIOADEoadDefinitions.BUILD_UINT16(
        rawData[position + 1], rawData[position]);
    position += 2;
    TIOADEoadReserved = TIOADEoadDefinitions.BUILD_UINT16(
        rawData[position + 1], rawData[position]);
    position += 2;
    segments = List<TIOADEoadSegmentInformation>();
    TIOADEoadSegmentInformation segmentInformation =
        new TIOADEoadSegmentInformation();
    segmentInformation.TIOADSegmentType = rawData[position++];
    segmentInformation.TIOADWirelessTechnology =
        TIOADEoadDefinitions.BUILD_UINT16(
            rawData[position + 1], rawData[position]);
    position += 2;
    segmentInformation.TIOADReserved = rawData[position++];
    segmentInformation.TIOADPayloadLength = TIOADEoadDefinitions.BUILD_UINT32(
        rawData[position + 3],
        rawData[position + 2],
        rawData[position + 1],
        rawData[position]);
    position += 4;
    switch (segmentInformation.TIOADSegmentType) {
      case TIOADEoadDefinitions.TI_OAD_EOAD_SEGMENT_TYPE_BOUNDARY_INFO:
        TIOADEoadBoundaryInformation boundaryInformation =
            new TIOADEoadBoundaryInformation();
        boundaryInformation.TIOADSegmentType =
            segmentInformation.TIOADSegmentType;
        boundaryInformation.TIOADWirelessTechnology =
            segmentInformation.TIOADWirelessTechnology;
        boundaryInformation.TIOADReserved = segmentInformation.TIOADReserved;
        boundaryInformation.TIOADPayloadLength =
            segmentInformation.TIOADPayloadLength;
        addBoundaryInformation(boundaryInformation, rawData, position);
        break;
      case TIOADEoadDefinitions.TI_OAD_EOAD_SEGMENT_TYPE_CONTIGUOUS_INFO:
        TIOADEoadContiguosImageInformation contiguosImageInformation =
            new TIOADEoadContiguosImageInformation();
        contiguosImageInformation.TIOADSegmentType =
            segmentInformation.TIOADSegmentType;
        contiguosImageInformation.TIOADWirelessTechnology =
            segmentInformation.TIOADWirelessTechnology;
        contiguosImageInformation.TIOADReserved =
            segmentInformation.TIOADReserved;
        contiguosImageInformation.TIOADPayloadLength =
            segmentInformation.TIOADPayloadLength;
        addContigousInformation(contiguosImageInformation, rawData, position);
        break;
      default:
        break;
    }
    this.segments.add(segmentInformation);
    return true;
  }

  void printHeader(TIOADEoadHeader header) {
    debugPrint("Enhanced OAD Header");
    debugPrint("Image Information : " +
        sprintf("%c,%c,%c,%c,%c,%c,%c,%c", [
          header.TIOADEoadImageIdentificationValue[0],
          header.TIOADEoadImageIdentificationValue[1],
          header.TIOADEoadImageIdentificationValue[2],
          header.TIOADEoadImageIdentificationValue[3],
          header.TIOADEoadImageIdentificationValue[4],
          header.TIOADEoadImageIdentificationValue[5],
          header.TIOADEoadImageIdentificationValue[6],
          header.TIOADEoadImageIdentificationValue[7]
        ]));
    debugPrint(
        "Image CRC32 : " + sprintf("0x%08X", header.TIOADEoadImageCRC32));
    debugPrint("Image BIM version : " + header.TIOADEoadBIMVersion);
    debugPrint(
        "Image Image Header Version : " + header.TIOADEoadImageHeaderVersion);
    debugPrint("Image Wireless Standard : " +
        WirelessStdToString(header.TIOADEoadImageWirelessTechnology));
    debugPrint("Image Information : " +
        sprintf("%d(0x%02x),%d(0x%02x),%d(0x%02x),%d(0x%02x)", [
          header.TIOADEoadImageInformation[0],
          header.TIOADEoadImageInformation[0],
          header.TIOADEoadImageInformation[1],
          header.TIOADEoadImageInformation[1],
          header.TIOADEoadImageInformation[2],
          header.TIOADEoadImageInformation[2],
          header.TIOADEoadImageInformation[3],
          header.TIOADEoadImageInformation[3]
        ]));
    debugPrint("Image Validation : " +
        sprintf("%d(0x%08X)", [
          header.TIOADEoadImageValidation,
          header.TIOADEoadImageValidation
        ]));
    debugPrint("Image Length : " +
        sprintf("%d(0x%08X) Bytes",
            [header.TIOADEoadImageLength, header.TIOADEoadImageLength]));
    debugPrint("Program Entry Address : " +
        sprintf("0x%08X", header.TIOADEoadProgramEntryAddress));
    debugPrint("Image Software Version : " +
        sprintf("%c(0x%02X),%c(0x%02X),%c(0x%02X),%c(0x%02X)", [
          TIOADEoadImageSoftwareVersion[0],
          TIOADEoadImageSoftwareVersion[0],
          TIOADEoadImageSoftwareVersion[1],
          TIOADEoadImageSoftwareVersion[1],
          TIOADEoadImageSoftwareVersion[2],
          TIOADEoadImageSoftwareVersion[2],
          TIOADEoadImageSoftwareVersion[3],
          TIOADEoadImageSoftwareVersion[3]
        ]));
    debugPrint("Image End Address : " +
        sprintf("0x%08X", header.TIOADEoadImageEndAddress));
    debugPrint("Image Header Length : " +
        sprintf("%d(0x%08X) Bytes", [
          header.TIOADEoadImageHeaderLength,
          header.TIOADEoadImageHeaderLength
        ]));
    debugPrint("Image Reserved : " +
        sprintf("%d(0x%04X)",
            [header.TIOADEoadReserved, header.TIOADEoadReserved]));
  }

  String getHeaderInfo(TIOADEoadHeader header) {
    String headerInfo = ("Enhanced OAD Header" + "\r\n");
    headerInfo += (("Image Information : " +
        sprintf("%c,%c,%c,%c,%c,%c,%c,%c", [
          header.TIOADEoadImageIdentificationValue[0],
          header.TIOADEoadImageIdentificationValue[1],
          header.TIOADEoadImageIdentificationValue[2],
          header.TIOADEoadImageIdentificationValue[3],
          header.TIOADEoadImageIdentificationValue[4],
          header.TIOADEoadImageIdentificationValue[5],
          header.TIOADEoadImageIdentificationValue[6],
          header.TIOADEoadImageIdentificationValue[7]
        ]) +
        "\r\n"));
    headerInfo += (("Image CRC32 : " +
        sprintf("0x%08X", header.TIOADEoadImageCRC32) +
        "\r\n"));
    headerInfo +=
        (("Image BIM version : " + header.TIOADEoadBIMVersion) + "\r\n");
    headerInfo += (("Image Image Header Version : " +
            header.TIOADEoadImageHeaderVersion) +
        "\r\n");
    headerInfo += (("Image Wireless Standard : " +
            WirelessStdToString(header.TIOADEoadImageWirelessTechnology)) +
        "\r\n");
    headerInfo += (("Image Information : " +
        sprintf("%d(0x%02x),%d(0x%02x),%d(0x%02x),%d(0x%02x)", [
          header.TIOADEoadImageInformation[0],
          header.TIOADEoadImageInformation[0],
          header.TIOADEoadImageInformation[1],
          header.TIOADEoadImageInformation[1],
          header.TIOADEoadImageInformation[2],
          header.TIOADEoadImageInformation[2],
          header.TIOADEoadImageInformation[3],
          header.TIOADEoadImageInformation[3]
        ]) +
        "\r\n"));
    headerInfo += (("Image Validation : " +
        sprintf("%d(0x%08X)", [
          header.TIOADEoadImageValidation,
          header.TIOADEoadImageValidation
        ]) +
        "\r\n"));
    headerInfo += (("Image Length : " +
        sprintf("%d(0x%08X) Bytes",
            [header.TIOADEoadImageLength, header.TIOADEoadImageLength]) +
        "\r\n"));
    headerInfo += (("Program Entry Address : " +
        sprintf("0x%08X", header.TIOADEoadProgramEntryAddress) +
        "\r\n"));
    headerInfo += (("Image Software Version : " +
        sprintf("%c(0x%02X),%c(0x%02X),%c(0x%02X),%c(0x%02X)", [
          TIOADEoadImageSoftwareVersion[0],
          TIOADEoadImageSoftwareVersion[0],
          TIOADEoadImageSoftwareVersion[1],
          TIOADEoadImageSoftwareVersion[1],
          TIOADEoadImageSoftwareVersion[2],
          TIOADEoadImageSoftwareVersion[2],
          TIOADEoadImageSoftwareVersion[3],
          TIOADEoadImageSoftwareVersion[3]
        ]) +
        "\r\n"));
    headerInfo += (("Image End Address : " +
        sprintf("0x%08X", header.TIOADEoadImageEndAddress) +
        "\r\n"));
    headerInfo += ("Image Header Length : " +
        sprintf("%d(0x%08X) Bytes", [
          header.TIOADEoadImageHeaderLength,
          header.TIOADEoadImageHeaderLength
        ]) +
        "\r\n");
    headerInfo += ("Image Reserved : " +
        sprintf("%d(0x%04X)",
            [header.TIOADEoadReserved, header.TIOADEoadReserved]) +
        "\r\n");
    return headerInfo;
  }

  bool addBoundaryInformation(TIOADEoadBoundaryInformation boundaryInformation,
      List<int> rawData, int position) {
    boundaryInformation.TIOADBoundaryStackEntryAddress =
        TIOADEoadDefinitions.BUILD_UINT32(rawData[position + 3],
            rawData[position + 2], rawData[position + 1], rawData[position]);
    position += 4;
    boundaryInformation.TIOADBoundaryIcallStack0Address =
        TIOADEoadDefinitions.BUILD_UINT32(rawData[position + 3],
            rawData[position + 2], rawData[position + 1], rawData[position]);
    position += 4;
    boundaryInformation.TIOADBoundaryRamStartAddress =
        TIOADEoadDefinitions.BUILD_UINT32(rawData[position + 3],
            rawData[position + 2], rawData[position + 1], rawData[position]);
    position += 4;
    boundaryInformation.TIOADBoundaryRamEndAddress =
        TIOADEoadDefinitions.BUILD_UINT32(rawData[position + 3],
            rawData[position + 2], rawData[position + 1], rawData[position]);
    position += 4;
    return true;
  }

  bool addContigousInformation(
      TIOADEoadContiguosImageInformation contiguosImageInformation,
      List<int> rawData,
      int position) {
    contiguosImageInformation.TIOADStackEntryAddress =
        TIOADEoadDefinitions.BUILD_UINT32(rawData[position + 3],
            rawData[position + 2], rawData[position + 1], rawData[position]);
    position += 4;
    return true;
  }

  static String WirelessStdToString(int wirelessStd) {
    String returnVal = "";
    returnVal +=
        (((wirelessStd & TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_BLE) !=
                TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_BLE)
            ? " BLE "
            : "");
    returnVal +=
        (((wirelessStd & TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_RF4CE) !=
                TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_RF4CE)
            ? "RF4CE"
            : "");
    returnVal += (((wirelessStd &
                TIOADEoadDefinitions
                    .TI_OAD_EOAD_WIRELESS_STD_802_15_4_2_POINT_FOUR) !=
            TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_802_15_4_2_POINT_FOUR)
        ? "802.15.4 (2.4GHz)"
        : "");
    returnVal += (((wirelessStd &
                TIOADEoadDefinitions
                    .TI_OAD_EOAD_WIRELESS_STD_802_15_4_SUB_ONE) !=
            TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_802_15_4_SUB_ONE)
        ? "802.15.4 (Sub-One)"
        : "");
    returnVal += (((wirelessStd &
                TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_EASY_LINK) !=
            TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_EASY_LINK)
        ? "Easy Link"
        : "");
    returnVal += (((wirelessStd &
                TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_THREAD) !=
            TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_THREAD)
        ? "Thread"
        : "");
    returnVal += (((wirelessStd &
                TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_ZIGBEE) !=
            TIOADEoadDefinitions.TI_OAD_EOAD_WIRELESS_STD_ZIGBEE)
        ? "ZigBee"
        : "");
    return returnVal;
  }
}

class TIOADEoadContiguosImageInformation extends TIOADEoadSegmentInformation {
  int TIOADStackEntryAddress = 0;

  bool isContigous() {
    return true;
  }
}

class TIOADEoadBoundaryInformation extends TIOADEoadSegmentInformation {
  int TIOADBoundaryStackEntryAddress = 0;
  int TIOADBoundaryIcallStack0Address = 0;
  int TIOADBoundaryRamStartAddress = 0;
  int TIOADBoundaryRamEndAddress = 0;

  bool isBoundary() {
    return true;
  }
}

import 'package:flutter/foundation.dart';
import 'dart:convert';

enum oadStatusEnumeration {
  tiOADClientDeviceConnecting,
  tiOADClientDeviceDiscovering,
  tiOADClientConnectionParametersChanged,
  tiOADClientDeviceMTUSet,
  tiOADClientInitializing,
  tiOADClientPeripheralConnected,
  tiOADClientOADServiceMissingOnPeripheral,
  tiOADClientOADCharacteristicMissingOnPeripheral,
  tiOADClientOADWrongVersion,
  tiOADClientReady,
  tiOADClientFileIsNotForDevice,
  tiOADClientDeviceTypeRequestResponse,
  tiOADClientBlockSizeRequestSent,
  tiOADClientGotBlockSizeResponse,
  tiOADClientHeaderSent,
  tiOADClientHeaderOK,
  tiOADClientHeaderFailed,
  tiOADClientOADProcessStartCommandSent,
  tiOADClientImageTransfer,
  tiOADClientImageTransferFailed,
  tiOADClientImageTransferOK,
  tiOADClientEnableOADImageCommandSent,
  tiOADClientCompleteFeedbackOK,
  tiOADClientCompleteFeedbackFailed,
  tiOADClientCompleteDeviceDisconnectedPositive,
  tiOADClientCompleteDeviceDisconnectedDuringProgramming,
  tiOADClientProgrammingAbortedByUser,
  tiOADClientChipIsCC1352PShowWarningAboutLayouts,
}

enum oadChipType {
  tiOADChipTypeCC1310,
  tiOADChipTypeCC1350,
  tiOADChipTypeCC2620,
  tiOADChipTypeCC2630,
  tiOADChipTypeCC2640,
  tiOADChipTypeCC2650,
  tiOADChipTypeCustomOne,
  tiOADChipTypeCustomTwo,
  tiOADChipTypeCC2640R2,
  tiOADChipTypeCC2642,
  tiOADChipTypeCC2644,
  tiOADChipTypeCC2652,
  tiOADChipTypeCC1312,
  tiOADChipTypeCC1352,
  tiOADChipTypeCC1352P,
}

enum oadChipFamily {
  tiOADChipFamilyCC26x0,
  tiOADChipFamilyCC13x0,
  tiOADChipFamilyCC26x1,
  tiOADChipFamilyCC26x0R2,
  tiOADChipFamilyCC13x2_CC26x2,
}

class TIOADEoadDefinitions {
  /*! Main TI OAD Service UUID */
  static String TI_OAD_SERVICE = "f000ffc0-0451-4000-b000-000000000000";
  /*! Characteristic used to identify and approve a new image */
  static String TI_OAD_IMAGE_NOTIFY = "f000ffc1-0451-4000-b000-000000000000";
  /*! Characteristic used to send the actual image data to the client */
  static String TI_OAD_IMAGE_BLOCK_REQUEST =
      "f000ffc2-0451-4000-b000-000000000000";
  /*! Characteristic for image count (Legacy, not used on TI Enhanced OAD and not available on EOAD devices */
  static String TI_OAD_IMAGE_COUNT = "f000ffc3-0451-4000-b000-000000000000";
  /*! Characteristic for image status (Legacy, not used on TI Enhanced OAD and not available on EOAD devices */
  static String TI_OAD_IMAGE_STATUS = "f000ffc4-0451-4000-b000-000000000000";
  /*! Characteristic for OAD control point, only on EOAD devices and controls all aspects of EOAD */
  static String TI_OAD_IMAGE_CONTROL = "f000ffc5-0451-4000-b000-000000000000";

  static Uint8List TI_OAD_IMG_INFO_CC2640R2 = Uint8List.fromList([
    'O'.codeUnitAt(0),
    'A'.codeUnitAt(0),
    'D'.codeUnitAt(0),
    ' '.codeUnitAt(0),
    'I'.codeUnitAt(0),
    'M'.codeUnitAt(0),
    'G'.codeUnitAt(0),
    ' '.codeUnitAt(0)
  ]);

  static Uint8List TI_OAD_IMG_INFO_CC26X2R1 = Uint8List.fromList([
    'C'.codeUnitAt(0),
    'C'.codeUnitAt(0),
    '2'.codeUnitAt(0),
    '6'.codeUnitAt(0),
    'x'.codeUnitAt(0),
    '2'.codeUnitAt(0),
    'R'.codeUnitAt(0),
    '1'.codeUnitAt(0)
  ]);
  static Uint8List TI_OAD_IMG_INFO_CC13XR1 = Uint8List.fromList([
    'C'.codeUnitAt(0),
    'C'.codeUnitAt(0),
    '1'.codeUnitAt(0),
    '3'.codeUnitAt(0),
    'x'.codeUnitAt(0),
    '2'.codeUnitAt(0),
    'R'.codeUnitAt(0),
    '1'.codeUnitAt(0)
  ]);
  static const int TI_OAD_CONTROL_POINT_CMD_GET_BLOCK_SIZE = 1;
  static const int TI_OAD_CONTROL_POINT_CMD_START_OAD_PROCESS = 3;
  static const int TI_OAD_CONTROL_POINT_CMD_ENABLE_OAD_IMAGE = 4;
  static const int TI_OAD_CONTROL_POINT_CMD_DEVICE_TYPE_CMD = 16;
  static const int TI_OAD_CONTROL_POINT_CMD_IMAGE_BLOCK_WRITE_CHAR_RESPONSE =
      18;
  static int TI_OAD_IMAGE_IDENTIFY_PACKAGE_LEN = 22;

  static const int TI_OAD_EOAD_SEGMENT_TYPE_BOUNDARY_INFO = 0;
  static const int TI_OAD_EOAD_SEGMENT_TYPE_CONTIGUOUS_INFO = 1;
  static int TI_OAD_EOAD_SEGMENT_TYPE_WIRELESS_STD_OFF = 1;
  static int TI_OAD_EOAD_SEGMENT_TYPE_PAYLOAD_LEN_OFF = 4;
  static int TI_OAD_EOAD_WIRELESS_STD_BLE = 1;
  static int TI_OAD_EOAD_WIRELESS_STD_802_15_4_SUB_ONE = 2;
  static int TI_OAD_EOAD_WIRELESS_STD_802_15_4_2_POINT_FOUR = 4;
  static int TI_OAD_EOAD_WIRELESS_STD_ZIGBEE = 8;
  static int TI_OAD_EOAD_WIRELESS_STD_RF4CE = 16;
  static int TI_OAD_EOAD_WIRELESS_STD_THREAD = 32;
  static int TI_OAD_EOAD_WIRELESS_STD_EASY_LINK = 64;
  static int TI_OAD_EOAD_IMAGE_COPY_STATUS_NO_ACTION_NEEDED = 15;
  static int TI_OAD_EOAD_IMAGE_COPY_STATUS_IMAGE_TO_BE_COPIED = 254;
  static int TI_OAD_EOAD_IMAGE_COPY_STATUS_IMAGE_COPIED = 252;
  static int TI_OAD_EOAD_IMAGE_CRC_STATUS_INVALID = 0;
  static int TI_OAD_EOAD_IMAGE_CRC_STATUS_VALID = 2;
  static int TI_OAD_EOAD_IMAGE_CRC_STATUS_NOT_CALCULATED_YET = 3;
  static int TI_OAD_EOAD_IMAGE_TYPE_PERSISTANT_APP = 0;
  static int TI_OAD_EOAD_IMAGE_TYPE_APP = 1;
  static int TI_OAD_EOAD_IMAGE_TYPE_STACK = 2;
  static int TI_OAD_EOAD_IMAGE_TYPE_APP_STACK_MERGED = 3;
  static int TI_OAD_EOAD_IMAGE_TYPE_NETWORK_PROCESSOR = 4;
  static int TI_OAD_EOAD_IMAGE_TYPE_BLE_FACTORY_IMAGE = 5;
  static int TI_OAD_EOAD_IMAGE_TYPE_BIM = 6;
  static int TI_OAD_EOAD_IMAGE_HEADER_LEN = 44;
  static int TI_OAD_EOAD_SEGMENT_INFO_LEN = 8;

  static int BUILD_UINT32(int a, int b, int c, int d) {
    int al;
    int bl;
    int cl;
    int dl;
    int result;
    al = (((a & 15) << 24) & 4278190080);
    bl = (((b & 15) << 16) & 16711680);
    cl = (((c & 15) << 8) & 65280);
    dl = ((d & 15) & 15);
    result = ((((al | bl) | cl) | dl) & 268435455);
    return result;
  }

  static int getByteFromUint32(int uint32, int whichByte) {
    switch (whichByte) {
      case 0:
        return uint32 & 15;
      case 1:
        return (uint32 >> 8) & 15;
      case 2:
        return (uint32 >> 16) & 15;
      case 3:
        return (uint32 >> 24) & 15;
      default:
        return 0;
    }
  }

  static int buildUint16(int a, int b) {
    return (((a & 15) << 8) & 65280) | (b & 15);
  }

  static String byteToHexString(Uint8List b) {
    if (b == null) {
      return "NULL";
    }
    String sb = "";
    for (int i = 0; i < b.length; i++) {
      if (i < (b.length - 1)) {
        sb = sb + b[i].toRadixString(16) + ":";
      } else {
        sb = sb + b[i].toRadixString(16);
      }
    }
    return sb;
  }

  static int getHighByteFromUint16(int val) {
    return (val & 65280) >> 8;
  }

  static int getLowByteFromUint16(int val) {
    return val & 15;
  }

  String oadImageIdentificationPrettyPrint(Uint8List imageId) {
    bool match = true;
    for (int ii = 0; ii < 8; ii++) {
      if (imageId[ii] != TI_OAD_IMG_INFO_CC2640R2[ii]) match = false;
    }
    if (match) return "CC2640R2";
    match = true;
    for (int ii = 0; ii < 8; ii++) {
      if (imageId[ii] != TI_OAD_IMG_INFO_CC26X2R1[ii]) match = false;
    }
    if (match) return "CC26X2R";
    match = true;
    for (int ii = 0; ii < 8; ii++) {
      if (imageId[ii] != TI_OAD_IMG_INFO_CC13XR1[ii]) match = false;
    }
    if (match) return "CC13X2R";

    return "UNKNOWN";
  }

  Uint8List oadImageInfoFromChipType(Uint8List chipTypeVector) {
    // convert chipTypeVector to String
    String chipTypeString = utf8.decode(chipTypeVector);
    // Convert to enum
    oadChipType chipType = oadChipType.values
        .firstWhere((e) => e.toString() == 'oadChipType.' + chipTypeString);
    switch (chipType) {
      case oadChipType.tiOADChipTypeCC2640R2:
        return TI_OAD_IMG_INFO_CC2640R2;
      case oadChipType.tiOADChipTypeCC2642:
      case oadChipType.tiOADChipTypeCC2652:
        return TI_OAD_IMG_INFO_CC26X2R1;
      case oadChipType.tiOADChipTypeCC1352:
      case oadChipType.tiOADChipTypeCC1352P:
        return TI_OAD_IMG_INFO_CC13XR1;
      default:
        return Uint8List(8);
    }
  }

  String oadChipTypePrettyPrint(Uint8List chipTypeVector) {
    // convert chipTypeVector to String
    String chipTypeString = utf8.decode(chipTypeVector);
    // Convert to enum
    oadChipType chipType = oadChipType.values
        .firstWhere((e) => e.toString() == 'oadChipType.' + chipTypeString);
    switch (chipType) {
      case oadChipType.tiOADChipTypeCC1310:
        return "CC1310";
      case oadChipType.tiOADChipTypeCC1312:
        return "CC1312";
      case oadChipType.tiOADChipTypeCC1350:
        return "CC1350";
      case oadChipType.tiOADChipTypeCC1352:
        return "CC1352";
      case oadChipType.tiOADChipTypeCC1352P:
        return "CC1352P";
      case oadChipType.tiOADChipTypeCC2620:
        return "CC2620";
      case oadChipType.tiOADChipTypeCC2630:
        return "CC2630";
      case oadChipType.tiOADChipTypeCC2640:
        return "CC2640";
      case oadChipType.tiOADChipTypeCC2640R2:
        return "CC2640R2";
      case oadChipType.tiOADChipTypeCC2642:
        return "CC2642";
      case oadChipType.tiOADChipTypeCC2644:
        return "CC2644";
      case oadChipType.tiOADChipTypeCC2650:
        return "CC2650";
      case oadChipType.tiOADChipTypeCC2652:
        return "CC2652";
      case oadChipType.tiOADChipTypeCustomOne:
      case oadChipType.tiOADChipTypeCustomTwo:
        return "Custom";
    }
  }

  String oadStatusEnumerationGetDescriptiveString(oadStatusEnumeration status) {
    switch (status) {
      case oadStatusEnumeration.tiOADClientDeviceConnecting:
        return "TI EOAD Client is connecting !";
      case oadStatusEnumeration.tiOADClientDeviceDiscovering:
        return "TI EOAD Client is discovering services !";
      case oadStatusEnumeration.tiOADClientConnectionParametersChanged:
        return "TI EOAD Client waiting for connection parameter change";
      case oadStatusEnumeration.tiOADClientDeviceMTUSet:
        return "TI EOAD Client waiting for MTU Update";
      case oadStatusEnumeration.tiOADClientInitializing:
        return "TI EOAD Client is initializing !";
      case oadStatusEnumeration.tiOADClientPeripheralConnected:
        return "Connected to peripheral";
      case oadStatusEnumeration.tiOADClientOADServiceMissingOnPeripheral:
        return "EOAD service is missing on peripheral, cannot continue !";
      case oadStatusEnumeration.tiOADClientOADCharacteristicMissingOnPeripheral:
        return "Found EOAD service, but it`s missing some characteristics !";
      case oadStatusEnumeration.tiOADClientOADWrongVersion:
        return "OAD on peripheral has the wrong version !";
      case oadStatusEnumeration.tiOADClientReady:
        return "EOAD Client is ready for programming";
      case oadStatusEnumeration.tiOADClientBlockSizeRequestSent:
        return "EOAD Client sent block size request to peripheral";
      case oadStatusEnumeration.tiOADClientGotBlockSizeResponse:
        return "EOAD Client received block size response from peripheral";
      case oadStatusEnumeration.tiOADClientHeaderSent:
        return "EOAD Client sent image header to peripheral";
      case oadStatusEnumeration.tiOADClientHeaderOK:
        return "EOAD Client header was accepted by peripheral";
      case oadStatusEnumeration.tiOADClientHeaderFailed:
        return "EOAD Client header was rejected by peripheral, cannot continue !";
      case oadStatusEnumeration.tiOADClientOADProcessStartCommandSent:
        return "Sent start command to peripheral";
      case oadStatusEnumeration.tiOADClientImageTransfer:
        return "EOAD Image is transfering";
      case oadStatusEnumeration.tiOADClientImageTransferFailed:
        return "EOAD Image transfer failed, cannot continue !";
      case oadStatusEnumeration.tiOADClientImageTransferOK:
        return "EOAD Image transfer completed OK";
      case oadStatusEnumeration.tiOADClientEnableOADImageCommandSent:
        return "EOAD Image Enable command sent";
      case oadStatusEnumeration.tiOADClientCompleteFeedbackOK:
        return "EOAD Image Enable OK, device is rebooting on new image !";
      case oadStatusEnumeration.tiOADClientCompleteFeedbackFailed:
        return "EOAD Image Enable FAILED, device continuing on old image !";
      case oadStatusEnumeration.tiOADClientFileIsNotForDevice:
        return "EOAD Image is not for this device, cannot continue";
      case oadStatusEnumeration.tiOADClientDeviceTypeRequestResponse:
        return "EOAD Image device type response received";
      case oadStatusEnumeration.tiOADClientCompleteDeviceDisconnectedPositive:
        return "TI EOAD Client disconnected after successfull programming !";
      case oadStatusEnumeration
          .tiOADClientCompleteDeviceDisconnectedDuringProgramming:
        return "TI EOAD Client disconnected during image transfer, please move closer and try again !";
      case oadStatusEnumeration.tiOADClientProgrammingAbortedByUser:
        return "Programming aborted by user !";
      default:
        return "Unknown states";
    }
  }
}

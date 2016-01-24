
@import CoreBluetooth;
@import QuartzCore;

//UUID

#define BLUEFRUIT_NRF51822_SERVICE_UUID @"1804"
#define NODRIC_SERVICE_UUID @"0059"
#define BEACON_MANUFACTURER_UUID @"0400"


// BlueFruit Beacon Business
#define UART_SERVICE_UUID @"6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define UART_TX_CHARACTERISTIC_UUID @"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define UART_RX_CHARACTERISTIC_UUID @"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"

#define BEACON_SERVICE_UUID @"ee0c2084-8786-40ba-ab96-99b91ac981d8"



#import <UIKit/UIKit.h>


@interface ParKeyViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate>
@property (nonatomic, strong) CBCentralManager *centralManager;

// Properties for your Object controls
@property (nonatomic, strong) UIImageView *heartImage;
@property (nonatomic, strong) UITextView  *deviceInfoTextView;

// Properties to hold data characteristics for the peripheral device
@property (nonatomic, strong) NSString   *connected;
@property (nonatomic, strong) NSString   *bodyData;
@property (nonatomic, strong) NSString   *manufacturer;
@property (assign) uint16_t heartRate;

// Properties to handle storing the BPM and heart beat
@property (nonatomic, strong) UILabel    *heartRateBPMLabel;
@property (nonatomic, retain) NSTimer    *pulseTimer;

// Instance method to get the heart rate BPM information
- (void) getHeartBPMData:(CBCharacteristic *)characteristic error:(NSError *)error;

// Instance methods to grab device Manufacturer Name, Body Location
- (void) getManufacturerName:(CBCharacteristic *)characteristic;
- (void) getBodyLocation:(CBCharacteristic *)characteristic;

// Instance method to perform heart beat animations
- (void) doHeartBeat;
@end


#import "ParKeyViewController.h"

@interface ParKeyViewController ()

@end

@implementation ParKeyViewController {
    UITextView *_testTextView;
    UITextView *_deviceTestView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.heartImage setImage:[UIImage imageNamed:@"HeartImage"]];
    
    // Clear out textView
    [self.deviceInfoTextView setText:@""];
    [self.deviceInfoTextView setTextColor:[UIColor blueColor]];
    [self.deviceInfoTextView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.deviceInfoTextView setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:25]];
    [self.deviceInfoTextView setUserInteractionEnabled:NO];
    
    // Create your Heart Rate BPM Label
    self.heartRateBPMLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 30, 75, 50)];
    [self.heartRateBPMLabel setTextColor:[UIColor whiteColor]];
    [self.heartRateBPMLabel setText:[NSString stringWithFormat:@"%i", 0]];
    [self.heartRateBPMLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:28]];
    [self.heartImage addSubview:self.heartRateBPMLabel];
    
    // Scan for all available CoreBluetooth LE devices
    
    CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.centralManager = centralManager;
    [self scanForPeripherals:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    _testTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    _testTextView.text = @"Fill me up buttercup";
    [_testTextView setTextAlignment:NSTextAlignmentCenter];
    _testTextView.frame = CGRectMake(65, 65, 200, 200);
    _testTextView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_testTextView];
    
    self.deviceInfoTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    
    
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"Scan for Peripherals" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    button.frame = CGRectMake(CGRectGetMinX(_testTextView.frame),
                              CGRectGetMaxY(_testTextView.frame) + 10,
                              CGRectGetWidth(_testTextView.frame),
                              40);
    [self.view addSubview:button];
    
    [button addTarget:self
               action:@selector(scanForPeripherals:)
     forControlEvents:UIControlEventTouchDown];
}

- (void)scanForPeripherals:(id)sender {
    NSArray *services = @[[CBUUID UUIDWithString:BEACON_SERVICE_UUID],
                          [CBUUID UUIDWithString:UART_SERVICE_UUID],
                          [CBUUID UUIDWithString:UART_TX_CHARACTERISTIC_UUID],
                          [CBUUID UUIDWithString:UART_RX_CHARACTERISTIC_UUID]];
    [self.centralManager scanForPeripheralsWithServices:services options:nil];
    _testTextView.text = @"Connected";
}

- (void)openSecondViewController:(UIButton *)sender {
    UIViewController *sampleVC = [[UIViewController alloc] init];
    sampleVC.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:sampleVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Peripheral %@", peripheral);
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    if ([localName length] > 0) {
        NSLog(@"Found the beacon: %@", localName);
        [self.centralManager stopScan];
        [self.centralManager connectPeripheral:peripheral options:nil];
        _testTextView.text = @"Connected";
    }
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
    
}

#pragma mark - CBPeripheralDelegate

// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"Hello");
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
}

#pragma mark - CBCharacteristic helpers

// Instance method to get the heart rate BPM information
- (void) getHeartBPMData:(CBCharacteristic *)characteristic error:(NSError *)error
{
}
// Instance method to get the manufacturer name of the device
- (void) getManufacturerName:(CBCharacteristic *)characteristic
{
}
// Instance method to get the body location of the device
- (void) getBodyLocation:(CBCharacteristic *)characteristic
{
}
// Helper method to perform a heartbeat animation
- (void)doHeartBeat {
}

@end

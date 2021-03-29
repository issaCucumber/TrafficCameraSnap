Traffic Camera Snap Application

XCode Version: 12.4
Swift Version: 5
iOS version: 13 and higher

- The application retrieve traffic camera images from https://api.data.gov.sg/v1/transport/traffic-images in the following manners: 
	1. when the app launches
	2. every 60 seconds after app launch : to update new camera location, if any
	3. every time a pin is selected: to make sure the image shown to user is the latest
- Display all cameras returned from the above request on map (using MapKit)
- User can click on any pin to display the latest traffic image of the camera
- Traffic images are cached within the app launch session

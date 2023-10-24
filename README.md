# TCP Client Application

This project demonstrates a basic TCP client application implemented in Swift and SwiftUI. The application can connect to a specified server IP and port, send messages, and receive responses from the server.

## Usage

Follow the steps below to use the application:

1. Enter Server Information

   - Enter the server's IP address in the "IP Address" field.
   - Enter the server's port number in the "Port" field.

2. Connect

   - Click the "Connect" button to attempt a connection to the server.
   - If the port number is invalid or the connection cannot be established, an error message will be displayed.

3. Sending Messages

   - Enter the message you want to send in the "Message" field.
   - Click the "Send" button to send this message to the server.

4. Receiving Messages

   - Responses from the server will be displayed in the "Received Message" area.

5. Successful Connection
   - A "Connection Successful" message will be displayed when the connection is successfully established.

## Requirements

To run this project, you need:

- Xcode or another Swift IDE.
- CocoaPods or Swift Package Manager to install the necessary dependencies.

## Development

If you want to develop or customize this project, follow these steps:

1. Open the project and install the required dependencies.
2. Customize the `TCPClient` class according to your requirements or extend its functionality.
3. Edit the `ContentView.swift` file to change the view.
4. Extend your code to add more error handling or security features.
5. Add any additional features or customization to the project.

## Contributions

If you would like to contribute to this project, please open an "Issue" before submitting a "Pull Request". We welcome any contributions to encourage project improvement.

## License

This project is licensed under the MIT License. For more information, please see the [LICENSE](LICENSE) file.

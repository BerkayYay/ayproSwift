import Foundation

class TCPClient {
    var inputStream: InputStream?
    var outputStream: OutputStream?

    // Function to attempt a connection to the server
    func connect(host: String, port: UInt32) -> Bool {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?

        // Create a connection with the given IP and port information
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host as CFString, port, &readStream, &writeStream)

        // Assign to InputStream and OutputStream classes
        inputStream = readStream?.takeRetainedValue()
        outputStream = writeStream?.takeRetainedValue()

        guard let inputStream = inputStream, let outputStream = outputStream else {
            return false
        }

        // Open the connection
        inputStream.open()
        outputStream.open()

        return true
    }

    // Function to send a message
    func send(message: String) {
        guard let outputStream = outputStream else {
            return
        }

        // Prepare the message to be sent as data and send it
        let data = message.data(using: .utf8)!
        _ = data.withUnsafeBytes { outputStream.write($0.bindMemory(to: UInt8.self).baseAddress!, maxLength: data.count) }
    }

    // Function to read a response from the server
    func read() -> String? {
        guard let inputStream = inputStream else {
            return nil
        }

        // Create a buffer to hold the data
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 4096)
        let numberOfBytesRead = inputStream.read(buffer, maxLength: 4096)

        if numberOfBytesRead < 0 {
            if let error = inputStream.streamError {
                print("Read error: \(error)")
            }
            return nil
        }

        // Convert the read data into a string
        return String(bytesNoCopy: buffer, length: numberOfBytesRead, encoding: .utf8, freeWhenDone: true)
    }
}

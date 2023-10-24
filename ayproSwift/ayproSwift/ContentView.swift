import SwiftUI

struct ContentView: View {
    @State private var ip: String = ""
    @State private var port: String = ""
    @State private var message: String = ""
    @State private var tcpClient = TCPClient()
    @State private var serverMessage: String = ""
    @State private var errorMessage: String?
    @State private var isConnected: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("IP Adresi", text: $ip)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Port", text: $port)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            TextField("Mesaj", text: $message)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Bağlan") {
                guard let portNumber = UInt32(port) else {
                    errorMessage = "Geçersiz port numarası"
                    return
                }

                do {
                    let success = try tcpClient.connect(host: ip, port: portNumber)
                    if success {
                        isConnected = true // Bağlantı başarılı olduğunda flag'i ayarla
                        errorMessage = nil // Hata mesajını temizle
                    } else {
                        errorMessage = "Bağlantı başarısız!"
                        isConnected = false
                    }
                } catch {
                    errorMessage = "Bağlantı hatası: \(error.localizedDescription)"
                    isConnected = false
                }
            }

            Button("Gönder") {
                do {
                    let newMessage = message+"\n"
                    try tcpClient.send(message: newMessage)
                    if let response = try tcpClient.read() {
                        serverMessage = response
                    }
                } catch {
                    errorMessage = "Gönderme hatası: \(error.localizedDescription)"
                }
            }
        }
        .padding()
        .alert(isPresented: $isConnected) {
            Alert(
                title: Text("Bağlantı Başarılı"),
                message: Text("Sunucuya başarıyla bağlandınız."),
                dismissButton: .default(Text("Tamam"))
            )
        }
        if let error = errorMessage {
            Text(error)
                .foregroundColor(.red)
                .padding()
        }
        Text(serverMessage)
            .padding()
    }
}

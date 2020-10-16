//
//  SocketDataManager.swift
//  Report-Accident
//
//  Created by Andrew Toader on 10.15.20.
//

import Foundation

class SocketDataManager: NSObject, StreamDelegate {
    
    var readStream: Unmanaged<CFReadStream>?
    var writeStream: Unmanaged<CFWriteStream>?
    var inputStream: InputStream?
    var outputStream: OutputStream?
    var messages = [AnyHashable]()
    var response = ""
    



    func connectWith(socket: DataSocket)
    {
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (socket.ipAddress! as CFString), UInt32(socket.port), &readStream, &writeStream)
        messages = [AnyHashable]()
        open()
    }
    
    func disconnect()
    {
        close()
    }
    
    func open()
    {
        print("Opening streams.")
        outputStream = writeStream?.takeRetainedValue()
        inputStream = readStream?.takeRetainedValue()
        outputStream?.delegate = self
        inputStream?.delegate = self
        outputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        inputStream?.schedule(in: RunLoop.current, forMode: RunLoop.Mode.default)
        outputStream?.open()
        inputStream?.open()
    }
    
    func close()
    {
        print("Closing streams.")
        inputStream?.close()
        outputStream?.close()
        inputStream?.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
        outputStream?.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
        inputStream?.delegate = nil
        outputStream?.delegate = nil
        inputStream = nil
        outputStream = nil
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event)
    {
        print("stream event \(eventCode)")
        switch eventCode
        {
        case .openCompleted:
            print("Stream opened")
        case .hasBytesAvailable:
            if aStream == inputStream
            {
                var dataBuffer = Array<UInt8>(repeating: 0, count: 1024)
                var len: Int
                while (inputStream?.hasBytesAvailable)!
                {
                    len = (inputStream?.read(&dataBuffer, maxLength: 1024))!
                    if len > 0
                    {
                        let output = String(bytes: dataBuffer, encoding: .utf8)
                        if nil != output
                        {
                            print("server said: \(output ?? "")")
                            setMessageReceived(message: output!)
                        }
                    }
                }
            }
        case .hasSpaceAvailable:
            print("Stream has space available now")
        case .errorOccurred:
            print("\(aStream.streamError?.localizedDescription ?? "")")
        case .endEncountered:
            //aStream.close()
            //aStream.remove(from: RunLoop.current, forMode: RunLoop.Mode.default)
            print("End Encountered (nothing done)")
        default:
            print("Unknown event")
        }
    }
    
    func setMessageReceived(message: String)
    {
        response = message
    }
    
    func getMessageReceived() -> String
    {
        return response;
    }
    
    func send(message: String)
    {
        let response = "msg:\(message)"
        let buff = [UInt8](message.utf8)
        if let _ = response.data(using: .utf8)
        {
            outputStream?.write(buff, maxLength: buff.count)
            print(message)
        }
    }
}

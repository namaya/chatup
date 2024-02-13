//
//  ChatroomsObservable.swift
//  chatup
//
//  Created by Nicholas Amaya on 2/13/24.
//

import Foundation


import GRPC
import SwiftProtobuf
import Logging
import NIOTransportServices
import Network

enum MyError: Error {
    case runtimeError(String)
}


@MainActor
class MyChatroomsObservable: ObservableObject {
    
    private let logger = Logger(label: "com.namaya.mychatroomsobservable")
    private let serverHost: String
    private let serverPort: Int
    private let grpcClient: ChatUpServerAsyncClient?
    
    @Published var chatrooms: [Chatroom]
    
    init() {
        self.chatrooms = []
        
        let host = Bundle.main.infoDictionary?["ChatUp Server Host"] as? String
        
        if let host = host {
            serverHost = host
        } else {
            serverHost = ""
        }
        
        let port = Bundle.main.infoDictionary?["ChatUp Server Port"] as? Int
        if let port = port {
            serverPort = port
        } else {
            serverPort = 0
        }
        
        let group = NIOTSEventLoopGroup(loopCount: 1, defaultQoS: .default)
        let target = ConnectionTarget.hostAndPort(serverHost, serverPort)
        let tlsNWOptions = NWProtocolTLS.Options()
        let queue = DispatchQueue.global(qos: .default)
        
        sec_protocol_options_set_verify_block(tlsNWOptions.securityProtocolOptions, { (sec_protocol_metadata, sec_trust, sec_protocol_verify_complete) in
            let trust = sec_trust_copy_ref(sec_trust).takeRetainedValue()
            
            var error: CFError?
            if SecTrustEvaluateWithError(trust, &error) {
                print("test")
                sec_protocol_verify_complete(true)
            } else {
                let serverName = sec_protocol_metadata_get_server_name(sec_protocol_metadata)
                
                if let serverName = serverName {
                    print("sec_protocol_metadata: \(String(cString: serverName))")
                }
                
//                let dd = sec_protocol_metadata_copy_peer_public_key(sec_protocol_metadata)
            
//                var result = Data(count: dd.)
//
//                result.withUnsafeMutableBytes { buf in
//                    _ = dd.copyBytes(to: buf)
//                }
//
//                print("publicKey: \(String(cString: ""))")
                sec_protocol_verify_complete(true)
            }
        }, queue)
        let tlsConfig = GRPCTLSConfiguration.makeClientConfigurationBackedByNetworkFramework(options: tlsNWOptions)
    
        do {
            let grpcChannel = try GRPCChannelPool.with(target: target, transportSecurity: .tls(tlsConfig), eventLoopGroup: group)
            let interceptorFactory = AuthGrpcInterceptorFactory()
            grpcClient = ChatUpServerAsyncClient(channel: grpcChannel, interceptors: interceptorFactory)
        } catch {
            grpcClient = nil
        }
    }
    
    deinit {
        grpcClient?.channel.close()
    }

    func loadChatrooms() async {
        let request = Google_Protobuf_Empty()
        
        logger.debug("Sending request to backend...")
        
        do {
            print("listing chatrooms..")
            let chatroomList = try await grpcClient!.listChatrooms(request)
            print("listed chatrooms..")
            self.chatrooms = chatroomList.chatrooms
            logger.info("Retrieved \(self.chatrooms.count) chatrooms.")
        } catch let error {
            logger.error("Couldn't retrieve chatrooms. Error \(error)")
        }
    }
    
}

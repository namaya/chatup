//
//  AuthGrpcInterceptor.swift
//  chatup
//
//  Created by Nicholas Amaya on 2/7/24.
//

import Foundation
import GRPC
import NIOCore
import SwiftProtobuf

typealias Request = GRPCAsyncServerCallContext.Request
typealias Response = GRPCAsyncServerCallContext.Response

class AuthGrpcInterceptor<Request, Response>: ClientInterceptor<Request, Response> {
    override func send(
      _ part: GRPCClientRequestPart<Request>,
      promise: EventLoopPromise<Void>?,
      context: ClientInterceptorContext<Request, Response>
    ) {
        switch part {
        case .metadata(var headers):
            let token = "some-token"
            headers.add(name: "Authorization", value: "Bearer \(token)")
            
            context.send(.metadata(headers), promise: promise)
        default:
            context.send(part, promise: promise)
        }
    }
}



final class AuthGrpcInterceptorFactory: ChatUpServerClientInterceptorFactoryProtocol {
    func makeListChatroomsInterceptors() -> [GRPC.ClientInterceptor<SwiftProtobuf.Google_Protobuf_Empty, ChatroomList>] {
        return [AuthGrpcInterceptor<Google_Protobuf_Empty, ChatroomList>()]
    }
    
    func makeGetChatroomInterceptors() -> [GRPC.ClientInterceptor<GetChatroomRequest, ChatroomList>] {
        return [AuthGrpcInterceptor<GetChatroomRequest, ChatroomList>()]
    }
    
    func makeCreateChatroomInterceptors() -> [GRPC.ClientInterceptor<Chatroom, Chatroom>] {
        return [AuthGrpcInterceptor<Chatroom, Chatroom>()]
    }
    
    func makeJoinInterceptors() -> [GRPC.ClientInterceptor<JoinRequest, ChatMessage>] {
        return [AuthGrpcInterceptor<JoinRequest, ChatMessage>()]
    }
    
    func makeLeaveInterceptors() -> [GRPC.ClientInterceptor<JoinRequest, SwiftProtobuf.Google_Protobuf_Empty>] {
        return [AuthGrpcInterceptor<JoinRequest, SwiftProtobuf.Google_Protobuf_Empty>()]
    }
    
    func makeSendMessageInterceptors() -> [GRPC.ClientInterceptor<ChatMessage, SwiftProtobuf.Google_Protobuf_Empty>] {
        return [AuthGrpcInterceptor<ChatMessage, SwiftProtobuf.Google_Protobuf_Empty>()]
    }
}


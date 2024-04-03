//
//  FlutterHandler.swift
//  audible_mode
//
//  Created by Andrea Mainella on 22/12/21.
//

import Foundation


public class FlutterHandler{
    
    private let channel: FlutterMethodChannel
    private let currentProfileEventChannel: FlutterEventChannel
    private let currentVolumeEventChannel: FlutterEventChannel
    
    private let _currentVolumeHandler: CurrentVolumeStreamHandler
    
    init(binding: FlutterPluginRegistrar) {
        let audibleHandler: AudibleHandler = AudibleHandler();
        
        channel = FlutterMethodChannel(
            name: Constants.METHOD_CHANNEL,
            binaryMessenger: binding.messenger());
        
        currentProfileEventChannel = FlutterEventChannel(
            name: Constants.CURRENT_PROFILE_EVENT,
            binaryMessenger: binding.messenger());
        
        currentVolumeEventChannel = FlutterEventChannel(
            name: Constants.CURRENT_VOLUME_EVENT,
            binaryMessenger: binding.messenger());
        
        
        channel.setMethodCallHandler{(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case Constants.GET_AUDIBLE_MODE:
                result(audibleHandler.getAudibleProfile())
                break;
            case Constants.GET_CURRENT_VOLUME:
                result(audibleHandler.getCurrentVolume())
                break;
            case Constants.SET_VOLUME:
                if let args = call.arguments as? Dictionary<String, Any>{
                    audibleHandler.setVolume(volume: (args["volume"] as? NSNumber)?.floatValue)
                }
                result(true)
                break;
            case Constants.GET_MAX_VOLUME:
                result(audibleHandler.getMaxVolume())
                break;
            default:
                result("Method not found")
            }
        }
        _currentVolumeHandler = CurrentVolumeStreamHandler(currentVolumeEventChannel)
        currentProfileEventChannel.setStreamHandler(CurrentProfileStreamHandler())
    }
    
    public func dispose(){
        channel.setMethodCallHandler(nil)
        currentProfileEventChannel.setStreamHandler(nil)
        currentVolumeEventChannel.setStreamHandler(nil)
    }
}

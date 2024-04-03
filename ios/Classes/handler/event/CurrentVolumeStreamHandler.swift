//
//  CurrentVolumeStreamHandler.swift
//  audible_mode
//
//  Created by Andrea Mainella on 03/04/24.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

class CurrentVolumeStreamHandler: NSObject, FlutterStreamHandler {
    private let volumeEventChannel: FlutterEventChannel
    private var audioSession = AVAudioSession.sharedInstance()
    
    init(_ eventChannel: FlutterEventChannel) {
        volumeEventChannel = eventChannel
        super.init()
        volumeEventChannel.setStreamHandler(self)
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: Constants.VOLUME_NOTIFICATION), object: nil, queue: nil
        ) { notification in
            if let volume = notification.userInfo?[Constants.VOLUME_NOTIFICATION_PARAM] as? Float {
                events(Double(volume))
            }
        }
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(self)
        return nil
    }
}


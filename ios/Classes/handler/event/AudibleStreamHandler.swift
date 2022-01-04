//
//  AudibleStreamHandler.swift
//  audible_mode
//
//  Created by Andrea Mainella on 22/12/21.
//

import Foundation
import Mute

public class AudibleStreamHandler: NSObject, FlutterStreamHandler{
    private var _eventSink: FlutterEventSink?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _eventSink = events
        Mute.shared.notify = { muted in
            if(muted) {
                self._eventSink!(AudibleProfile.SILENT_MODE.rawValue)
            } else {
                self._eventSink!(AudibleProfile.NORMAL_MODE.rawValue)
            }
        }
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _eventSink = nil
        return nil
    }
}

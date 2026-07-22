//
//  AudibleHandler.swift
//  audible_mode
//
//  Created by Andrea Mainella on 22/12/21.
//

import Foundation
import Mute
import AVKit
import MediaPlayer

public class AudibleHandler{
    
    private let audioSession = AVAudioSession.sharedInstance()
    let volumeView = MPVolumeView()
    
    init() {
        do {
            try audioSession.setCategory(.ambient)
            try audioSession.setActive(true)
        } catch {
            print("Error on getting Volume")
        }
        Mute.shared.checkInterval = 1.0;
    }
    
    func getAudibleProfile() -> String{
        Mute.shared.check()
        if(Mute.shared.isMute) {
            return AudibleProfile.SILENT_MODE.rawValue;
        } else {
            return AudibleProfile.NORMAL_MODE.rawValue;
        }
    }
    
    func getCurrentVolume() -> Float{
        return audioSession.outputVolume;
    }
    
    func getMaxVolume() -> Float{
        return 1.0;
    }
    
    func setVolume(volume: Float?) -> Void{
        if (volume != nil){
            let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                slider?.value = volume!
            }
        }
    }
}

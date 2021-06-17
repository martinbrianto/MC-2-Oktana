//
//  InterfaceController.swift
//  OktanaWatch Extension
//
//  Created by Aqshal Wibisono on 16/06/21.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        
        if let playPauseOpt = (message["playPause"] as? String) {
            switch playPauseOpt{
            case "play" : playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"))
            case "pause": playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"))
            default: print("error")
            
            }
           
        }
        if let titleOpt = (message["workoutTitle"] as? String){
            workoutTitleLabel.setText(titleOpt)
        }
       
    }
    

    @IBOutlet weak var playPauseBtn: WKInterfaceButton!
    @IBOutlet weak var reverseBackBtn: WKInterfaceButton!
    @IBOutlet weak var forwardSkipButton: WKInterfaceButton!
    @IBOutlet weak var workoutTitleLabel: WKInterfaceLabel!
    var isPaused : Bool = false
    var session : WCSession!
   
    @IBAction func onPlayPauseBtnClick() {
        if isPaused == false{
            isPaused = true
            playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"))
            session.sendMessage(["Message": "paused"], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
            
        }else{
            isPaused = false
            playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"))
            session.sendMessage(["Message": "played"], replyHandler: nil) { (error) in
                print(error.localizedDescription)
            }
            
        }

    }
    @IBAction func onReverseBackBtnClick() {
        session.sendMessage(["Message" : "reverseback"], replyHandler: nil) { (error) in
            print(error.localizedDescription)
        }
    }
    @IBAction func onForwardSkipBtnClick() {
        session.sendMessage(["Message" : "skipforward"], replyHandler: nil) { (error) in
            print(error.localizedDescription)
            
        }
    }
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
        session = WCSession.default
        session.delegate = self
        session.activate()
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}

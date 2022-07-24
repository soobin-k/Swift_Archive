//
//  ViewController.swift
//  TimerApp
//
//  Created by 김수빈 on 2022/07/24.
//

import UIKit
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0 // 현재 카운트다운 되고 있는 시간을 초로 저장
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToggleButton()
    }

    func setTimerInfoViewVisible(isHidden: Bool){
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    func configureToggleButton(){
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }
    
    func startTimer(){
        if self.timer == nil{
            // ✨ main 쓰레드는 ios에서 오직 1개만 존재
            // ✨ 인터페이스(UI)와 관련된 작업은 무조건 main 쓰레드에서 동작해야함
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            // 타이머 세팅
            self.timer?.schedule(deadline: .now(), repeating: 1)
            // 타이머 실행중 이벤트
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else {return}
                self.currentSeconds -= 1
                let hour = self.currentSeconds / 3600
                let minute = (self.currentSeconds % 3600) / 60
                let second = (self.currentSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minute, second)
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    self.imageView?.transform = CGAffineTransform(rotationAngle:  .pi)
                })
                
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    self.imageView?.transform = CGAffineTransform(rotationAngle:  .pi * 2)
                })
                
                if self.currentSeconds <= 0{
                    // 타이머가 종료
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
            })
            // 타이머 시작
            self.timer?.resume()
        }
    }
    
    func stopTimer(){
        if self.timerStatus == .pause{
            self.timer?.resume()
        }
        self.timerStatus = .end
        UIView.animate(withDuration: 0.5, animations: {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity // 이미지뷰 원상 복구
        })
        self.toggleButton.isSelected = false
        self.cancelButton.isEnabled = false
        self.timer?.cancel()
        // ✨ 타이머 종료 시, 반드시 nil을 할당해서 메모리에서 해제시켜야함
        // ✨ nil 안하면, 화면을 벗어나도 타이머가 동작될 수 있음!
        self.timer = nil
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch(self.timerStatus){
        case .start, .pause:
            self.stopTimer()
        default:
            break
        }
    }
    
    @IBAction func tapToggleButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration)
        switch(self.timerStatus){
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            // withDuration: 몇초간 지속할 것인지
            // delay: 지연 시간
            UIView.animate(withDuration: 0.5, animations: {
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })

            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true
            self.startTimer()
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend()
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        default:
            break
        }
    }
    
}


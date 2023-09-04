//
//  ViewController.swift
//  GKSlider
//
//  Created by QuintGao on 08/31/2023.
//  Copyright (c) 2023 QuintGao. All rights reserved.
//

import UIKit
import GKSlider

enum GradientType {
    case topToBottom
    case leftToRight
    case upLeftToLowRight
    case upRightToLowLeft
}

class ViewController: UIViewController {

    @IBOutlet weak var wySlider: GKSlider!
    
    @IBOutlet weak var wyImgSlider: GKSlider!
    
    @IBOutlet weak var pkSlider: GKSlider!
    
    @IBOutlet weak var progressSlider: GKSlider!
    
    @IBOutlet weak var gradientSlider: GKSlider!
    
    @IBOutlet weak var customSlider: GKSlider!
    
    @IBOutlet weak var wxSlider: GKSlider!
    
    @IBOutlet weak var lineSlider: GKSlider!
    
    var isShowChange: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSlider()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func initSlider() {
        wySlider.delegate = self
        wySlider.maximumTrackTintColor = .lightGray
        wySlider.minimumTrackTintColor = .red
        wySlider.bufferTrackTintColor = .gray
        wySlider.setBackgroundImage(UIImage(named: "cm2_fm_playbar_btn_dot"), for: .normal)
        wySlider.setThumbImage(UIImage(named: "cm2_fm_playbar_btn"), for: .normal)
        wySlider.sliderHeight = 3
        wySlider.bufferValue = 0.6
        wySlider.value = 0.4
        
        wyImgSlider.delegate = self
        wyImgSlider.setThumbImage(UIImage(named: "cm2_mv_playbar_btn_ver"), for: .normal)
        wyImgSlider.setThumbImage(UIImage(named: "cm2_mv_playbar_btn_ver"), for: .highlighted)
        wyImgSlider.maximumTrackImage = UIImage(named: "cm2_mv_playbar_bg_ver")
        wyImgSlider.minimumTrackImage = UIImage(named: "cm2_mv_playbar_curr")
        wyImgSlider.bufferTrackImage = UIImage(named: "cm2_mv_playbar_ready_ver")
        wyImgSlider.sliderHeight = 2
        wyImgSlider.bufferValue = 0.6
        wyImgSlider.value = 0.4
        
        pkSlider.maximumTrackTintColor = .blue
        pkSlider.minimumTrackTintColor = .red
        pkSlider.sliderHeight = 20
        pkSlider.setThumbImage(UIImage(named: "live_pk_pro"), for: .normal)
        pkSlider.isSliderAllowTapped = false
        pkSlider.isSliderBlockAllowTapped = false
        pkSlider.bgCornerRadius = 10
        pkSlider.value = 0.5
        
        progressSlider.maximumTrackTintColor = .white
        progressSlider.bufferTrackTintColor = .lightGray
        progressSlider.minimumTrackTintColor = .red
        progressSlider.sliderHeight = 2
        progressSlider.isHideSliderBlock = true
        progressSlider.isSliderAllowTapped = false
        progressSlider.bufferValue = 0.6
        progressSlider.value = 0.4
        
        gradientSlider.maximumTrackTintColor = .white
        gradientSlider.sliderHeight = 6
        gradientSlider.bgCornerRadius = 3
        gradientSlider.value = 0.5
        gradientSlider.delegate = self
        gradientSlider.setBackgroundImage(UIImage(named: "cm2_fm_playbar_btn_dot"), for: .normal)
        gradientSlider.setThumbImage(UIImage(named: "cm2_fm_playbar_btn"), for: .normal)
        valueChange(for: gradientSlider, value: 0.5)
        
        customSlider.delegate = self
        customSlider.previewDelegate = self
        customSlider.maximumTrackTintColor = .white
        customSlider.minimumTrackTintColor = .red
        customSlider.sliderHeight = 2
        customSlider.sliderBtn.backgroundColor = .white
        customSlider.sliderBtn.layer.cornerRadius = 7
        customSlider.sliderBtn.layer.masksToBounds = true
        customSlider.sliderBtn.setTitle("00:00/01:00", for: .normal)
        customSlider.sliderBtn.setTitleColor(.black, for: .normal)
        customSlider.sliderBtn.titleLabel?.font = .systemFont(ofSize: 10)
        customSlider.sliderBtn.sizeToFit()
        var frame = customSlider.sliderBtn.frame
        frame.size.width += 4
        frame.size.height = 14
        customSlider.sliderBtn.frame = frame
        customSlider.value = 0
        
        wxSlider.sliderBtn.backgroundColor = .white
        wxSlider.sliderBtn.layer.masksToBounds = true
        wxSlider.delegate = self
        wxSlider.previewDelegate = self
        wxSlider.isPreviewChangePosition = false
        wxSlider.isSliderAllowDragged = true
        showSmallSlider()
        
        lineSlider.maximumTrackTintColor = .gray
        lineSlider.bufferTrackTintColor = .lightGray
        lineSlider.minimumTrackTintColor = .white
        lineSlider.sliderBtn.backgroundColor = .white
        lineSlider.sliderBtn.layer.cornerRadius = 10
        lineSlider.sliderBtn.layer.masksToBounds = true
        lineSlider.bufferValue = 0.7
        lineSlider.value = 0.4
        showLineLoading()
    }
    
    @objc func showSmallSlider() {
        var frame = wxSlider.sliderBtn.frame
        frame.size = CGSize(width: 8, height: 8)
        wxSlider.sliderHeight = 3
        wxSlider.sliderBtn.frame = frame
        wxSlider.sliderBtn.layer.cornerRadius = 4
    }
    
    func showLargeSlider() {
        var frame = wxSlider.sliderBtn.frame
        frame.size = CGSize(width: 20, height: 20)
        wxSlider.sliderHeight = 5
        wxSlider.sliderBtn.frame = frame
        wxSlider.sliderBtn.layer.cornerRadius = 10
    }
    
    func showChangeSlider() {
        if isShowChange { return }
        isShowChange = true
        var frame = wxSlider.sliderBtn.frame
        frame.size = CGSize(width: 10, height: 30)
        wxSlider.sliderHeight = 10
        wxSlider.sliderBtn.frame = frame
        wxSlider.sliderBtn.layer.cornerRadius = 5
        wxSlider.bgCornerRadius = 5
    }
    
    @objc func showLineLoading() {
        lineSlider.showLineLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.lineSlider.hideLineLoading()
            self.perform(#selector(self.showLineLoading), with: nil, afterDelay: 3.0)
        }
    }
    
    func gradientColor(_ colors: [UIColor], type: GradientType, size: CGSize) -> UIColor {
        if size.width == 0 || size.height == 0 { return .clear }
        let arr: [CGColor] = colors.map { $0.cgColor }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let space = colors.last?.cgColor.colorSpace
        let gradient = CGGradient(colorsSpace: space, colors: arr as CFArray, locations: nil)
        guard let gradient = gradient else { return .clear }
        var start: CGPoint = .zero
        var end: CGPoint = .zero
        
        switch type {
        case .topToBottom:
            start = .zero
            end = CGPoint(x: 0, y: size.height)
        case .leftToRight:
            start = .zero
            end = CGPoint(x: size.width, y: 0)
        case .upLeftToLowRight:
            start = .zero
            end = CGPoint(x: size.width, y: size.height)
        case .upRightToLowLeft:
            start = CGPoint(x: size.width, y: 0)
            end = CGPoint(x: 0, y: size.height)
        }
        context?.drawLinearGradient(gradient, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image ?? UIImage())
    }
}

extension ViewController: GKSliderDelegate {
    func touchBegan(for slider: GKSlider, value: Float) {
        if slider == wxSlider {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(showSmallSlider), object: nil)
            showLargeSlider()
        }
    }
    
    func touchEnded(for slider: GKSlider, value: Float) {
        if slider == wxSlider {
            isShowChange = false
            showLargeSlider()
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(showSmallSlider), object: nil)
            self.perform(#selector(showSmallSlider), with: nil, afterDelay: 3.0)
        }
    }
    
    func valueChange(for slider: GKSlider, value: Float) {
        if slider == gradientSlider {
            let width = gradientSlider.frame.size.width * CGFloat(value)
            let height = gradientSlider.frame.height
            let size = CGSize(width: width, height: height)
            gradientSlider.minimumTrackTintColor = gradientColor([.green, .blue], type: .leftToRight, size: size)
        }else if slider == customSlider {
            let totalTime: Float = 1 * 60
            let currentTime: Float = totalTime * value
            let total = timeFormatted(totalTime)
            let current = timeFormatted(currentTime)
            let text = current + "/" + total
            customSlider.sliderBtn.setTitle(text, for: .normal)
        }else if slider == wxSlider {
            showChangeSlider()
        }
    }
    
    func tapped(for slider: GKSlider, value: Float) {
        
    }
    
    func timeFormatted(_ ms: Float) -> String {
        let second = Int(ms)
        let hour = second / 3600
        let minutes = (second % 3600) / 60
        let seconds = (second % 3600) % 60
        return String(format: "%02d:%02d", hour * 60 + minutes, seconds)
    }
}

extension ViewController: GKSliderPreviewDelegate {
    func setupPreview(for slider: GKSlider) -> UIView? {
        if slider == customSlider {
            let preview = GKSliderButton()
            preview.backgroundColor = .white
            preview.layer.cornerRadius = 10
            preview.layer.masksToBounds = true
            preview.setTitle("00:00/01:00", for: .normal)
            preview.setTitleColor(.black, for: .normal)
            preview.titleLabel?.font = .systemFont(ofSize: 14)
            preview.sizeToFit()
            var frame = preview.frame
            frame.size.width += 6
            frame.size.height = 20
            preview.frame = frame
            return preview
        }else if slider == wxSlider {
            let preview = GKSliderButton()
            preview.setTitle("00:00 / 01:00", for: .normal)
            preview.setTitleColor(.white, for: .normal)
            preview.titleLabel?.font = .systemFont(ofSize: 15)
            preview.sizeToFit()
            var frame = preview.frame
            frame.size.width += 6
            frame.size.height += 10
            preview.frame = frame
            return preview
        }
        return nil
    }
    
    func previewMargin(for slider: GKSlider) -> CGFloat {
        if slider == customSlider {
            return 20
        }else if slider == wxSlider {
            return 80
        }
        return 0
    }
    
    func valueChanged(for slider: GKSlider, preview: UIView?, value: Float) {
        if slider == customSlider {
            guard let btn = preview as? GKSliderButton else { return }
            let totalTime: Float = 1 * 60
            let currentTime = totalTime * value
            let total = timeFormatted(totalTime)
            let current = timeFormatted(currentTime)
            let text = current + "/" + total
            btn.setTitle(text, for: .normal)
        }else if slider == wxSlider {
            guard let btn = preview as? GKSliderButton else { return }
            let totalTime: Float = 1 * 60
            let currentTime = totalTime * value
            let total = timeFormatted(totalTime)
            let current = timeFormatted(currentTime)
            let text = current + " / " + total
            btn.setTitle(text, for: .normal)
        }
    }
}

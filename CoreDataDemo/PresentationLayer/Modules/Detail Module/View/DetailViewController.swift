//
//  DetailNonViewerViewController.swift
//  CoreDataDemo
//
//  Created by Konstantin Porokhov on 15.07.2021.
//

import UIKit
import YouTubePlayer

protocol DetailViewControllerViewModelType {
    var slogan: Box<String?> { get }
    var name: Box<String?> { get }
    var about: Box<String?> { get }
    var urlString: Box<String?> { get }
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var player: YouTubePlayerView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var aboutLabel: UILabel?
    @IBOutlet weak var sloganLabel: UILabel?
    
    var viewModel: DetailViewControllerViewModelType? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillOutlets()
        player?.delegate = self
    }
    
    private func fillOutlets() {
        
        viewModel?.slogan.binde { [weak self] slogan in
            DispatchQueue.main.async {
                self?.sloganLabel?.text = slogan
            }
        }
        viewModel?.name.binde { [weak self] name in
            DispatchQueue.main.async {
                self?.nameLabel?.text = name
            }
        }
        viewModel?.about.binde { [weak self] about in
            DispatchQueue.main.async {
                self?.aboutLabel?.text = about
            }
        }
        playFullScreen(false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height {
            playFullScreen(true)
        }
    }
    
    private func playFullScreen(_ playsinline: Bool) {
        viewModel?.urlString.binde { [weak self] in
            guard let urlString = $0,
                  let url = URL(string: urlString) else { return }
            DispatchQueue.main.async {
                self?.player?.playerVars = [
                    "playsinline": playsinline ? "0" : "1",
                    "modestbranding": "1",
                    "controls": "0",
                    "showinfo": "0"
                ] as YouTubePlayerView.YouTubePlayerParameters
                self?.player?.loadVideoURL(url)
            }
        }
    }
}

extension DetailViewController: YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.play()
        
        let compositionFrame = videoPlayer.frame.width * videoPlayer.frame.height
        let compositionFrameView = self.view.frame.width * self.view.frame.height / 2
        
        if compositionFrame > compositionFrameView {
            videoPlayer.unMute()
        } else {
            videoPlayer.mute()
        }
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        if playerState == .Playing {
            UIView.animate(withDuration: 1) {
                self.sloganLabel?.alpha = 0
            }
        }
    }
}

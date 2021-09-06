//
//  TrailerCollectionViewCell.swift
//  Filmoteka
//
//  Created by Konstantin Porokhov on 05.08.2021.
//

import UIKit
import YouTubePlayer

protocol TrailerCollectionViewCellViewModelType {
    var urlString: Box<String?> { get }
    var name: String? { get }
}

class TrailerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerView: YouTubePlayerView?
    @IBOutlet weak var nameLabel: UILabel?
    
    var viewModel: TrailerCollectionViewCellViewModelType? {
        willSet {
            guard let newModel = newValue else { return }
            nameLabel?.text = newModel.name
            DispatchQueue.main.async { [unowned self] in
                playFullScreen(newModel, playsinline: true)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playerView?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func playFullScreen(_ viewModel: TrailerCollectionViewCellViewModelType, playsinline: Bool) {
        viewModel.urlString.binde { [weak self] in
            guard let urlString = $0,
                  let url = URL(string: urlString) else { return }
            DispatchQueue.main.async {
                self?.playerView?.playerVars = [
                    "playsinline": playsinline ? "0" : "1",
                    "modestbranding": "1",
                    "controls": "0",
                    "showinfo": "0"
                ] as YouTubePlayerView.YouTubePlayerParameters
                self?.playerView?.loadVideoURL(url)
            }
        }
    }
}

extension TrailerCollectionViewCell: YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.previousVideo()
    }
}

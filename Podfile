source 'https://github.com/CocoaPods/Specs.git'

# Uncomment the next line to define a global platform for your project
platform :ios, '14.3'
inhibit_all_warnings!

use_frameworks!

workspace 'TmdbMVP-UICode'

target 'domain' do
   # Provide path for module project file
   project './domain/domain.project'

  pod 'RxSwift',    '~> 6.0.0'
end

target 'data' do
   # Provide path for module project file
   project './data/data.project'

  pod 'RxSwift',    '~> 6.0.0'
end

target 'app_framework' do
  project './app_framework/app_framework.project'

  pod 'Alamofire', '~> 5.4.0'
  pod 'Kingfisher', '~> 4.10.1'

  pod 'SwifterSwift', '~> 5.2.0'
  pod 'SwiftyJSON', '~> 5.0.0'

  pod 'RxSwift',    '~> 6.0.0'
  pod 'SnapKit', '~> 5.7.1'
end

target 'feature_genre' do
  project './features/feature_genre/feature_genre.project'

  pod 'SVProgressHUD', '~> 2.2.5'
  pod 'RxSwift',    '~> 6.0.0'
  pod 'SnapKit', '~> 5.7.1'
end

target 'feature_movie_by_genre' do
  project './features/feature_movie_by_genre/feature_movie_by_genre.project'

  pod 'SVProgressHUD', '~> 2.2.5'
  pod 'RxSwift',    '~> 6.0.0'
  pod 'SnapKit', '~> 5.7.1'
end

target 'feature_movie_detail' do
  project './features/feature_movie_detail/feature_movie_detail.project'

  pod 'Kingfisher', '~> 4.10.1'
  pod 'SVProgressHUD', '~> 2.2.5'
  pod 'RxSwift',    '~> 6.0.0'
  pod 'SnapKit', '~> 5.7.1'
end

target 'feature_movie_review' do
  project './features/feature_movie_review/feature_movie_review.project'

  pod 'SVProgressHUD', '~> 2.2.5'
  pod 'RxSwift',    '~> 6.0.0'
  pod 'SnapKit', '~> 5.7.1'
end

target 'feature_movie_trailer' do
  project './features/feature_movie_trailer/feature_movie_trailer.project'

  pod 'SVProgressHUD', '~> 2.2.5'
  pod 'RxSwift',    '~> 6.0.0'

  pod 'YouTubePlayer'
  pod 'SnapKit', '~> 5.7.1'
end

target 'feature_error_message' do
  project './features/feature_error_message/feature_error_message.project'
end

target 'TmdbMVP-UICode' do
  # Comment the next line if you don't want to use dynamic frameworks

  # Pods for TmdbMVP-UICode
  pod 'Wormholy', '~> 1.6.4', configurations: ['Debug Staging', 'Debug Verify', 'Debug Production']
  pod 'AlamofireNetworkActivityLogger', '~> 3.4', configurations: ['Debug Staging', 'Debug Verify', 'Debug Production']
  pod 'Kingfisher', '~> 4.10.1'

  pod 'SVProgressHUD', '~> 2.2.5'

  pod 'SwifterSwift', '~> 5.2.0'
  pod 'SwiftyJSON', '~> 5.0.0'

  pod 'RxSwift',    '~> 6.0.0'

  pod 'Swinject', '2.8.3'

  pod 'YouTubePlayer'
  pod 'SnapKit', '~> 5.7.1'
end

target 'TmdbMVP-UICodeTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'TmdbMVP-UICodeUITests' do
  # Pods for testing
end

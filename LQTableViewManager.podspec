Pod::Spec.new do |s|
  s.name        = 'LQTableViewManager'
  s.version     = '2.1.3'
  s.authors     = { 'Little Queen' => 'anonymous.qsh@gmail.com' }
  s.homepage    = 'https://github.com/anonymous-qsh/LQTableViewManager'
  s.summary     = 'Powerful data driven content manager for UITableView based on RETableViewManager.'
  s.source      = { :git => 'https://github.com/anonymous-qsh/LQTableViewManager.git',
                    :tag => s.version.to_s }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'LQTableViewManager/Cells', 'LQTableViewManager/Items', 'LQTableViewManager', 'LQTableViewManager/Controllers', 'LQTableViewManager/Utils', 'LQTableViewManager/Utils/KNActionSheet', 'LQTableViewManager/Views'
  s.public_header_files = 'LQTableViewManager/Cells/*.h', 'LQTableViewManager/*.h', 'LQTableViewManager/Items/*.h', 'LQTableViewManager/Controllers/*.h', 'LQTableViewManager/Utils/*.h', 'LQTableViewManager/Utils/KNActionSheet/*.h', 'LQTableViewManager/Views/*.h'
  s.resource_bundle = { 'LQTableViewManager' => 'LQTableViewManager/Resources/*' }
  s.preserve_paths = 'LQTableViewManager/Resources'

  s.ios.deployment_target = '8.0'

  s.dependency 'REFormattedNumberField', '~> 1.1.5'
  s.dependency 'REValidation', '~> 0.1.4'
  s.dependency 'Masonry'
  s.dependency 'BlocksKit'
  s.dependency 'SDWebImage', '4.4.6'
  s.dependency 'MBProgressHUD'
  s.dependency 'LQUIColor', '0.1.0'
end

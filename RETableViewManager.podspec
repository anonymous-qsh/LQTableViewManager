Pod::Spec.new do |s|
  s.name        = 'RETableViewManager'
  s.version     = '1.7'
  s.authors     = { 'Little Queen' => 'anonymous.qsh@gmail.com' }
  s.homepage    = 'https://github.com/anonymous-qsh/LQTableViewManager'
  s.summary     = 'Powerful data driven content manager for UITableView based on RETableViewManager.'
  s.source      = { :git => 'https://github.com/anonymous-qsh/LQTableViewManager',
                    :tag => s.version.to_s }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'RETableViewManager/Cells', 'RETableViewManager/Items', 'RETableViewManager', 'RETableViewManager/Controllers', 'RETableViewManager/Utils'
  s.public_header_files = 'RETableViewManager/Cells/*.h', 'RETableViewManager/*.h', 'RETableViewManager/Items/*.h', 'RETableViewManager/Controllers/*.h', 'RETableViewManager/Utils/*.h'
  s.resource_bundle = { 'RETableViewManager' => 'RETableViewManager/Resources/*' }
  s.preserve_paths = 'RETableViewManager/Resources'

  s.ios.deployment_target = '7.0'

  s.dependency 'REFormattedNumberField', '~> 1.1.5'
  s.dependency 'REValidation', '~> 0.1.4'
  s.dependency 'Masonry'
end

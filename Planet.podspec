Pod::Spec.new do |s|
  s.name         = 'Planet'
  s.version      = '0.2.1'
  s.summary      = 'A country picker'
  s.description  = 'A country picker view controller'
  s.homepage     = 'https://github.com/kwallet/planet'

  s.license      = 'MIT'

  s.author       = {'Mikael Konutgan' => 'mikael@k-wallet.com'}

  s.source       = {git: 'https://github.com/kwallet/planet.git', tag: s.version}

  s.platform     = :ios, '9.0'

  s.source_files  = "Planet", 'Classes/**/*.{h,m,swift}'
  s.resources = 'Planet/Planet.xcassets'
end

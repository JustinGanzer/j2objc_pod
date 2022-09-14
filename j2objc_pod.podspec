Pod::Spec.new do |s|
  s.name = 'j2objc_pod'
  s.version = '0.9.5'
  s.summary = "J2ObjC's JRE emulation library, emulates a subset of the Java runtime library."
  s.homepage = 'http://j2objc.org'

  s.author = 'Pod by Justin Ganzer, J2OBJC by Google Inc'
  s.license = { :type => 'Apache-2.0', :file => 'LICENSE' }

  s.platform = :ios
  s.source = { :http => 'https://u247826.your-storagebox.de/ios/dependencies/j2objc/2.8a/bundle.zip' }

  s.ios.deployment_target = '12.0'
  s.static_framework = true
  s.requires_arc = false

  #s.preserve_paths = 'dist'
  #s.public_header_files = 'dist/include/**/*.h'
  #s.source_files = 'dist/include/**/*.h'
  #s.header_mappings_dir = 'dist/include'

  s.vendored_frameworks = 'JRE.xcframework', 'JSON.xcframework', 'ProtobufRuntime.xcframework'
  #s.vendored_libraries = 'dist/lib/*.a'

  #s.user_target_xcconfig = { 
  #  'LIBRARY_SEARCH_PATHS' => '${PODS_ROOT}/j2objc_pod/dist/lib',
  #  'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/j2objc_pod/dist/frameworks',
  #  'USER_HEADER_SEARCH_PATHS' => '${PODS_ROOT}/j2objc_pod/dist/include',
  #  'OTHER_LDFLAGS' => ['-liconv','-lz','-lc++','-ljre_emul','-lprotobuf_runtime','-ljson']
  #}

  s.user_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '${PODS_ROOT}/j2objc_pod/JRE.xcframework/Headers ${PODS_ROOT}/j2objc_pod/JSON.xcframework/Headers ${PODS_ROOT}/j2objc_pod/ProtobufRuntime.xcframework/Headers'
  }

  #s.prepare_command = 'scripts/download.sh'
end

=begin
If one of your pods contains files converted by j2objc, define the following settings in its podspec file:

// Your pod must declare its dependency on j2objc_pod 
s.dependency 'j2objc_pod', '~> 2.0'

// These settings are just an example, but with them you can set up the target build settings
// to include the necessary "Search Paths" and "Linker Flags"
s.pod_target_xcconfig = { 
    'OTHER_LDFLAGS' => ['-liconv','-lz','-lc++'],
    'LIBRARY_SEARCH_PATHS' => '${PODS_ROOT}/j2objc_pod/dist/lib',
    'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/j2objc_pod/dist/frameworks',
    'USER_HEADER_SEARCH_PATHS' => '${PODS_ROOT}/j2objc_pod/dist/include'
  }
  
=end
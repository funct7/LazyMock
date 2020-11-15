Pod::Spec.new do |spec|

  spec.name         = "LazyMock"
  spec.version      = "1.0.0"
  spec.summary      = "A poor man's mock library for Swift."
  spec.description  = <<-DESC
  `LazyMock` provides a poor man's mock library by providing base classes that can be used
  by clients of the library to create their simple mock test doubles.
                   DESC
  spec.homepage     = "https://github.com/funct7/LazyMock"
  spec.license      = "MIT"
  spec.author       = { "Josh Woomin Park" => "joshuaparkwm@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/funct7/LazyMock.git", :tag => "#{spec.version}" }
  spec.source_files  = "LazyMock/**/*.{h,m,swift}"
  spec.swift_versions = "5.0"
end

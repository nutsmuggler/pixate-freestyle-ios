Pod::Spec.new do |s|
  s.name         = "PixateFreestyle"
  s.version      = "2.1.4"
  s.summary      = "Style your iOS app with CSS, using 100% native code and no webviews."
  s.description  = <<-DESC
                   Pixate is an iOS framework that allows you to style your application using stylesheets and a CSS-like syntax. Pixate lets you build  beautiful applications with less code and more flexibility by using familiar CSS markup to style native controls and components. Free up your team to focus on creating amazing user experiences throughout the design and development cycle.
                   DESC
  s.homepage     = "http://www.pixate.com"
  s.license      = {
    :type => 'Apache 2.0',
    :text => <<-LICENSE
              Copyright © 2012-2014 Pixate, Inc.

              Licensed under the Apache License, Version 2.0 (the "License");
              you may not use this file except in compliance with the License.
              You may obtain a copy of the License at

                 http://www.apache.org/licenses/LICENSE-2.0

              Unless required by applicable law or agreed to in writing, software
              distributed under the License is distributed on an "AS IS" BASIS,
              WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
              See the License for the specific language governing permissions and
              limitations under the License.
             LICENSE
  }
  s.author       = { "Pixate" => "info@pixate.com" }
  s.platform     = :ios, '5.0'
  s.requires_arc = true  
  non_arc_files  = 'src/Kernel/Third-Party/MAFuture/*.{h,m}'  
  s.source   =  { :git => "https://github.com/Xaton/pixate-freestyle-ios.git", :branch => 'feature/lightweight', :submodules => true }  
  s.source_files = 'src/*.{h,m,c}', 'src/{Core,Framework,Kernel,Modules}/**/*.{h,m,c}', 'submodules/pixate-expression-machine/src/{EMCL,ExpressionMachine}/**/*.{h,m,c}'
  s.exclude_files = non_arc_files, 'src/pixate-freestyleTests/*', 'src/Core/Lumberjack/*', '**/*{test,tester,Tests}.{h,m}', '**/main.m'
  s.dependency 'CocoaLumberjack', '~> 2.0.0-beta4'

#  s.prefix_header_file = "src/pixate-freestyle-Prefix.pch"
  s.prefix_header_contents = '#define DDLEGACY YES', '#define DDLogInfo(...)', '#define DDLogVerbose(...)', '#define DDLogError(...)', '#define LOG_VERBOSE 0'
  s.frameworks = 'CoreText', 'QuartzCore', 'UIKit', 'CoreGraphics'
  
  s.prepare_command = <<-CMD
  	lex -oPXExpressionLexer.yy.m submodules/pixate-expression-machine/src/ExpressionMachine/Parsing/PXExpressionLexer.lm
  CMD

  s.subspec 'no-arc' do |sna|
    sna.requires_arc = false
    sna.source_files = non_arc_files
    sna.exclude_files = 'src/Kernel/Third-Party/MAFuture/tester.m'
  end
  
  s.subspec 'lex' do |lex|
    lex.requires_arc = false
    lex.source_files = 'PXExpressionLexer.yy.m'
  end
end
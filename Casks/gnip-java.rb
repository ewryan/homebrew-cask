class GnipJava < Cask
  url 'https://gnipit.s3.amazonaws.com/sprout/jdk-7u25-macosx-x64.dmg'
  version '1.7.0_25'
  sha1 '302164484e6d4dde1f64a658c155facc1130a1de'
  install 'JDK 7 Update 25.pkg'
  after_install do
    system "sudo /usr/libexec/PlistBuddy -c \"Add :JavaVM:JVMCapabilities: string BundledApp\" /Library/Java/JavaVirtualMachines/jdk#{version}.jdk/Contents/Info.plist"
    system "sudo /usr/libexec/PlistBuddy -c \"Add :JavaVM:JVMCapabilities: string JNI\" /Library/Java/JavaVirtualMachines/jdk#{version}.jdk/Contents/Info.plist"
    system "sudo /usr/libexec/PlistBuddy -c \"Add :JavaVM:JVMCapabilities: string WebStart\" /Library/Java/JavaVirtualMachines/jdk#{version}.jdk/Contents/Info.plist"
    system "sudo /usr/libexec/PlistBuddy -c \"Add :JavaVM:JVMCapabilities: string Applets\" /Library/Java/JavaVirtualMachines/jdk#{version}.jdk/Contents/Info.plist"
    system "sudo rm -r /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK 2> /dev/null"
    system "sudo ln -s /Library/Java/JavaVirtualMachines/jdk#{version}.jdk/Contents /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK"
  end
  uninstall :pkgutil => 'com.oracle.jdk7u25',
            :files => '/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK'
  caveats <<-EOS.undent
    This Cask makes minor modifications to the JRE to prevent any packaged
    application issues.

    If your Java application still asks for JRE installation, you might need to
    reboot or logout/login.

    The JRE packaging bug is discussed here:
    https://bugs.eclipse.org/bugs/show_bug.cgi?id=411361
  EOS
end
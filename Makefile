generate:
	mise exec -- tuist install
	mise exec -- tuist generate

clean:
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

reset:
	mise exec -- tuist clean
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

clean-spm:
	rm -rf ~/Library/Caches/org.swift.swiftpm
	rm -rf ~/Library/org.swift.swiftpm

if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which swiftlint > /dev/null; then
  swiftlint --config "$(dirname "$0")/.swiftlint.yml"
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

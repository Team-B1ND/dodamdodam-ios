if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which periphery > /dev/null; then
    cd ../../
    periphery scan --workspace ./DodamDodam.xcworkspace --schemes DodamDodam --targets DodamDodam DIContainer Shared Feature Network DataSource Local Repository --format xcode --report-exclude **/Derived/*.swift
    # Domain is not included

else
  echo "warning: Periphery not installed, download from https://github.com/peripheryapp/periphery"
fi

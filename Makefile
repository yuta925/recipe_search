# Recipe Search Makefile

# Flutter version to be used with fvm
FLUTTER_VERSION := stable  # Change this if you need a specific version

# Check if FVM is installed
check-fvm:
	@command -v fvm >/dev/null 2>&1 || { echo >&2 "FVM is not installed. Please install it first: dart pub global activate fvm"; exit 1; }

# Use FVM and specified Flutter version
fvm-use: check-fvm
	fvm use $(FLUTTER_VERSION)

# Install all necessary Flutter packages using fvm
install-packages: check-fvm
	fvm flutter pub add http
	fvm flutter pub add freezed
	fvm flutter pub add cached_network_image
	fvm flutter pub add flutter_dotenv
	fvm flutter pub add provider

# Run flutter pub get to install dependencies
get-deps: check-fvm
	fvm flutter pub get

# Run the app
run: check-fvm
	fvm flutter run

# Clean the build directory
clean:
	fvm flutter clean

# Complete setup: fvm use, install packages, get dependencies, and run the app
setup: fvm-use install-packages get-deps run

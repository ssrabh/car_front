#!/bin/bash

# 1. Download and Extract Flutter SDK
echo "Downloading Flutter SDK..."
curl -L 'https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz' | tar xJ

# 2. Add Flutter to the PATH
export PATH="$PATH:$PWD/flutter/bin"

# 3. Check installation (Optional)
flutter doctor

# 4. Run the actual build
echo "Running Flutter build..."
flutter build web --release

# 5. Render requires the script to exit successfully
echo "Build complete."
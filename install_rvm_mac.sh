#!/bin/bash

echo "🚀 Starting RVM installation on Mac..."
echo "======================================="

# Step 1 — Install Homebrew
echo ""
echo "Step 1: Installing Homebrew..."
if command -v brew &>/dev/null; then
  echo "✅ Homebrew already installed, skipping."
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "✅ Homebrew installed."
fi

# Step 2 — Install GnuPG
echo ""
echo "Step 2: Installing GnuPG..."
brew install gnupg
echo "✅ GnuPG installed."

# Step 3 — Import RVM GPG keys
echo ""
echo "Step 3: Importing RVM GPG keys..."
gpg --keyserver keyserver.ubuntu.com --recv-keys \
  409B6B1796C275462A1703113804BB82D39DC0E3 \
  7D2BAF1CF37B13E2069D6956105BD0E739499BDB
echo "✅ GPG keys imported."

# Step 4 — Install RVM
echo ""
echo "Step 4: Installing RVM..."
\curl -sSL https://get.rvm.io | bash -s stable
echo "✅ RVM installed."

# Step 5 — Load RVM in current session
echo ""
echo "Step 5: Loading RVM..."
source ~/.rvm/scripts/rvm
echo "✅ RVM loaded."

# Step 6 — Add RVM to shell profile
echo ""
echo "Step 6: Adding RVM to shell profile..."
SHELL_NAME=$(basename "$SHELL")
if [ "$SHELL_NAME" = "zsh" ]; then
  PROFILE="$HOME/.zshrc"
else
  PROFILE="$HOME/.bash_profile"
fi

if grep -q 'source ~/.rvm/scripts/rvm' "$PROFILE"; then
  echo "✅ RVM already in $PROFILE, skipping."
else
  echo 'source ~/.rvm/scripts/rvm' >> "$PROFILE"
  echo "✅ RVM added to $PROFILE."
fi
source "$PROFILE"

# Step 7 — Verify RVM
echo ""
echo "Step 7: Verifying RVM installation..."
rvm --version
echo "✅ RVM is working."

# Step 8 — Install latest Ruby
echo ""
echo "Step 8: Installing latest Ruby..."
rvm install ruby --latest
rvm use ruby --latest --default
echo "✅ Ruby installed."

# Done
echo ""
echo "======================================="
echo "🎉 All done! Ruby version installed:"
ruby -v
echo ""
echo "Restart your terminal or run:"
echo "  source $PROFILE"
#!/bin/bash

# Idempotent macOS system preferences.
# Run after a fresh install or whenever you tweak preferences.
#
# Manual steps that can't be reliably automated:
#   - Keyboard Modifiers: Caps Lock → Control
#   - Keyboard Shortcuts / App: Cmd-Shift-M → Zoom
#   - Sharing: Allow Remote Login (sshd)

set -e

osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true
sleep 1

###############################################################################
# Trackpad                                                                    #
###############################################################################

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.0

###############################################################################
# Dock                                                                        #
###############################################################################

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0

###############################################################################
# Keyboard & Text                                                            #
###############################################################################

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

###############################################################################
# Animations                                                                  #
###############################################################################

defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0
defaults write NSGlobalDomain NSScrollViewRubberbanding -bool false
defaults write NSGlobalDomain NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write NSGlobalDomain NSToolbarFullScreenAnimationDuration -float 0
defaults write NSGlobalDomain NSBrowserColumnAnimationSpeedMultiplier -float 0

###############################################################################
# Accessibility                                                               #
###############################################################################

defaults write com.apple.Accessibility ReduceMotionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

defaults write com.apple.finder DisableAllAnimations -bool true

###############################################################################
# Restart affected applications                                               #
###############################################################################

killall Dock
killall Finder

echo "Done. Some changes require a logout or restart to take effect."
